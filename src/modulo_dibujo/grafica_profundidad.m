function [timeT,ejey,xlab,ylab]=grafica_profundidad(path_projF,column,tipo,prof,idioma)
	
	% carga archivos de nodos
	path_nodes = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\ppNodesInfo.dat');
	nodes = load (path_nodes);
	profD = sortrows(nodes(:,3),-1);
	% cargar archivos e esfuerzos
	path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');	
	% cargar archivos para esfuerzos xx
	esf = importdata(path_esf);
	esf(:,1) = [];
	esf1 = esf(:,1:5:end);
	% path para desplazamientos en x
	path_despx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementx.out');
	% cargar archivos para desplazamientos en x
	dispx = importdata(path_despx);
	disSigno = sign(dispx);
	% tiempo total de análisis
	timeT = dispx(:,1);
	
	if tipo == 1
			
		dispx(:,1) = [];
		dispx = dispx*1000;

		dispPx0 = dispx(:,1);
		
		[m, n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				despResidualX=dispx(:,2);
				ejey=despResidualX-dispPx0;
				
			else
				despResidualX = dispx(1,colP);    
				dispTx = dispx(1:end,colP);
				ejey = dispTx-dispPx0;
				clear dispTx
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
			xlab='Tiempo de análisis (s)';
			ylab='Desplazamiento en direccion X (mm)';
		elseif idioma == 2
			xlab='Analysis time(s)';
			ylab='Displacement in X direction (mm)';
        end
	   
		clear dispPx0 profTS nEsf colP colEsfDef m n despResidualX 
		
	elseif 	tipo == 2
		% path para desplazamientos en y
		path_despy = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementy.out');
		
		% cargar archivos para desplazamientos en y
		dispy = importdata(path_despy);
		dispx(:,1) = [];
		dispy(:,1) = [];
		dispy = dispy*1000;

		dispPy0 = dispy(:,1);
		
		[m, n] = size(dispx);

		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
		if colP < n || colEsfDef < nEsf
			if prof == 0
				despResidualY=dispy(1,1);
				ejey=dispPy0-despResidualY;
			else
				despResidualY = dispy(1,colP);    
				dispTy = dispy(1:end,colP);
				ejey = dispTy - despResidualY;
				clear dispTy
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
		end
		
		if idioma == 1
			xlab='Tiempo de análisis (s)';
			ylab='Desplazamiento en dirección Y (mm)';
		elseif idioma == 2
			xlab='Analysis time (s)';
			ylab='Displacement in Y direction (mm)';
		end
	   
		clear dispy dispPy0 profTS nEsf colP colEsfDef m n despResidualY
	
	elseif tipo == 3
		% path para aceleraciones en x
		path_acelx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationx.out');
		
		% cargar archivos para aceleraciones en x
		acelx = importdata(path_acelx);
		dispx(:,1) = [];
		acelx(:,1) = [];

		acelPx0 = acelx(:,1);
		
		[m, n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
		if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=acelPx0;
			else    
				acelTx = acelx(1:end,colP);
				ejey = acelTx;
				clear acelTx
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
		end
		
		if idioma == 1
           xlab='Tiempo de análisis (s)';
           ylab='Aceleración en dirección X (m/s^2)';           
		elseif idioma == 2
           xlab='Analysis time (s)';
           ylab='Acceleration in X direction (m/s^2)';           
		end
		
		clear acelx acelPx0 profTS nEsf colP colEsfDef m n 
		
	elseif tipo == 4
		% path para aceleraciones en y
		path_acely = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationy.out');
		
		% cargar archivos para aceleraciones en y
		acely = importdata(path_acely);
		dispx(:,1) = [];
		acely(:,1) = [];

		acelPy0 = acely(:,1);
		
		[m, n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=acelPy0;
			else    
				acelTy = acely(1:end,colP);
				ejey = acelTy;
				clear acelTy
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
       if idioma == 1
           xlab='Tiempo de análisis (s)';
           ylab='Aceleración en dirección Y (m/s^2)';
       elseif idioma == 2
           xlab='Analysis time (s)';
           ylab='Acceleration in Y direction (m/s^2)';         
       end
	   
		clear acely acelPy0 profTS nEsf colP colEsfDef m n 
		
	elseif tipo == 5
		% path para presion de poros
		path_pore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\velocidades','\porePressure.out');
		
		% cargar archivos para presion de poros
		pore = importdata(path_pore);
		dispx(:,1) = [];
		pore(:,1) = [];
		
		poreP0 = pore(:,1);
		
		[m, n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=poreP0;
			else    
				poreT = pore(1:end,colP);
				ejey = poreT;
				clear poreT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
       if idioma == 1
           xlab='Tiempo de análisis (s)';
           ylab='Presión de Poros r_u (kPa)';
       elseif idioma == 2
           xlab='Analysis time (s)';
           ylab='Pore Pressure r_u (kPa)';          
       end
		
		clear pore poreP0 profTS nEsf colP colEsfDef m n 
		
	elseif tipo == 6
		
		dispx(:,1) = [];
		
		esfxxP0 = esf1(:,1);
		
		[m, n] = size(dispx);

		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=esfxxP0;
			else    
				esfxxT = esf1(1:end,colEsfDef);
				ejey = esfxxT;
				clear esfxxT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Esfuerzos Axiales en dirección XX (kPa)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Axial Stress in XX direction (kPa)';
        end
			   
		clear esfxxP0 profTS nEsf colP colEsfDef m n 
		
	elseif tipo == 7
		
		dispx(:,1) = [];
		
		esfyy = esf(:,2:5:end);
		esfyyP0 = esfyy(:,1);
		
		[m, n] = size(dispx);

		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=esfyyP0;
			else    
				esfyyT = esfyy(1:end,colEsfDef);
				ejey = esfyyT;
				clear esfyyT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Esfuerzos Axiales en dirección YY (kPa)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Axial Stress in YY direction (kPa)';
        end
		
		clear esfyy esfyyP0 profTS nEsf colP colEsfDef m n 
		
	elseif tipo == 8
	
		dispx(:,1) = [];
		
		esfxy = esf(:,4:5:end);
		esfxyP0 = esfxy(:,1);
		
		[m, n] = size(dispx);

		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=esfxyP0;
			else    
				esfxyT = esfxy(1:end,colEsfDef);
				ejey = esfxyT;
				clear esfxyT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Esfuerzos de Corte XY (kPa)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Shear Stress XY (kPa)';
        end

		clear esfxy esfxyP0 profTS nEsf colP colEsfDef m n 
		
	elseif tipo == 9
		% path para deformaciones xx
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');
		
		% cargar archivos para deformaciones xx
		def = importdata(path_def);
		
		dispx(:,1) = [];
		
		defxx = def(:,1:3:end);
		defxx = defxx*1000;
		defxxP0 = defxx(:,1);
		
		[m , n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=defxxP0;
			else
				defxxT = defxx(1:end,colEsfDef);
				ejey = defxxT;
				clear defxxT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Deformación en dirección XX (mm)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Strain in XX direction (mm)';
        end
		
		clear def defxx defxxP0 profTS nEsf colP colEsfDef m n 

	elseif tipo == 10
		% path para deformaciones yy
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');
		
		% cargar archivos para deformaciones yy
		def = importdata(path_def);
		
		dispx(:,1) = [];
		
		defyy = def(:,2:3:end);
		defyy = defyy*1000;
		defyyP0 = defyy(:,1);
		
		[m, n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=defyyP0;
			else
				defyyT = defyy(1:end,colEsfDef);
				ejey = defyyT;
				clear defyyT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Deformación en dirección YY (mm)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Strain in YY direction (mm)';
        end
			   
		clear def defyy defyyP0 profTS nEsf colP colEsfDef m n 

	elseif tipo == 11
		% path para deformaciones yy
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');
		
		% cargar archivos para deformaciones yy
		def = importdata(path_def);
		
		dispx(:,1) = [];
		
		defxy = def(:,3:3:end);
		defxy = defxy*100;
		defxyP0 = defxy(:,1);
		
		[m, n] = size(dispx);
		
		profTS = profD(1);
		
		nEsf = size(esf1,2);
		colP = floor((prof*(n))/profTS);
		colEsfDef = floor((prof*(nEsf))/profTS);
    
        if colP < n || colEsfDef < nEsf
			if prof == 0
				ejey=defxyP0;
			else
				defxyT = defxy(1:end,colEsfDef);
				ejey = defxyT;
				clear defxyT
			end
		else
			ejey = 0;
			
			if idioma == 1
			    msgbox('La altura ingresada sobrepasa a la altura de la columna de suelo en análisis','Error','error')
			elseif idioma == 2
			    msgbox('The height entered exceeds the height of the soil column under analysis','Error','error')
			end
        end
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Distorsión XY (%)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Distortion XY (%)';
        end
		
		clear def defxy defxyP0 profTS nEsf colP colEsfDef m n 

	end
	
	%plot (timeT,ejey)
	
	clear nodes profD esf dispx esf1

return
