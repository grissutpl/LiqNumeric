function dataControl(hObject,p_idiom)
    % Obtener el valor del cuadro de texto
    valor = get(hObject,'String');
    
    try 
        eval(strcat(valor,';'))
    catch
        if p_idiom == 1
        mse = {'Valor ingresado no v�lido.';...
               'Se admiten solamente valores n�mericos.'};
        elseif p_idiom == 2
            mse = {'Invalid value entered.';...
               'Only numeric values are allowed.'};
        end
           
        errordlg(mse,'Error','Modal')
        uiwait
        set(hObject,'String',0)
    end
end