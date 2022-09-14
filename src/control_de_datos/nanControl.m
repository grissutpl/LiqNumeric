function nanControl(hObject,p_idiom)
    % Obtener el valor del cuadro de texto
    valor = str2double(get(hObject,'String'));

    if isnan(valor)
        if p_idiom == 1
        mse = {'Valor ingresado no válido.';...
               'Se admiten solamente valores númericos.'};
        elseif p_idiom == 2
            mse = {'Invalid value entered.';...
               'Only numeric values are allowed.'};
        end
        errordlg(mse,'Error','Modal')
        uiwait
        set(hObject,'String',0)
    end
end