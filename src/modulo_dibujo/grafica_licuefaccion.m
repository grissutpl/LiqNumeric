
function grafica_licuefaccion(path_projF,column,profD,idioma)

	% path para esfuerzos y deformaciones
	path_Gesf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstress9.out');
	path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');
	path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');
	% cargar archivos para esfuerzos xx
	Gesf = importdata(path_Gesf);
	esf = importdata(path_esf);
	def = importdata(path_def);
	
	% path para nodos
	path_nodes = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\ppNodesInfo.dat');
	% carga archivos de nodos
	nodes = load (path_nodes);
	
	% path para presion de poros
	path_Gpore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\velocidades','\GporePressure.out');
	path_pore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\velocidades','\porePressure.out');
	% cargar archivos para presion de poros
	Gpore = importdata(path_Gpore);
	pore = importdata(path_pore);
	
	esf(:,1) = [];
	def(:,1) = [];
	
	% obtenciÃ³n de valores mÃ¡ximos minimos y datos para representar
	
	esfC = esf(:,4:5:end); 
	esfV = esf(:,2:5:end); 
	Defo = def(:,3:3:end);

	maxEsfC = max(esfC(:))+1;
	minEsfC = min(esfC(:))-1;
	maxEsfV = max(esfV(:));
	minEsfV = min(esfV(:));
	maxDef = 100*max(Defo(:))+0.1;
	minDef = 100*min(Defo(:))-0.1;
	
	% adjust time on gravity analysis
	Gpore(:,1) = 1e-8*Gpore(:,1);
	
	% combine into single array
	poreT = [Gpore;pore];
	clear Gpore pore
	clear esf def
	
	% transformation to GiD format
	time = poreT(:,1);
	poreT(:,1) = [];
	[nStep,nEsf] = size(poreT);
	nNode = nEsf;

	Gesf(:,1) = [];
	stress = Gesf(1,:)';
	[m,n] = size(stress);
	nElem = m/5;
	sig = reshape(stress,5,nElem);
	clear stress Gesf

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
		exPore(k,:) = abs(poreT(k,:) - poreT(1,:));
	end

	id1 = abs(exPore)<1e-6;
	exPore(id1) = 0.0;

	% compute pore pressure ratio
	ru = zeros(nStep,nNode);
	ru2 = ru;
	for k = 1:nNode
		for j = 1:length(P)
			if (nodes(k,3)==vInfo(j))
				ru(:,k) = exPore(:,k)/abs(P(j));
				ru2(:,k) = exPore(:,k)/abs(sigV(j));
				
				break
			end
		end
	end

	% Obtencion de datos preliminares

    nEsf = size(esfC,2);
    profU = profD;
	ordenar = sortrows(nodes(:,3),-1);
    profTS = ordenar(1);

	% Comprobando que la profundidad no supere la altura de la columna
    
    if profU > profTS
        if idioma==1
            msgbox({'El dato ingresado supera la altura total de la columna de suelo.'...
                   '',...
                   ['La profundidad maxima es: ' num2str(profTS) ' m']},'Error','error');  
        elseif idioma==2
            msgbox({'The entered value is higher than the soil column height.'...
                   '',...
                   ['The maximun value is: ' num2str(profTS) ' m']},'Error','error');  
        end
        
    else
        
        profU = abs(profTS-profU);

		% Comprobacion: caso en que profundidad es 0 metros
        if  profU == 0
            %%% GRAFICAS para la profundidad 0 metros        
            col = 1;
			
        elseif profU == profTS	
		
			col = size(esfC,2);
        else
		
			col = floor((profU*nEsf)/profTS);
		
        end
		
		colEsf = esfC(:,col);
        colDef = 100*Defo(:,col);
        colPresionV = esfV(:,col);
			
%%%%%%% GRAFICA 1: ESFUERZO VS DEFORMACION %%%%%%%%

        subplot(1,3,1)
        plot(colDef,colEsf)
        xlim([minDef maxDef]);
        ylim([minEsfC maxEsfC]);
        if idioma == 1
            xlabel('Deformación \gamma (%)');
            ylabel('Esfuerzo de Corte \tau (kPa)');
            title('Esfuerzo vs Deformación');
        elseif idioma == 2
            xlabel('Strain \gamma (%)');
            ylabel('Shear Stress \tau (kPa)');
            title('Stress vs Deformationn');
        end
        grid on				            

%%%%%%% GRAFICA 2: ESFUERZO VS PRESION VERTICAL %%%%%%%%

        fig2=subplot(1,3,2);
        cla(fig2);%%PREGUNTAR SI DEBEN ANIDARSE LOS PLOTEOS O UN SOLO GRAFICO POR EJECUCION
        hold on
        xlim([minEsfV maxEsfV]);
        ylim([minEsfC maxEsfC]);

        plot([0.7*minEsfV,0],[-minEsfC,0],'k','LineWidth',2)
        plot([0.7*minEsfV,0],[minEsfC,0],'k','LineWidth',2)
            
        plot([0.9*minEsfV,0],[-minEsfC,0],'--','Color','k')
        plot([0.9*minEsfV,0],[minEsfC,0],'--','Color','k')
        
        plot(colPresionV,colEsf)
        hold off
        if idioma == 1
            xlabel('Presión Efectiva Vertical \sigma_v\prime  (kPa)');
            ylabel('Esfuerzo de Corte \tau (kPa)');
            title('Esfuerzo vs Presión Efectiva');
        elseif idioma == 2
            xlabel('Vertical Effective Stress \sigma_v\prime  (kPa)');
            ylabel('Shear Stress \tau (kPa)');
            title('Stress vs Effective Stress');
        end
        set(gca,'Xdir','reverse')
        grid on

%%%%%%% GRAFICA 3: PRESION DE PORO: RATIO %%%%%%%%

		subplot(1,3,3)
        plot(time,ru2(:,col))    
        ylim([0 1]) %%%%%%% <<<<<<<<<<<<<<<<<<<<----------------------------------Ojo a este limitante
        if idioma == 1
            xlabel('Tiempo (seg)');
            ylabel('Presion de poro  r_u');
            title('Presión de Poros');
        elseif idioma == 2
            xlabel('Time (sec)');
            ylabel('Pore Pressure  r_u');
            title('Pore Pressure');
        end
        grid on    
    end
 return 