function resultados(path_projF,direccion,nombre,column)

	path_col = strcat(path_projF,'pre_proceso\','columna_',num2str(column),'\columna_',num2str(column),'.mat');
	path_dat = load(path_col,'sElemX','numLayers','waterTable','famp','motionDT','motionStep');
	
	% carga archivos de coordenadas de nodos
	path_nodes = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\ppNodesInfo.dat');
	nodes = load (path_nodes);
	
	path_Gesf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstress9.out');
	path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');
	path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');
	stress = importdata(path_Gesf);
    filas = size(stress,1);
	esfYIni = importdata(path_Gesf);
	esf9 = importdata(path_esf);
	def9 = importdata(path_def);
	
	% path para presion de poros
	path_Gpore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\velocidades','\GporePressure.out');
	path_pore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\velocidades','\porePressure.out');
	% cargar archivos para presion de poros
	gpwp = importdata(path_Gpore);
	poreI = importdata(path_Gpore);
	ppwp = importdata(path_pore);
	
	path_despx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementx.out');
	% cargar archivos para desplazamientos en x
	disX = importdata(path_despx);
	
	path_acelx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationx.out');
	% cargar archivos para aceleraciones en x
	accX = importdata(path_acelx);
	
	sElemX     = path_dat.sElemX;
	numLayers  = path_dat.numLayers;
	waterTable = path_dat.waterTable;
	famp       = path_dat.famp;
	motionDT   = path_dat.motionDT;
	motionStep = path_dat.motionStep;
	prof = sortrows(nodes(:,3),-1);
	profT = prof(1);
	
	
% Normalizacion de la presion de poro 

tiempDin =ppwp(:,1);

% adjust time on gravity analysis
gpwp(:,1) = 1e-8*gpwp(:,1);

% combine into single array
pwp = [gpwp;ppwp];
clear gpwp ppwp

% transformation to GiD format
time = pwp(:,1);
pwp(:,1) = [];
[nStep,nEsf] = size(pwp);
nNode = nEsf;


stress(:,1) = [];
stress = stress(1,:)';
[m,n] = size(stress);
nElem = m/5;
sig = reshape(stress, 5, nElem);
clear stress


% write stress as 6x1 tensor representation
sten = zeros(6,nElem);
for k = 1:nElem
    for j = 1:4
        sten(j,k) = sig(j,k);
    end
end
clear sig
% trace of stress
I1 = zeros(nElem,1);
for k = 1:nElem
    I1(k) = sum(sten(1:3,k),1);
end
% mean stress
mStress = -I1/3;
clear I1

% average stresses at nodal depths
P = zeros(nElem-1,1);
sigV = P;
for k = 1:(nElem-1)
    P(k) = (mStress(k)+mStress(k+1))/2;
    sigV(k) = (sten(2,k)+sten(2,k+1))/2;
end

% location of mean stress values
vInfo = sort(unique(nodes(:,3)),'ascend');
% vertical element size
vsize = vInfo(1)-vInfo(2);

% extrapolate first and last points
f = mStress(1) - ((mStress(2)-mStress(1))/vsize)*(vsize/2);
l = mStress(end) + ((mStress(end)-mStress(end-1))/vsize)*(vsize/2);
P = [f;P;l];
f = sten(2,1) - ((sten(2,2)-sten(2,1))/vsize)*(vsize/2);
l = sten(2,end) - ((sten(2,end) - sten(2,end-1))/vsize)*(vsize/2);
sigV = [f;sigV;l];
clear mStress

% excess pore pressure
for k = 1:nStep
    exPwp(k,:) = abs(pwp(k,:) - pwp(1,:));
end

id1 = abs(exPwp)<1e-6;
exPwp(id1) = 0.0;

% compute pore pressure ratio
ru = zeros(nStep,nNode);
ru2 = ru;
for k = 1:nNode
    for j = 1:length(P)
        if (nodes(k,3)==vInfo(j))
            ru(:,k) = exPwp(:,k)/abs(P(j));
            ru2(:,k) = exPwp(:,k)/abs(sigV(j));
            
            break
        end
    end
end

%disp(tiempDin)
RPPdin = ru2;
RPPdin(1:filas,:) = [];
RPP = [tiempDin,RPPdin];
% save RPP.out RPP -ascii
[filaRPP,colRPP]=size(RPP);

%Para seleccionar el rango de profundidades donde se ha activado licuefacci?n
RPPL=RPP;
%Reemplaza con 0 valores < 0.6 en RPPL
for k=1:filaRPP
    for j=2:colRPP
        if RPPL(k,j)<= 0.6
            RPPL(k,j) = 0;
        end
    end
end
% save RPPL.out RPPL -ascii


%Acumular las alturas de cada linea
tiempoTT = motionDT*motionStep;

file1 = strcat(direccion,nombre,'_Zonas_de_Licuefacción_',int2str(column),'.dat');
file2 = strcat(direccion,nombre,'_Valores_Máximos_',int2str(column),'.dat');
clear(direccion,nombre)
fecha = datetime('now');
resultados = fopen(file1,'w');

fprintf(resultados,'                "UNIVERSIDAD TÉCNICA PARTICULAR DE LOJA"\n');
fprintf(resultados,'                    "TITULACIÓN DE INGENIERÍA CIVIL"\n');
fprintf(resultados,'            LABORATORIO VIRTUAL DE INGENIERÍA SÍSMICA (VLEE)\n\n');
fprintf(resultados,'EXPERIMENTO:	Modelación del efecto de licuefacción en una columna de suelo\n\n');
fprintf(resultados,'DESCRIPCIÓN:	Registro de los instantes de tiempo y profundidad en los cuales\n');
fprintf(resultados,'                el exceso de presión de poros sobrepasa el limite de 0.60, y se\n');
fprintf(resultados,'                presenta licuefacción inicial en la columna de suelo\n\n');
fprintf(resultados,'FECHA:      	%s\n\n\n',datestr(now));
fprintf(resultados,'-------------------------------------------------------------------------------\n');
fprintf(resultados,'DATOS DE ENTRADA:\n\n');
fprintf(resultados,'                Parámetro         |   Magnitud    |    Unidad  \n');
fprintf(resultados,'  -----------------------------------------------------------\n');
fprintf(resultados,'    Altura                        |       %.2f   |    m\n',profT);
fprintf(resultados,'    Ancho                         |       %.2f    |    m\n',sElemX);
fprintf(resultados,'    Profundidad N.F.              |       %.2f    |    m\n',waterTable);
fprintf(resultados,'    Número de estratos            |       %.2f    |    \n',numLayers);
fprintf(resultados,'    Intensidad Carga Sísmica      |       %.2f    |    \n',famp);
fprintf(resultados,'    dT de Carga Sísmica           |       %.3f   |    s\n\n\n',motionDT);
fprintf(resultados,'-------------------------------------------------------------------------------\n');
fprintf(resultados,'DATOS DE SALIDA:\n\n\n');
fprintf(resultados,'Columna A: Instante de tiempo en que ru > 0.60 (s)\n');
fprintf(resultados,'Columna B: Profundidad inicial, medido desde la superficie (m)\n');
fprintf(resultados,'Columna C: Profundidad final, medida desde la superficie (m)\n');
fprintf(resultados,'Columna D: Espesor del estrato licuado (m)\n');
fprintf(resultados,'Columna E: Estrato inicial de licuefacción\n');
fprintf(resultados,'Columna F: Estrato final de licuefacción\n\n\n');

fprintf(resultados,'%s\t %s\t %s\t %s\t %s\t %s\n\n','Columna A','Columna B','Columna C',...
                    'Columna D','Columna E','Columna F');
ubicacionI =[] ;
ubicacionF = [];
estI = [];
estF = [];
ti = [];
[filaRPPL,colRPPL]=size(RPPL);
for k=1:filaRPPL
    suma = 0;
    for j=4:colRPPL
        suma = suma + RPPL(k,j-2)+RPPL(k,j-1)+RPPL(k,j);
        %Ubicacion final
        if RPPL(k,j-2)+RPPL(k,j-1) < RPPL(k,j-1)+RPPL(k,j)
            ubicacionF = profT-((j+2)* profT)/(colRPP-1);
            ti = (k*tiempoTT)/filaRPPL;
        end
        %Ubicacion inicial
        if RPPL(k,j-2)+RPPL(k,j-1) > RPPL(k,j-1)+RPPL(k,j)
            ubicacionI = profT-((j+1)* profT)/(colRPP-1);  
        end
        
    end
    
    % Obtiene el estrato INICIAL
    mI = size(ubicacionI);
    for p=1:mI
        x1 = ubicacionI(p,1);
        for q=1:nEst
            y = A(q,2);
            if x1 < y
                estI = ['Estrato ',num2str(q)];
                break
            end
        end
    end
    
    % Obtiene el estrato FINAL    
    for p=1:mI
        x2 = ubicacionF(p,1);
        for q=1:nEst
            y = A(q,2);
            if x2 < y
                estF = ['Estrato ',num2str(q)];
                break
            end
        end
    end
    
    

    ProfLicuable = ubicacionF - ubicacionI;
    if suma > 0 
    fprintf(resultados,'%f\t %f\t %f\t %f\t %s\t %s\n',ti,ubicacionI,ubicacionF,ProfLicuable,estI,estF);
    end
    
end
fprintf(resultados,'\n');
fprintf(resultados,'-------------------------------------------------------------------------------');
fclose(resultados); 




%%%%%%%%%%%%%%%%%% Desplazamiento %%%%%%%%%%%%%%%%%%

ttotal = disX(:,1);
tfinal = disX(end,1);
disX(:,1) = [];
%despl. base
disBase = abs((disX(1,end)-disX(1,1))*1000);
tDBase = tfinal(end);
disSigno = sign(disX);

[tamX,tamY] = size(disX);
for i = 1:tamX
    a1 = disX(i,1);
    for j = 1:tamY
        disX(i,j) = abs(disX(i,j))-abs(a1);
        disX(i,j) = disX(i,j) * disSigno(i,j);
    end
end
disX = abs(disX);
disxMax = max(max((disX)));
[iD,jD] = find(((disX)==max(max((disX)))));
dMax = disxMax*1000;
profD = (profT-((max(jD)*profT)/(tamY)));
tiempoD = (max(iD)*tfinal)/(tamX);

%despl. mitad
mitad = round(tamY/2);
disMitad = max(disX(:,mitad));
[iMitad,jMitad] = ind2sub(size(disX),find(disX==disMitad));
disMitad = max(disX(:,mitad))*1000;
tDMitad = ttotal(min(iMitad),1);
%despl. superficie
disSup = max(disX(:,end));
[iSup,jSup] = ind2sub(size(disX),find(disX==disSup));
disSup = max(disX(:,end))*1000;
tDSup = ttotal(min(iSup),1);


%%%%%%%%%%%%%%%%%% Aceleracion %%%%%%%%%%%%%%%%%%
accX = abs(accX);
accX(:,1) = [];

accMax = max(max((accX)));
[iA,jA] = find(((accX)==max(max((accX)))));
profA = profT-((median(jA)*profT)/(tamY));
tiempoA = (median(iA)*tfinal)/(tamX);

%accel. base
accBase = max(accX(:,1));
[iABase,jnula] = ind2sub(size(accX),find(accX==accBase));
tABase = ttotal(min(iABase),1);
%accel. mitad
mitad = round(tamY/2);
accMitad = max(accX(:,mitad));
[iAMitad,jnula] = ind2sub(size(accX),find(accX==accMitad));
tAMitad = ttotal(min(iAMitad),1);
%accel. superficie
accSup = max(accX(:,end));
[iASup,jnula] = ind2sub(size(accX),find(accX==accSup));
tASup = ttotal(min(iASup),1);

%%%%%%%%%%%%%%%%%% Presion de Poros %%%%%%%%%%%%%%%%%%
pore = RPP;
pore(:,1) = [];

poreMax = max(max((pore)));
[iP,jP] = find(((pore)==max(max((poreMax)))));
profP = profT-((median(jP)*profT)/(tamY));
tiempoP = (median(iP)*tfinal)/(tamX);

%pore base
poreBase = max(pore(:,1));
[iPBase,jnula] = ind2sub(size(pore),find(pore==poreBase));
tPBase = ttotal(min(iPBase),1);
% %accel. mitad
mitad = round(tamY/2);
poreMitad = max(pore(:,mitad));
[iPMitad,jnula] = ind2sub(size(pore),find(pore==poreMitad));
tPMitad = ttotal(min(iPMitad),1);
%accel. superficie
poreSup = max(pore(:,end));
[iPSup,jnula] = ind2sub(size(pore),find(pore==poreSup));
tPSup = ttotal(min(iPSup),1);
 
%%%%%%%%%%%%%%%%%% tension efectiva Y; Esfuerzo de Corte XY %%%%%%%%%%%%%%%%%%
ttotal2 = esf9(:,1);
esf9(:,1) = [];

esfY =esf9(:,2:5:end);
esfY = abs(esfY);
esfXY =esf9(:,4:5:end);
esfXY = abs(esfXY);
[tamXX,tamYY] = size(esfY);

esfYMax = max(max((esfY)));
[ieY,jeY] = find(((esfY)==max(max((esfY)))));
profeY = profT-((max(jeY)*profT)/(tamYY));
tiempoeY = (max(ieY)*tfinal)/(tamXX);

%tension efectiva base
esfYBase = max(esfY(:,1));
[iEYBase,jnula] = ind2sub(size(esfY),find(esfY==esfYBase));
tEYBase = ttotal2(max(iEYBase),1);
%tension efectiva mitad
mitad = round(tamYY/2);
esfYMitad = max(esfY(:,mitad));
[iEYMitad,jnula] = ind2sub(size(esfY),find(esfY==esfYMitad));
tEYMitad = ttotal2(max(iEYMitad),1);
%tension efectiva superficie
esfYSup = max(esfY(:,end));
[iEYSup,jnula] = ind2sub(size(esfY),find(esfY==esfYSup));
tEYSup = ttotal2(max(iEYSup),1);


esfXYMax = max(max((esfXY)));
[ieXY,jeXY] = find(((esfXY)==max(max((esfXY)))));
profeXY = profT-((max(jeXY)*profT)/(tamYY));
tiempoeXY = (max(ieXY)*tfinal)/(tamXX);

%esf. de corte base
esfXYBase = max(esfXY(:,1));
[iEXYBase,jnula] = ind2sub(size(esfXY),find(esfXY==esfXYBase));
tEXYBase = ttotal2(min(iEXYBase),1);
%esf. de corte mitad
mitad = round(tamYY/2);
esfXYMitad = max(esfXY(:,mitad));
[iEXYMitad,jnula] = ind2sub(size(esfXY),find(esfXY==esfXYMitad));
tEXYMitad = ttotal2(min(iEXYMitad),1);
%esf. de corte superficie
esfXYSup = max(esfXY(:,end));
[iEXYSup,jnula] = ind2sub(size(esfXY),find(esfXY==esfXYSup));
tEXYSup = ttotal2(min(iEXYSup),1);

%%%%%%%%%%%%%%%%%% Deformacion XY %%%%%%%%%%%%%%%%%%
def9(:,1) = [];

defXY = def9(:,3:3:end);
defXY = abs(defXY);

defXYMax = max(max((defXY)))*100;
[idXY,jdXY] = find(((defXY)==max(max((defXY)))));
profdXY = profT-((median(jdXY)*profT)/(tamYY));
tiempodXY = (median(idXY)*tfinal)/(tamXX);

%deformacion base
defXYBase = max(defXY(:,1));
[idXYBase,jnula] = ind2sub(size(defXY),find(defXY==defXYBase));
defXYBase = defXYBase * 100;
tdXYBase = ttotal(min(idXYBase),1);
%deformacion mitad
mitad = round(tamYY/2);
defXYMitad = max(defXY(:,mitad));
[idXYMitad,jnula] = ind2sub(size(defXY),find(defXY==defXYMitad));
defXYMitad = defXYMitad * 100;
tdXYMitad = ttotal(min(idXYMitad),1);
%deformacion superficie
defXYSup = max(defXY(:,end));
[idXYSup,jnula] = ind2sub(size(defXY),find(defXY==defXYSup));
defXYSup = defXYSup * 100;
tdXYSup = ttotal(min(idXYSup),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Valores de los diversos parametros para Ru max
%%%%% Desplazamiento
DatoX = round(median(iP));
DatoY = round(median(jP));
desRu = max(disX(DatoX,:));
[inula,jdesRu] = ind2sub(size(disX),find(disX==desRu));
desRu = desRu*1000;
profdesRu = profT - ((min(jdesRu)*profT)/(tamY));
% tdesRu = tiempoP;

%%%%% Aceleracion
accRu = max(accX(DatoX,:));
[inula,jaccRu] = ind2sub(size(accX),find(accX==accRu));
profaccRu = profT - ((min(jaccRu)*profT)/(tamY));
su = inula*2;
% taccRu = tiempoP;

%%%%% Esfuerzo Efectivo Y
esfYRu = max(esfY(DatoX,:));
[inula,jesfYRu] = ind2sub(size(esfY),find(esfY==esfYRu));
profesfYRu = profT - ((min(jesfYRu)*profT)/(tamYY));
su = inula*2;
% tesfYRu = tiempoP;

%%%%% Esfuerzo de Corte XY
esfXYRu = max(esfXY(DatoX,:));
[inula,jesfXYRu] = ind2sub(size(esfXY),find(esfXY==esfXYRu));
profesfXYRu = profT - ((min(jesfXYRu)*profT)/(tamYY));
su = inula*2;
% tesfXYRu = tiempoP;

%%%%% Deformacion XY
defXYRu = max(defXY(DatoX,:));
[inula,jdefXYRu] = ind2sub(size(defXY),find(defXY==defXYRu));
defXYRu = defXYRu*100;
profdefXYRu = profT - ((min(jdefXYRu)*profT)/(tamYY));
% tdefXYRu = tiempoP;
su = inula*2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Presion de Confinamiento Inicial y Presion de Poros Inicial

esfYIni(:,1) = [];
esfYIni =esfYIni(:,2:5:end);
esfYIni =abs(esfYIni);
[xConf,yConf] = size(esfYIni);
profC = DatoY;
if profC > yConf
    profC = yConf;
end
presionConfI = esfYIni(1,profC);
presionConfF = abs(sigV(DatoY,1));

poreI(:,1) = [];
poreI = poreI(1,:);
poreIni = poreI(1,DatoY);
exPwp(1:filas,:) = [];
poreFin = exPwp(DatoX,DatoY);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maximos = fopen(file2,'w');

fprintf(maximos,'                "UNIVERSIDAD TÉCNICA PARTICULAR DE LOJA"\n');
fprintf(maximos,'                    "TITULACIÓN DE INGENIERÍA CIVIL"\n');
fprintf(maximos,'            LABORATORIO VIRTUAL DE INGENIERÍA SÍSMICA (VLEE)\n\n');
fprintf(maximos,'EXPERIMENTO:	Modelación del efecto de licuefacción en una columna de suelo\n\n');
fprintf(maximos,'DESCRIPCIÓN:	Registro de los valores máximos alcanzados durante la modelación\n');
fprintf(maximos,'              en los parámetros geotécnicos de la columna de suelo\n\n');
fprintf(resultados,'FECHA:      	%s\n\n\n',datestr(now));
fprintf(maximos,'-------------------------------------------------------------------------------\n');
fprintf(maximos,'DATOS DE ENTRADA:\n\n');
fprintf(maximos,'                Parámetro         |   Magnitud    |    Unidad  \n');
fprintf(maximos,'  -----------------------------------------------------------\n');
fprintf(resultados,'    Altura                        |       %.2f   |    m\n',profT);
fprintf(resultados,'    Ancho                         |       %.2f    |    m\n',sElemX);
fprintf(resultados,'    Profundidad N.F.              |       %.2f    |    m\n',waterTable);
fprintf(resultados,'    Número de estratos            |       %.2f    |    \n',numLayers);
fprintf(resultados,'    Intensidad Carga Sísmica      |       %.2f    |    \n',famp);
fprintf(resultados,'    dT de Carga Sísmica           |       %.3f   |    s\n\n\n',motionDT);
fprintf(maximos,'-------------------------------------------------------------------------------\n');
fprintf(maximos,'DATOS DE SALIDA:\n\n\n');
fprintf(maximos,'***********************************************************\n');
fprintf(maximos,'           VALORES MAXIMOS EN TODA LA COLUMNA\n');
fprintf(maximos,'***********************************************************\n\n');
fprintf(maximos,'Orden de los Datos: \n-IZQ:  Parametro (unidad) \n-CENTRO: Profundidad (desde la superficie, en m)\n-DER:  Tiempo (seg)\n');
fprintf(maximos,'-----------------------------------------------------------\n\n');
fprintf(maximos,'Desplazamiento maximo en toda la columna (mm)\n');
fprintf(maximos,'%10.2f \t%10.2f \t%10.2f\n\n',dMax,profD,tiempoD);
fprintf(maximos,'Aceleracion maxima en toda la columna (m/s2)\n');
fprintf(maximos,'%10.2f \t%10.2f \t%10.2f \n\n',accMax,profA,tiempoA);
fprintf(maximos,'Exceso de presion de poro maximo en toda la columna (adim)\n');
fprintf(maximos,'%10.2f \t%10.2f \t%10.2f \n\n',poreMax,profP,tiempoP);
fprintf(maximos,'Tension efectiva vertical (Y) maxima en toda la columna(kPa)\n');
fprintf(maximos,'%10.2f \t%10.2f \t%10.2f \n\n',esfYMax,profeY,tiempoeY);
fprintf(maximos,'Esfuerzo de Corte XY maximo en toda la columna(kPa)\n');
fprintf(maximos,'%10.2f \t%10.2f \t%10.2f \n\n',esfXYMax,profeXY,tiempoeXY);
fprintf(maximos,'Deformacion (Distorsion) XY(%%) maximo en toda la columna \n'); 
fprintf(maximos,'%10.2f \t%10.2f \t%10.2f \n\n\n\n',defXYMax,profdXY,tiempodXY);
fprintf(maximos,'***********************************************************\n');
fprintf(maximos,'VALORES MAXIMOS PARA H = 0 - 1/2 - 1 Y PARA TIEMPO = RuMAX\n');
fprintf(maximos,'***********************************************************\n\n');
fprintf(maximos,'Orden de los Datos:\n\n\tPARA RU MAX \n-IZQ: Parametro (unidad) \n-DER: Prof. (m, desde la superficie)\n');
fprintf(maximos,'\tPARA MAXIMOS \n-IZQ: Parametro (unidad) \n-DER: Tiempo (seg)\n');
fprintf(maximos,'-----------------------------------------------------------\n\n');
fprintf(maximos,'Desplazamiento para RuMax (mm): \n%10.2f \t%10.2f\n\n',desRu,profdesRu);
fprintf(maximos,'Desplazamiento max(mm) \t0H \n%10.2f \t%10.2f \n\n',disSup,tDSup);
fprintf(maximos,'Desplazamiento max (mm) \tH/2 \n%10.2f \t%10.2f \n\n',disMitad,tDMitad);
fprintf(maximos,'Desplazamiento max (mm) \tH \n%10.2f \t%10.2f \n\n',disBase,tDBase);
fprintf(maximos,'------------------------------\n');
fprintf(maximos,'Aceleracion para RuMax (m/s2): \n%10.2f \t%10.2f\n\n',accRu,profaccRu);
fprintf(maximos,'Acelereracion max(m/s2) \t0H \n%10.2f \t%10.2f \n\n',accSup,tASup);
fprintf(maximos,'Acelereracion max(m/s2) \tH/2 \n%10.2f \t%10.2f \n\n',accMitad,tAMitad);
fprintf(maximos,'Acelereracion max(m/s2)\tH \n%10.2f \t%10.2f \n\n',accBase,tABase);
fprintf(maximos,'------------------------------\n');
fprintf(maximos,'Tension Efectiva para RuMax (KPa): \n%10.2f \t%10.2f\n\n',esfYRu,profesfYRu);
fprintf(maximos,'Tension Efectiva ''Y'' (KPa) max \t0H \n%10.2f \t%10.2f \n\n',esfYSup,tEYSup);
fprintf(maximos,'Tension Efectiva ''Y'' (KPa) max \tH/2 \n%10.2f \t%10.2f \n\n',esfYMitad,tEYMitad);
fprintf(maximos,'Tension Efectiva ''Y'' (KPa) max \tH \n%10.2f \t%10.2f \n\n',esfYBase,tEYBase);
fprintf(maximos,'------------------------------\n');
fprintf(maximos,'Esfuerzo de Corte para RuMax (KPa): \n%10.2f \t%10.2f\n\n',esfXYRu,profesfXYRu);
fprintf(maximos,'Esfuerzo de Corte max ''XY'' (KPa) max \t0H \n%10.2f \t%10.2f \n\n',esfXYSup,tEXYSup);
fprintf(maximos,'Esfuerzo de Corte max ''XY'' (KPa) max \tH/2 \n%10.2f \t%10.2f \n\n',esfXYMitad,tEXYMitad);
fprintf(maximos,'Esfuerzo de Corte max ''XY'' (KPa) max \tH \n%10.2f \t%10.2f \n\n',esfXYBase,tEXYBase);
fprintf(maximos,'------------------------------\n');
fprintf(maximos,'Deformacion ''XY'' para RuMax (%%): \n%10.2f \t%10.2f\n\n',defXYRu,profdefXYRu);
fprintf(maximos,'Deformacion ''XY'' (%%) max \t0H \n%10.2f \t%10.2f \n\n',defXYSup,tdXYSup);
fprintf(maximos,'Deformacion ''XY'' (%%) max \tH/2 \n%10.2f \t%10.2f \n\n',defXYMitad,tdXYMitad);
fprintf(maximos,'Deformacion ''XY'' (%%) max \tH \n%10.2f \t%10.2f \n\n\n\n',defXYBase,tdXYBase);
fprintf(maximos,'***********************************************************\n');
fprintf(maximos,'RESULTADOS DE PR. CONFINAMIENTO Y PRESION PORO PARA RU MAX\n');
fprintf(maximos,'***********************************************************\n\n');
fprintf(maximos,'Confinam.Ini (KPa) \t Conf. en RuMax (KPa)\n');
fprintf(maximos,'%10.2f      \t%10.2f \n\n\n',presionConfI,presionConfF);
fprintf(maximos,'Pr.Poros Inicial (KPa) \t Pr. Poros para RuMax (KPa)\n');
fprintf(maximos,'%10.2f      \t%10.2f \n\n',poreIni,poreFin);
fprintf(maximos,'-------------------------------------------------------------------------------');
fclose(maximos);



