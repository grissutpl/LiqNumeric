function delDatosEstrat(iedit)
    


    %% Obtener datos del estrato
         
    % Ruta de almacenamiento
    
    if isdeployed
       path_file = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_file = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    path_file = load(path_file,'path_proj');
    path_proj = path_file.path_proj;
    
%     % Modificar valores previamente almacenados
    dat_cpa = load(path_proj);
%      
    tipo            = dat_cpa.tipo;
    grade           = dat_cpa.grade;
    layerThick      = dat_cpa.layerThick;
    rho             = dat_cpa.rho;
    refShearModul   = dat_cpa.refShearModul;
    refBulkModul    = dat_cpa.refBulkModul;
    uBulk           = dat_cpa.uBulk;
    frictionAng     = dat_cpa.frictionAng;
    vPerm           = dat_cpa.vPerm;
    hPerm           = dat_cpa.hPerm;
    Vs              = dat_cpa.Vs;
    refPress        = dat_cpa.refPress;
    surf            = dat_cpa.surf;
    e               = dat_cpa.e;
    contrac1        = dat_cpa.contrac1;
    contrac3        = dat_cpa.contrac3;
    dilat1          = dat_cpa.dilat1;
    dilat3          = dat_cpa.dilat3;
    PTAng           = dat_cpa.PTAng;
    cohesion        = dat_cpa.cohesion;
    
    grade_str           = dat_cpa.grade_str;
    layerThick_str      = dat_cpa.layerThick_str;
    rho_str             = dat_cpa.rho_str;
    refShearModul_str   = dat_cpa.refShearModul_str;
    refBulkModul_str    = dat_cpa.refBulkModul_str;
    uBulk_str           = dat_cpa.uBulk_str;
    frictionAng_str     = dat_cpa.frictionAng_str;
    vPerm_str           = dat_cpa.vPerm_str;
    hPerm_str           = dat_cpa.hPerm_str;
    Vs_str              = dat_cpa.Vs_str;
    refPress_str        = dat_cpa.refPress_str;
    surf_str            = dat_cpa.surf_str;
    e_str               = dat_cpa.e_str;
	contrac1_str        = dat_cpa.contrac1_str;
    contrac3_str        = dat_cpa.contrac3_str;
    dilat1_str          = dat_cpa.dilat1_str;
    dilat3_str          = dat_cpa.dilat3_str;
    PTAng_str           = dat_cpa.PTAng_str;
    cohesion_str        = dat_cpa.cohesion_str;
    
    
    tipo(iedit)         =[];
    grade(iedit)        =[];
    layerThick(iedit)   =[];
    rho(iedit)          =[];
    refShearModul(iedit)=[];
    refBulkModul(iedit) =[];
    uBulk(iedit)        =[];
    frictionAng(iedit)  =[];
    vPerm(iedit)        =[];
    hPerm(iedit)        =[];
    Vs(iedit)           =[];
    refPress(iedit)     =[];
    surf(iedit)         =[];
    e(iedit)            =[];
    contrac1(iedit)     =[];
    contrac3(iedit)     =[];
    dilat1(iedit)       =[];
    dilat3(iedit)       =[];
    PTAng(iedit)        =[];
    cohesion(iedit)     =[];


    grade_str(iedit)           = [];
    layerThick_str (iedit)     = [];
    rho_str(iedit)             = [];
    refShearModul_str(iedit)   = [];
    refBulkModul_str(iedit)    = [];
    uBulk_str(iedit)           = [];
    frictionAng_str(iedit)     = [];
    vPerm_str(iedit)           = [];
    hPerm_str(iedit)           = [];
    Vs_str(iedit)              = [];
    refPress_str(iedit)        = [];
    surf_str(iedit)            = [];
    e_str(iedit)               = [];
    contrac1_str(iedit)        = [];
    contrac3_str(iedit)        = [];
    dilat1_str(iedit)          = [];
    dilat3_str(iedit)          = [];
    PTAng_str(iedit)           = [];
    cohesion_str(iedit)        = [];
    
    
    numLayers = size(tipo,2);
    
    %% Almacenamiento de datos
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
    %% 
    
    save(path_proj,name_colum{:},'-append')
    
    
end