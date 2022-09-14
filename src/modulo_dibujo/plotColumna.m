function plotColumna(num_col)
    
    % Ruta de archivos de estratos
    if isdeployed
       path_master = strcat(ctfroot,'\mat\mfbi_001.mat');
    else
       path_master = strcat(pwd,'\mat\mfbi_001.mat');
    end
    
    path_dat = load(path_master,'path_projF');
    path_projF = path_dat.path_projF;
    
	% Leer archivo para ploteo de columna
    plot_dat = load(strcat(path_projF,'post_proceso\colplotdat.mat'));
    vec_plot = plot_dat.vec_plot;
    
        
    % Número de estratos
    ne = size(vec_plot{1,1}{1},2)

    for i = 1:ne
       
        if i == 1
           h_temp = 0;
        end
        
        
        
        
        tipo = cell2mat(vec_plot{num_col,1}{1}(i))
        m1 = cell2mat(vec_plot{num_col,1}{2}(i))
        h = cell2mat(vec_plot{num_col,1}{3}(i))
        b = vec_plot{num_col,1}{4};
                        
        if i == ne
            m2 = cell2mat(vec_plot{num_col,1}{2}(i))
        else
            m2 = cell2mat(vec_plot{num_col,1}{2}(i+1))
        end
        
        if i>1
           hold on 
        end
        
        plotSq2m(b,h,m1,m2,[0,h_temp])

        h_temp = h+h_temp;
        
    end
    
end