function datosGeoCol(sElemX,waterTable,damp)
    
    % Obtener datos del estrato
    % Evaluación de datos y almacenamiento de valores numéricos
    
    waterTable_str  = waterTable;
    damp_str        = damp;

    
    % Necesito que sean del tipo cell para luego no hacerme lio
    % transformando datos para permutar.
    % Lo que pasa es que la función allcomb (la que permuta) requiere un
    % tipo de dato en específico, es decir, si metes celdas que todo sea
    % celdas, si metes matrices que todo sea matrices
    % allcomb(matriz,matriz,matriz) -> Perfecto
    % allcomb(celda,celda,celda,celda) -> Perfecto
    % allcomb(celda,matriz,celda,matriz) -> Ahi se tuerce la función jaja
    
    
    sElemX = num2cell(sElemX);
    waterTable  = num2cell(eval(strcat(waterTable,';')));
    damp        = num2cell(eval(strcat(damp,';'))/100);
    % Ruta de almacenamiento
    
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
     
    
    
    % Almacenamiento de datos
    name_colum = {'sElemX',...
               'waterTable',...
               'damp',...
               'waterTable_str',...
               'damp_str'
                };   
    % 
    
    save(path_proj,name_colum{:},'-append')
    
    
end