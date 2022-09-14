% Datos de estrato
% Ruta de archivo maestro


    if isdeployed
       path_master = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_master = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    % Ruta de la carpeta archivo de proyecto
    dat_path = load(path_master,'path_proj','path_projF');
    % Archivo
    path_proj = dat_path.path_proj;
    % Carpeta
    path_projF = dat_path.path_projF;
    
    % Cargar datos del proyecto
    proj_dat = load(path_proj);
    
    % Número de estratos
    numLayers = proj_dat.numLayers;
    
    % Datos generales de columna
    sElemX      = proj_dat.sElemX;
    waterTable  = proj_dat.waterTable;
    damp        = proj_dat.damp;
    rockDen     = proj_dat.rockDen;
    rockVS      = proj_dat.rockVS;
    motionDT    = proj_dat.motionDT;
	motionStep  = proj_dat.motionStep;
    
    
    
    
    
    
    est = cell(1,numLayers);
    for i = 1:numLayers
        tipo        	= proj_dat.tipo{i};
        grade       	= proj_dat.grade{i};
        layerThick 		= proj_dat.layerThick{i};
        rho 			= proj_dat.rho{i};
        refShearModul   = proj_dat.refShearModul{i};
        refBulkModul    = proj_dat.refBulkModul{i};       
        uBulk           = proj_dat.uBulk{i};
        frictionAng     = proj_dat.frictionAng{i};       
        vPerm   		= proj_dat.vPerm{i};
        hPerm   		= proj_dat.hPerm{i};
		Vs      		= proj_dat.Vs{i};
		refPress		= proj_dat.refPress{i};
		surf		    = proj_dat.surf{i};
		e       		= proj_dat.e{i};
        PTAng     		= proj_dat.PTAng{i};
        contrac1  		= proj_dat.contrac1{i};
        contrac3  		= proj_dat.contrac3{i};
        dilat1    		= proj_dat.dilat1{i};
        dilat3    		= proj_dat.dilat3{i};
		cohesion		= proj_dat.cohesion{i};

        
        est_perm = allcomb(tipo,grade,layerThick,rho,refShearModul,...
                 refBulkModul,uBulk,frictionAng,vPerm,hPerm,Vs,refPress,...
                 surf,e,PTAng,contrac1,contrac3,dilat1,dilat3,cohesion);
        
%         est_perm = allcomb(tipo,grade,layerThick,dr,rho,refShearModul,...
%             refBulkModul,uBulk,frictionAng,e,vPerm,hPerm,Vs,contrac1,...
%             contrac3,dilat1,dilat3,PTAng);
        
        est{i} = mat2cell(est_perm,ones(size(est_perm,1),1));
        
    end
    % Permutar columna
    tic
    col_per = allcomb(sElemX,waterTable,damp,rockDen,rockVS,motionDT,motionStep,est{:});
    toc
    
%     save('mfpi.txt','col_per','-ascii','-double','-tabs')
    save(strcat(path_projF,'pre_proceso\mfpi.mat'),'col_per','-v7.3')
%     clear
    