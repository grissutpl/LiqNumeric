function datosPropRock(rockDen,rockVS)
    
    %% Obtener datos del estrato
    %% Evaluación de datos y almacenamiento de valores numéricos
    
    rockDen_str   = rockDen;
    rockVS_str    = rockVS;
    
    rockDen  = num2cell(eval(strcat(rockDen,';')));
    rockVS        = num2cell(eval(strcat(rockVS,';')));   
    
    %% Ruta de almacenamiento
    
    if isdeployed
       path_file = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_file = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    path_file = load(path_file,'path_proj');
    path_proj = path_file.path_proj;
    
%     % Obtener valores previamente almacenados
%     dat_cpa = load(path_proj);
%      
%     sElemX      = [dat_cpa.sElemX,sElemX];
%     waterTable  = [dat_cpa.waterTable,waterTable];
%     damp        = [dat_cpa.damp,damp];
%     numLayers   = [dat_cpa.numLayers,numLayers];
%     rockDen     = [dat_cpa.rockDen,rockDen];
%     rockVS      = [dat_cpa.rockVS,rockVS];
%     motionDT    = [dat_cpa.motionDT,motionDT];
     
    
    
    %% Almacenamiento de datos
    name_colum = {'rockDen',...
               'rockVS',...
               'rockDen_str',...
               'rockVS_str'
                };   
    %% 
    
    save(path_proj,name_colum{:},'-append')
    
    
end