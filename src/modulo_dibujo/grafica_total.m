function [timeT,ejey,xlab,ylab]=grafica_total(path_projF,column,tipo,idioma)

    if tipo == 1
		% path para desplazamientos en x
		path_despx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementx.out');

		% cargar archivos para desplazamientos en x
		dispx = importdata(path_despx);
		% tiempo total de anÃ¡lisis
		timeT = dispx(:,1);
		

		dispx(:,1) = [];
		dispTxi = (dispx(:,1:end)*1000);
		dispPx0 = dispTxi(:,1);
	
		[m, n] = size(dispTxi);
		matriz_cero = ones(m,n);
		x = dispTxi(1,1);
		Basex = matriz_cero*x;
		
		%El desplazamiento es relativo y absoluto.
		ejey = dispTxi - dispPx0;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Desplazamiento en direccián X (mm)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Displacement in X direction (mm)';
        end
		
		clear dispx dispTxi m n matriz_cero x Basex
		
	elseif 	tipo == 2
		% path para desplazamientos en y
		path_despy = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\desplazamientos','\displacementy.out');

		% cargar archivos para desplazamientos en y
		dispy = importdata(path_despy);
		% tiempo total de anÃ¡lisis
		timeT = dispy(:,1);
		
		dispy(:,1) = [];
		dispTyi = (dispy(:,1:end)*1000);
	
		[m, n] = size(dispTyi);
		matriz_cero = ones(m,n);
		y = dispTyi(1,1);
		Basey = matriz_cero*y;
		
		ejey = dispTyi - Basey;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Desplazamiento en dirección Y (mm)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Displacement in Y direction (mm)';                
        end
		
		clear dispy dispTyi m n matriz_cero y Basey
		
	elseif tipo == 3
		% path para aceleracioes en x
		path_acelx = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationx.out');

		% cargar archivos para aceleraciones en x
		acelx = importdata(path_acelx);
		% tiempo total de anÃ¡lisis
		timeT = acelx(:,1);
		
		acelx(:,1) = [];
		acelTxi = (acelx(:,1:end));
		
		ejey = acelTxi;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Aceleración en dirección X (m/s^2)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Acceleration in X direction (m/s^2)';               
        end
		
		clear acelx acelTxi 
		
	elseif tipo == 4
		% path para aceleracioes en y
		path_acely = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\aceleraciones','\accelerationy.out');

		% cargar archivos para aceleraciones en y
		acely = importdata(path_acely);
		% tiempo total de anÃ¡lisis
		timeT = acely(:,1);
		
		acely(:,1) = [];
		acelTyi = (acely(:,1:end));
		
		ejey = acelTyi;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Aceleración en dirección Y (m/s^2)';                
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Acceleration in Y direction (m/s^2)';                
        end
			
		clear acely acelTyi 
		
	elseif tipo == 5
		% path para presion de poros
		path_pore = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\velocidades','\porePressure.out');

		% cargar archivos para presion de poros
		pore = importdata(path_pore);
		% tiempo total de anÃ¡lisis
		timeT = pore(:,1);
		
		pore(:,1) = [];

		poreTi = (pore(:,1:end));
		
		ejey = poreTi;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Presión de Poro r_u (kPa)';
        elseif idioma == 2
            xlab='Analysis time (s;';
            ylab='Pore Pressure r_u (kPa)';
        end
			
		clear pore poreTi 
		
	elseif tipo == 6
		% path para esfuerzos xx
		path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');

		% cargar archivos para esfuerzos xx
		esf = importdata(path_esf);
		% tiempo total de anÃ¡lisis
		timeT = esf(:,1);
		
		esf(:,1) = [];	
		esfxx = esf(:,1:5:end);
		
		ejey = esfxx;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Esfuerzo Axial en la direccián XX (kPa)';                
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Axial Stress in XX direction (kPa)';                 
        end
		
		clear esf esfxx 
		
	elseif tipo == 7
		% path para esfuerzos yy
		path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');

		% cargar archivos para esfuerzos yy
		esf = importdata(path_esf);
		% tiempo total de anÃ¡lisis
		timeT = esf(:,1);
		
		esf(:,1) = [];
		esfyy = esf(:,2:5:end);
		
		ejey = esfyy;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Esfuerzo Axial en la dirección YY (kPa)';               
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Axial Stress in YY direction (kPa)';               
        end
		
		clear esf esfyy 
	
	elseif tipo == 8
		% path para esfuerzos xy
		path_esf = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\stress9.out');

		% cargar archivos para esfuerzos xy
		esf = importdata(path_esf);
		% tiempo total de anÃ¡lisis
		timeT = esf(:,1);
		
		esf(:,1) = [];
		esfxy = esf(:,4:5:end);
		
		ejey = esfxy;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Esfuerzo de Corte XY (kPa)';               
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Shear Stress XY (kPa)';               
        end
			
		clear esf esfxy

	elseif tipo == 9
		% path para deformaciones xx
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');

		% cargar archivos para deformaciones xx
		def = importdata(path_def);
		% tiempo total de anÃ¡lisis
		timeT = def(:,1);
		
		def(:,1) = [];
		defxx = def(:,1:3:end)*1000;
		
		ejey = defxx;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Deformación XX (mm)';               
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Deformation in XX direction (mm)';               
        end
		
		clear def defxx
	
	elseif tipo == 10
		% path para deformaciones yy
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');

		% cargar archivos para deformaciones yy
		def = importdata(path_def);
		% tiempo total de anÃ¡lisis
		timeT = def(:,1);
		
		def(:,1) = [];
		defyy = def(:,2:3:end)*1000;
		
		ejey = defyy;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Deformación YY (mm)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Deformation in YY direction (mm)';  
        end
			
		clear def defyy

	elseif tipo == 11
		% path para deformaciones xy
		path_def = strcat(path_projF,'post_proceso\','columna_',num2str(column),'\dinamico','\esfuerzo_deformacion','\strain9.out');

		% cargar archivos para deformaciones xy
		def = importdata(path_def);
		% tiempo total de anÃ¡lisis
		timeT = def(:,1);
		
		def(:,1) = [];
		defxy = def(:,3:3:end)*100;
		
		ejey = defxy;
		
        if idioma == 1
            xlab='Tiempo de análisis (s)';
            ylab='Distorsión XY (%)';
        elseif idioma == 2
            xlab='Analysis time (s)';
            ylab='Distortion XY (%)';                
        end
		
		clear def defxy

    end
	%plot(timeT,ejey)
    %xlabel(xlab)
    %ylabel(ylab)
return