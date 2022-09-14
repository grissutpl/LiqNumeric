function datosEstrat(tipo,grade,layerThick,rho,refShearModul,refBulkModul,...
                uBulk,frictionAng,vPerm,hPerm,Vs,refPress,surf,e,...
                contrac1,contrac3,dilat1,dilat3,PTAng,cohesion)
    


    % Obtener datos del estrato
    % Evaluación de datos y almacenamiento de valores numéricos

    grade_str           = grade;
    layerThick_str      = layerThick;
    rho_str             = rho;
    refShearModul_str   = refShearModul;
    refBulkModul_str    = refBulkModul;
    uBulk_str           = uBulk;
    frictionAng_str     = frictionAng;
    vPerm_str           = vPerm;
    hPerm_str           = hPerm;
    Vs_str              = Vs;
    refPress_str        = refPress;
    surf_str            = surf;
    e_str               = e;
    contrac1_str        = contrac1;
    contrac3_str        = contrac3;
    dilat1_str          = dilat1;
    dilat3_str          = dilat3;
    PTAng_str           = PTAng;
    cohesion_str        = cohesion;

    grade           = eval(grade_str);
    layerThick      = eval(layerThick_str);
    rho             = eval(rho_str);
    refShearModul   = eval(refShearModul_str);
    refBulkModul    = eval(refBulkModul_str);
    uBulk           = eval(uBulk_str);
    frictionAng     = eval(frictionAng_str);
    vPerm           = eval(vPerm_str);
    hPerm           = eval(hPerm_str);
    Vs              = eval(Vs_str);
    refPress        = eval(refPress_str);
    surf            = eval(surf_str);
    e               = eval(e_str);
	contrac1        = eval(contrac1_str);
    contrac3        = eval(contrac3_str);
    dilat1          = eval(dilat1_str);
    dilat3          = eval(dilat3_str);
    PTAng           = eval(PTAng_str);
    cohesion        = eval(cohesion_str);
    
    
    % Ruta de almacenamiento
    
    if isdeployed
       path_file = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_file = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    path_file = load(path_file,'path_proj');
    path_proj = path_file.path_proj;
    
%     % Obtener valores previamente almacenados
    dat_cpa = load(path_proj);
%      
    tipo            = [dat_cpa.tipo,tipo];
    grade           = [dat_cpa.grade,grade];
    layerThick      = [dat_cpa.layerThick,layerThick];
    rho             = [dat_cpa.rho,rho];
    refShearModul   = [dat_cpa.refShearModul,refShearModul];
    refBulkModul    = [dat_cpa.refBulkModul,refBulkModul];
    uBulk           = [dat_cpa.uBulk,uBulk];
    frictionAng     = [dat_cpa.frictionAng,frictionAng];
    vPerm           = [dat_cpa.vPerm,vPerm];
    hPerm           = [dat_cpa.hPerm,hPerm];
    Vs              = [dat_cpa.Vs,Vs];
    refPress        = [dat_cpa.refPress,refPress];
    surf            = [dat_cpa.surf,surf];
    e               = [dat_cpa.e,e];
    contrac1        = [dat_cpa.contrac1,contrac1];
    contrac3        = [dat_cpa.contrac3,contrac3];
    dilat1          = [dat_cpa.dilat1,dilat1];
    dilat3          = [dat_cpa.dilat3,dilat3];
    PTAng           = [dat_cpa.PTAng,PTAng];
    cohesion        = [dat_cpa.cohesion,cohesion];
    
    grade_str           = [dat_cpa.grade_str,grade_str];
    layerThick_str      = [dat_cpa.layerThick_str,layerThick_str];
    rho_str             = [dat_cpa.rho_str,rho_str];
    refShearModul_str   = [dat_cpa.refShearModul_str,refShearModul_str];
    refBulkModul_str    = [dat_cpa.refBulkModul_str,refBulkModul_str];
    uBulk_str           = [dat_cpa.uBulk_str,uBulk_str];
    frictionAng_str     = [dat_cpa.frictionAng_str,frictionAng_str];
    vPerm_str           = [dat_cpa.vPerm_str,vPerm_str];
    hPerm_str           = [dat_cpa.hPerm_str,hPerm_str];
    Vs_str              = [dat_cpa.Vs_str,Vs_str];
    refPress_str        = [dat_cpa.refPress_str,refPress_str];
    surf_str            = [dat_cpa.surf_str,surf_str];
    e_str               = [dat_cpa.e_str,e_str];
	contrac1_str        = [dat_cpa.contrac1_str,contrac1_str];
    contrac3_str        = [dat_cpa.contrac3_str,contrac3_str];
    dilat1_str          = [dat_cpa.dilat1_str,dilat1_str];
    dilat3_str          = [dat_cpa.dilat3_str,dilat3_str];
    PTAng_str           = [dat_cpa.PTAng_str,PTAng_str];
    cohesion_str        = [dat_cpa.cohesion_str,cohesion_str];
     
    numLayers           = size(tipo,2);
    %soilThick           = num2cell([layerThick{:}]);      
    
    % Almacenamiento de datos
    name_colum = {'tipo',...
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
    % 
    
    save(path_proj,name_colum{:},'-append')
    
    
end