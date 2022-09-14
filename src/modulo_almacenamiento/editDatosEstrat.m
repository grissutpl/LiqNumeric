function editDatosEstrat(tipo,grade,layerThick,rho,refShearModul,refBulkModul,...
                uBulk,frictionAng,vPerm,hPerm,Vs,refPress,surf,e,...
                contrac1,contrac3,dilat1,dilat3,PTAng,cohesion,iedit)
    


    %% Obtener datos del estrato
    %% Evaluación de datos y almacenamiento de valores numéricos
    tipo_e                = tipo;
    grade_str_e           = grade;
    layerThick_str_e      = layerThick;
    rho_str_e             = rho;
    refShearModul_str_e   = refShearModul;
    refBulkModul_str_e    = refBulkModul;
    uBulk_str_e           = uBulk;
    frictionAng_str_e     = frictionAng;
    vPerm_str_e           = vPerm;
    hPerm_str_e           = hPerm;
    Vs_str_e              = Vs;
    refPress_str_e        = refPress;
    surf_str_e            = surf;
    e_str_e               = e;
    contrac1_str_e        = contrac1;
    contrac3_str_e        = contrac3;
    dilat1_str_e          = dilat1;
    dilat3_str_e          = dilat3;
    PTAng_str_e           = PTAng;
    cohesion_str_e        = cohesion;

    grade_e           = eval(grade_str_e)/100;
    layerThick_e      = eval(layerThick_str_e);
    rho_e             = eval(rho_str_e);
    refShearModul_e   = eval(refShearModul_str_e);
    refBulkModul_e    = eval(refBulkModul_str_e);
    uBulk_e           = eval(uBulk_str_e);
    frictionAng_e     = eval(frictionAng_str_e);
    vPerm_e           = eval(vPerm_str_e);
    hPerm_e           = eval(hPerm_str_e);
    Vs_e              = eval(Vs_str_e);
    refPress_e        = eval(refPress_str_e);
    surf_e            = eval(surf_str_e);
    e_e               = eval(e_str_e);
	contrac1_e        = eval(contrac1_str_e);
    contrac3_e        = eval(contrac3_str_e);
    dilat1_e          = eval(dilat1_str_e);
    dilat3_e          = eval(dilat3_str_e);
    PTAng_e           = eval(PTAng_str_e);
    cohesion_e        = eval(cohesion_str_e);
    
    
    %% Ruta de almacenamiento
    
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
  
    
    
    tipo{iedit}         =tipo_e;
    grade{iedit}        =grade_e;
    layerThick{iedit}   =layerThick_e;
    rho{iedit}          =rho_e;
    refShearModul{iedit}=refShearModul_e;
    refBulkModul{iedit} =refBulkModul_e;
    uBulk{iedit}        =uBulk_e;
    frictionAng{iedit}  =frictionAng_e;
    vPerm{iedit}        =vPerm_e;
    hPerm{iedit}        =hPerm_e;
    Vs{iedit}           =Vs_e;
    refPress{iedit}     =refPress_e;
    surf{iedit}         =surf_e;
    e{iedit}            =e_e;
    contrac1{iedit}     =contrac1_e;
    contrac3{iedit}     =contrac3_e;
    dilat1{iedit}       =dilat1_e;
    dilat3{iedit}       =dilat3_e;
    PTAng{iedit}        =PTAng_e;
    cohesion{iedit}     =cohesion_e;


    grade_str{iedit}           = grade_str_e;
    layerThick_str {iedit}     = layerThick_str_e;
    rho_str{iedit}             = rho_str_e;
    refShearModul_str{iedit}   = refShearModul_str_e;
    refBulkModul_str{iedit}    = refBulkModul_str_e;
    uBulk_str{iedit}           = uBulk_str_e;
    frictionAng_str{iedit}     = frictionAng_str_e;
    vPerm_str{iedit}           = vPerm_str_e;
    hPerm_str{iedit}           = hPerm_str_e;
    Vs_str{iedit}              = Vs_str_e;
    refPress_str{iedit}        =refPress_str_e;
    surf_str{iedit}            =surf_str_e;
    e_str{iedit}               = e_str_e;
    contrac1_str{iedit}        =contrac1_str_e;
    contrac3_str{iedit}        =contrac3_str_e;
    dilat1_str{iedit}          =dilat1_str_e;
    dilat3_str{iedit}          =dilat3_str_e;
    PTAng_str{iedit}           =PTAng_str_e;
    cohesion_str{iedit}        =cohesion_str_e;
    
    
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