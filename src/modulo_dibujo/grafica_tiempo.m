function [ejex,profD,xlab,ylab]=grafica_tiempo(path_projF,column,tipo,time,dT,step,idioma)
	
	% carga archivos de nodos
	path_nodes = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\ppNodesInfo.dat');
	nodes = load (path_nodes);
	profD = sortrows(nodes(:,3),-1);
	
	if tipo == 1
		% path para desplazamientos en x
		path_Gdespx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\desplazamientos','\Gdisplacementx.out');
		path_despx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementx.out');

		% cargar archivos para desplazamientos en x
		Gdispx = importdata(path_Gdespx);
		dispx = importdata(path_despx);
		
		dispx(:,1) = [];
		Gdispx(:,1) = [];
		GdispTx = (Gdispx(end,:)*1000);

		[m, n] = size(dispx);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				dispResidualX = dispx(1,1)*1000;
				ejex = GdispTx - dispResidualX;
			else			
				dispTx = (dispx(fila,1:end)*1000);
				dispResidualX = dispx(fila,1)*1000;
				ejex = dispTx - dispResidualX;
				clear dispTx
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Desplazamiento en dirección X (mm)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Displacement in X direction (mm)';
            ylab='Depth (m)';
        end
			   
		clear Gdispx dispx GdispTx m n fila dispResidualX
		
	elseif 	tipo == 2
		% path para desplazamientos en y
		path_Gdespy = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\desplazamientos','\Gdisplacementy.out');
		path_despy = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementy.out');

		% cargar archivos para desplazamientos en y
		Gdispy = importdata(path_Gdespy);
		dispy = importdata(path_despy);
		
		dispy(:,1) = [];
		Gdispy(:,1) = [];
		GdispTy = (Gdispy(end,:)*1000);

		[m, n] = size(dispy);
		
		fila = floor((time*m)/(step*dT));
    
        if fila < m
			if time == 0
				dispResidualY = dispy(1,1)*1000;
				ejex = GdispTy - dispResidualY;
			else			
				dispTy = (dispy(fila,1:end)*1000);
				dispResidualY = dispy(fila,1)*1000;
				ejex = dispTy - dispResidualY;
				clear dispTy
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Desplazamiento en dirección Y (mm)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Displacement in X direction (mm)';
            ylab='Depth (m)';
        end
			   
		clear Gdispy dispy GdispTy m n fila dispResidualY
		
	elseif tipo == 3
		% path para aceleracioes en x
		path_Gacelx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\aceleraciones','\Gaccelerationx.out');
		path_acelx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationx.out');

		% cargar archivos para aceleraciones en x
		Gacelx = importdata(path_Gacelx);
		acelx = importdata(path_acelx);
		
		acelx(:,1) = [];
		Gacelx(:,1) = [];
		GacelTx= (Gacelx(end,:));
		
		[m, n] = size(acelx);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GacelTx;
			else	
				acelTx = acelx(fila,1:end);			
				ejex = acelTx;
				clear acelTx
			end
		else
			ejex = 0;
			
			if idioma == 0
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 1
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Acceleracion en dirección X (m/s^2)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Acceleration in X direction (m/s^2)';
            ylab='Depth (m)';
        end
			   
		clear Gacelx acelx GacelTx m n fila
		
	elseif tipo == 4
		% path para aceleracioes en y
		path_Gacely = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\aceleraciones','\Gaccelerationy.out');
		path_acely = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationy.out');

		% cargar archivos para aceleraciones en y
		Gacely = importdata(path_Gacely);
		acely = importdata(path_acely);
		
		acely(:,1) = [];
		Gacely(:,1) = [];
		GacelTy= (Gacely(end,:));
		
		[m, n] = size(acely);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GacelTy;
			else	
				acelTy = acely(fila,1:end);			
				ejex = acelTy;
				clear acelTy
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Aceleracion en dirección Y (m/s^2)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Acceleration in Y direction (m/s^2)';
            ylab='Depth (m)';
        end
			   
		clear Gacely acely GacelTy m n fila

	elseif tipo == 5
		% path para presion de poros
		path_Gpore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\velocidades','\GporePressure.out');
		path_pore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\velocidades','\porePressure.out');

		% cargar archivos para presion de poros
		Gpore = importdata(path_Gpore);
		pore = importdata(path_pore);
		
		pore(:,1) = [];
		Gpore(:,1) = [];
		GporeT= (Gpore(end,:));
		
		[m, n] = size(pore);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GporeT;
			else	
				poreT = pore(fila,1:end);			
				ejex = poreT;
				clear poreT
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Presión de Poros r_u (kPa)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Pore Pressure r_u (kPa)';
            ylab='Depth (m)';
        end
		
		clear pore Gpore GporeT m n fila
		
	elseif tipo == 6
		% path para esfuerzos xx
		path_Gesf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstress9.out');
		path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');

		% cargar archivos para esfuerzos xx
		Gesf = importdata(path_Gesf);
		esf = importdata(path_esf);
		
		esf(:,1) = [];
		Gesf(:,1) = [];
		esf1 = esf(:,1:5:end);
		GesfT= (Gesf(end,1:5:end));
		
		contador = size(esf1,2);
		
		profSuelo = profD(1);
		yElem = profD(1)-profD(2);

		y=zeros(1,profSuelo*2);
		
		for i = profSuelo:-yElem:yElem
			Dant = i;
			Dsig = i - yElem;
			y(1,contador) = (Dant + Dsig)/2;
			contador = contador -1;
		end
		
		profD = sort(y,'descend');
		
		[m, n] = size(esf);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GesfT;
			else	
				esfT = esf1(fila,1:end);			
				ejex = esfT;
				clear esfT
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Esfuerzos Axiales en dirección XX (kPa)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Axial Stress in XX direction (kPa)';
            ylab='Depth (m)';
        end
		
		clear Gesf esf esf1 GesfT contador profSuelo yElem y Dant Dsig  m n fila
		
	elseif tipo == 7
		% path para esfuerzos yy
		path_Gesf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstress9.out');
		path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');

		% cargar archivos para esfuerzos yy
		Gesf = importdata(path_Gesf);
		esf = importdata(path_esf);
		
		esf(:,1) = [];
		Gesf(:,1) = [];
		esf1 = esf(:,2:5:end);
		GesfT= (Gesf(end,2:5:end));
		
		contador = size(esf1,2);
		
		profSuelo = profD(1);
		yElem = profD(1)-profD(2);

		y=zeros(1,profSuelo*2);
		
		for i = profSuelo:-yElem:yElem
			Dant = i;
			Dsig = i - yElem;
			y(1,contador) = (Dant + Dsig)/2;
			contador = contador -1;
		end

		profD = sort(y,'descend');
	
		[m, n] = size(esf);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GesfT;
			else	
				esfT = esf1(fila,1:end);			
				ejex = esfT;
				clear esfT
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Esfuerzos Axiales en dirección YY (kPa)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Axial Stress in YY direction (kPa)';
            ylab='Depth (m)';
        end
			   
		clear Gesf esf esf1 GesfT contador profSuelo yElem y Dant Dsig m n fila
		
	elseif tipo == 8
		% path para esfuerzos xy
		path_Gesf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstress9.out');
		path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');

		% cargar archivos para esfuerzos xy
		Gesf = importdata(path_Gesf);
		esf = importdata(path_esf);
		
		esf(:,1) = [];
		Gesf(:,1) = [];
		esf1 = esf(:,4:5:end);
		GesfT= (Gesf(end,4:5:end));
		
		contador = size(esf1,2);
		
		profSuelo = profD(1);
		yElem = profD(1)-profD(2);

		y=zeros(1,profSuelo*2);
		
		for i = profSuelo:-yElem:yElem
			Dant = i;
			Dsig = i - yElem;
			y(1,contador) = (Dant + Dsig)/2;
			contador = contador -1;
		end

		profD = sort(y,'descend');

		[m, n] = size(esf);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GesfT;
			else	
				esfT = esf1(fila,1:end);			
				ejex = esfT;
				clear esfT
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Esfuerzos de Corte XY (kPa)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Shear Stress XY (kPa)';
            ylab='Depth (m)';
        end
		
		clear Gesf esf esf1 GesfT contador profSuelo yElem y Dant Dsig m n fila

	elseif tipo == 9
		% path para deformaciones xx
		path_Gdef = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstrain9.out');
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');

		% cargar archivos para deformaciones xx
		Gdef = importdata(path_Gdef);
		def = importdata(path_def);
		
		def(:,1) = [];
		Gdef(:,1) = [];
		def1 = def(:,1:3:end)*1000;
		GdefT= (Gdef(end,1:3:end)*1000);
		
		contador = size(def1,2);
		
		profSuelo = profD(1);
		yElem = profD(1)-profD(2);

		y=zeros(1,profSuelo*2);
		
		for i = profSuelo:-yElem:yElem
			Dant = i;
			Dsig = i - yElem;
			y(1,contador) = (Dant + Dsig)/2;
			contador = contador -1;
		end

		profD = sort(y,'descend');

		[m, n] = size(def);
		
		fila = floor((time*m)/(step*dT));
		
            if fila < m
                if time == 0
                    ejex = GdefT;
                else	
                    defT = def1(fila,1:end);			
                    ejex = defT;
                    clear defT
                end
            else
                ejex = 0;

                if idioma == 1
                    msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
                elseif idioma == 2
                    msgbox('The time entered is higher than the time of the analysis.','Error','error')
                end
            end
		
        if idioma == 1
            xlab='Deformación en dirección XX (mm)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Deformation in XX direction (mm)';
            ylab='Depth (m)';
        end
			   
		clear Gdef def def1 GdefT contador profSuelo yElem y Dant Dsig m n fila
		
	elseif tipo == 10
		% path para deformaciones yy
		path_Gdef = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstrain9.out');
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');

		% cargar archivos para deformaciones yy
		Gdef = importdata(path_Gdef);
		def = importdata(path_def);
		
		def(:,1) = [];
		Gdef(:,1) = [];
		def1 = def(:,2:3:end)*1000;
		GdefT= (Gdef(end,2:3:end)*1000);
		
		contador = size(def1,2);
		
		profSuelo = profD(1);
		yElem = profD(1)-profD(2);

		y=zeros(1,profSuelo*2);
		
		for i = profSuelo:-yElem:yElem
			Dant = i;
			Dsig = i - yElem;
			y(1,contador) = (Dant + Dsig)/2;
			contador = contador -1;
		end

		profD = sort(y,'descend');
		
		[m, n] = size(def);
		
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GdefT;
			else	
				defT = def1(fila,1:end);			
				ejex = defT;
				clear defT
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Deformación en dirección YY (mm)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Deformation in YY direction (mm)';
            ylab='Depth (m)';
        end
			   
		clear Gdef def def1 GdefT contador profSuelo yElem y Dant Dsig m n fila

	elseif tipo == 11
		% path para deformaciones xy
		path_Gdef = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\estatico','\esfuerzo_deformacion','\Gstrain9.out');
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');

		% cargar archivos para deformaciones xy
		Gdef = importdata(path_Gdef);
		def = importdata(path_def);
		
		def(:,1) = [];
		Gdef(:,1) = [];
		def1 = def(:,3:3:end)*100;
		GdefT= (Gdef(end,3:3:end)*100);
		
		contador = size(def1,2);
		
		profSuelo = profD(1);
		yElem = profD(1)-profD(2);

		y=zeros(1,profSuelo*2);
		
		for i = profSuelo:-yElem:yElem
			Dant = i;
			Dsig = i - yElem;
			y(1,contador) = (Dant + Dsig)/2;
			contador = contador -1;
		end

		profD = sort(y,'descend');
	
		[m, n] = size(def);
	
		fila = floor((time*m)/(step*dT));
		
        if fila < m
			if time == 0
				ejex = GdefT;
			else	
				defT = def1(fila,1:end);			
				ejex = defT;
				clear defT
			end
		else
			ejex = 0;
			
			if idioma == 1
				msgbox('El tiempo ingresado es superior al del análisis.','Error','error')
			elseif idioma == 2
				msgbox('The time entered is higher than the time of the analysis.','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Distorsion XY (%)';
            ylab='Profundidad (m)';
        elseif idioma == 2
            xlab='Distortion XY (%)';
            ylab='Depth (m)';
        end
		
		clear Gdef def def1 GdefT contador profSuelo yElem y Dant Dsig m n fila

	end
	
	%plot(ejex,profD)
	
	clear nodes
return

%tiempo("C:\Users\Jorge Luis Saritama\Desktop\openliqproj\",1,1,0.005,6180)