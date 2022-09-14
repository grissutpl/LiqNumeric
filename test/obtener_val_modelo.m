function valbusqueda = obtener_val_modelo(nomfile,varbusqueda)
    contentFile = fileread(nomfile);
    pattern = '([\w]+)\s([\w_]+)\s([\.\d\+\w_]+)';
    data = regexp(contentFile, pattern, 'tokens');
    numlineas = length(data);
    valbusqueda = '';
    for i =1:numlineas
        nom_var = data{i}(2);
        if strcmp(char(nom_var), varbusqueda)
            valbusqueda = char(data{i}(3));
            break;
        end
    end
end

