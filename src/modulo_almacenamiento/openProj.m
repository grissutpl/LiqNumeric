function openProj (path,file)
    global path_master
    % path del archivo a abrir
    path_file = strcat(path,file);
    
    path_proj = load(path_file,'archivo');
    archivo = path_proj.archivo;
    
    if archivo == 1
        
        path_projF = path;
        path_proj = path_file;
        % Almacenar rutas en archivo maestro
        save(path_master,'path_projF','path_proj','-append') 
        
        path = strrep(path_projF,'\','/');

        %guardar path en archivo src_tcl
        if isdeployed
           path_path = strcat(ctfroot,'\src_tcl\path.txt'); 
        else
           path_path = strcat(pwd,'\src_tcl\path.txt'); 
        end
        archivo = fopen(path_path,'w');
        fprintf(archivo,'set pathmaster "%s" \n',path(1:end-1));
        fclose(archivo);
        
    elseif archivo == 2  
        
        [name,path1] = uiputfile('*.*','Guardar proyecto','OpenSiteProj');

        if name == 0
           return 
        end

        % Ruta de la carpeta de proyecto
        path_projF = strcat(path1,name,'\');
        % Ruta del archivo de proyecto
        path_proj = strcat(path_projF,name,'.mat');
        % Crear carpeta
        mkdir(path_projF)


       % Inicialización de variables
        path_dat = load(path_file,'columna','sElemX','damp','waterTable','waterTable_str',...
                        'damp_str','rockDen','rockVS','rockDen_str','rockVS_str',...
                        'path_sis','motionDT','faconv','famp','motionStep','restricion',...
                        'alphasp','alphamp','numerador','analisis','test','tol','iter',...
                        'impresion','sistema','algorit','coef','integrador','gamma',...
                        'beta','restricion1','alphasp1','alphamp1','numerador1','analisis1',...
                        'test1','tol1','iter1','impresion1','sistema1','algorit1','coef1',...
                        'integrador1','gamma1','beta1','tipo','grade','layerThick',...
                        'rho','frictionAng','Vs','refPress','surf','refShearModul',...
                        'refBulkModul','uBulk','vPerm','hPerm','e','contrac1',...
                        'contrac3','dilat1','dilat3','PTAng','cohesion',...
                        'numLayers','grade_str','layerThick_str','rho_str','frictionAng_str',...
                        'Vs_str','refPress_str','surf_str','refShearModul_str',...
                        'refBulkModul_str','uBulk_str','vPerm_str','hPerm_str',...
                        'e_str','contrac1_str','contrac3_str','dilat1_str','dilat3_str',...
                        'PTAng_str','cohesion_str');
 
        archivo 		= 1;
        columna			= {path_dat.columna};
        graficos		= 0;

        % geometria
        sElemX          = {path_dat.sElemX};
        damp            = {path_dat.damp};
        damp_str        = path_dat.damp_str;
        waterTable      = {path_dat.waterTable};
        waterTable_str  = path_dat.waterTable_str;
        
        % roca
        rockDen         = {path_dat.rockDen};
        rockVS          = {path_dat.rockVS};
        rockDen_str     = path_dat.rockDen_str;
        rockVS_str      = path_dat.rockVS_str;
        
        % sismo
        path_sis    = path_dat.path_sis;
        motionDT    = {path_dat.motionDT};
        faconv      = {path_dat.faconv};
        famp        = {path_dat.famp};
        motionStep  = {path_dat.motionStep};
        
        % analisis
        restricion  = path_dat.restricion;
        alphasp     = path_dat.alphasp;
        alphamp     = path_dat.alphamp;
        numerador   = path_dat.numerador;
        analisis    = path_dat.analisis;
        test        = path_dat.test;
        tol         = path_dat.tol;
        iter        = path_dat.iter;
        impresion   = path_dat.impresion;
        sistema     = path_dat.sistema;
        algorit     = path_dat.algorit;
        coef        = path_dat.coef;
        integrador  = path_dat.integrador;
        gamma       = path_dat.gamma;
        beta        = path_dat.beta;

        restricion1 = path_dat.restricion1;
        alphasp1    = path_dat.alphasp1;
        alphamp1    = path_dat.alphamp1;
        numerador1  = path_dat.numerador1;
        analisis1   = path_dat.analisis1;
        test1       = path_dat.test1;
        tol1        = path_dat.tol1;
        iter1       = path_dat.iter1;
        impresion1  = path_dat.impresion1;
        sistema1    = path_dat.sistema1;
        algorit1    = path_dat.algorit1;
        coef1       = path_dat.coef1;
        integrador1 = path_dat.integrador1;
        gamma1      = path_dat.gamma1;
        beta1       = path_dat.beta1;
        %estratos


    

        %estratos
        tipo            = path_dat.tipo;
        grade           = path_dat.grade;
        layerThick      = path_dat.layerThick;
        rho             = path_dat.rho;
        frictionAng     = path_dat.frictionAng;
        Vs              = path_dat.Vs;
        refPress	    = path_dat.refPress;
        surf            = path_dat.surf;
        refShearModul   = path_dat.refShearModul;
        refBulkModul    = path_dat.refBulkModul;
        uBulk           = path_dat.uBulk;
        vPerm           = path_dat.vPerm;
        hPerm           = path_dat.hPerm;
        e               = path_dat.e;
        contrac1        = path_dat.contrac1;
        contrac3        = path_dat.contrac3;
        dilat1          = path_dat.dilat1;
        dilat3          = path_dat.dilat3;
        PTAng           = path_dat.PTAng;
        cohesion        = path_dat.cohesion;

        numLayers       = path_dat.numLayers;

        grade_str           = path_dat.grade_str;
        layerThick_str      = path_dat.layerThick_str;
        rho_str             = path_dat.rho_str;
        frictionAng_str     = path_dat.frictionAng_str;
        Vs_str              = path_dat.Vs_str;
        refPress_str	    = path_dat.refPress_str;
        surf_str            = path_dat.surf_str;
        refShearModul_str   = path_dat.refShearModul_str;
        refBulkModul_str    = path_dat.refBulkModul_str;
        uBulk_str           = path_dat.uBulk_str;
        vPerm_str           = path_dat.vPerm_str;
        hPerm_str           = path_dat.hPerm_str;
        e_str               = path_dat.e_str;
        contrac1_str        = path_dat.contrac1_str;
        contrac3_str        = path_dat.contrac3_str;
        dilat1_str          = path_dat.dilat1_str;
        dilat3_str          = path_dat.dilat3_str;
        PTAng_str           = path_dat.PTAng_str;
        cohesion_str        = path_dat.cohesion_str;

        name_estrato = {'archivo',...
				  'columna',...
				  'graficos',...
				  'sElemX',...
                  'damp',...
                  'damp_str',...
				  'waterTable',...
				  'waterTable_str',...
                  'rockDen',...
                  'rockVS',...
                  'rockDen_str',...
                  'rockVS_str',...
                  'path_sis',...
                  'motionDT',...
                  'faconv',...
                  'famp',...
                  'motionStep',...
                  'restricion',...
                  'alphasp',...
                  'alphamp',...
                  'numerador',...
                  'analisis',...
                  'test',...
                  'tol',...
                  'iter',...
                  'impresion',...
                  'sistema',...
                  'algorit',...
                  'coef',...
                  'integrador',...
                  'gamma',...
                  'beta',...
                  'restricion1',...
                  'alphasp1',...
                  'alphamp1',...
                  'numerador1',...
                  'analisis1',...
                  'test1',...
                  'tol1',...
                  'iter1',...
                  'impresion1',...
                  'sistema1',...
                  'algorit1',...
                  'coef1',...
                  'integrador1',...
                  'gamma1',...
                  'beta1',...
                  'tipo',...
                  'grade',...
                  'layerThick',...
                  'rho',...
                  'refShearModul',...
                  'refBulkModul',...
                  'uBulk',...
                  'frictionAng',...               
                  'vPerm',...
                  'hPerm',...
                  'Vs',...
                  'refPress',...
                  'surf',...
                  'e',...
                  'contrac1',...
                  'contrac3',...
                  'dilat1',...
                  'dilat3',...
                  'PTAng',...
                  'cohesion',...
                  'grade_str',...
                  'layerThick_str',...
                  'rho_str',...
                  'refShearModul_str',...
                  'refBulkModul_str',...
                  'uBulk_str',...
                  'frictionAng_str',...            
                  'vPerm_str',...
                  'hPerm_str',...
                  'Vs_str',...
                  'refPress_str',...
                  'surf_str',...
                  'e_str',...
                  'contrac1_str',...
                  'contrac3_str',...
                  'dilat1_str',...
                  'dilat3_str',...
                  'PTAng_str',...
                  'cohesion_str',...
                  'numLayers'
                 };  

        % Almacenar proyecto
        save(path_proj,name_estrato{:})

        %Crear carpeta de postproceso y preproceso
        path_pre = strcat(path_projF,'pre_proceso');
        path_post = strcat(path_projF,'post_proceso');

        mkdir(path_pre)
        mkdir(path_post)

        % Almacenar rutas en archivo maestro
        save(path_master,'path_projF','path_proj','-append')
        
        path = strrep(path_projF,'\','/');

        %guardar path en archivo src_tcl
        if isdeployed
           path_path = strcat(ctfroot,'\src_tcl\path.txt'); 
        else
           path_path = strcat(pwd,'\src_tcl\path.txt'); 
        end
        archivo = fopen(path_path,'w');
        fprintf(archivo,'set pathmaster "%s" \n',path(1:end-1));
        fclose(archivo);
    end