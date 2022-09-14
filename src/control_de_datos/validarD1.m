function estado = validarD1(handles)
    
    espanol = {'Los datos del ancho de columna no son válidos',...
               'Los datos de la pendiente del suelo no son válidos',...
               'Los datos de la profundidad del nivel freático no son validos',...
               'Los datos de amortiguamiento no son válidos'
              };

          paq_idiom = espanol;
          
          estado = true;
          % Validar datos del ancho de columna
          try
              eval(strcat(get(handles.edit_wc,'String'),';'))
          catch
              errordlg(paq_idiom(1),'Error','modal')
              estado = false;
              return
          end
          
          % Validar datos de pendiente
          try
              eval(get(handles.edit_soilslope,'String'));
          catch
              errordlg(paq_idiom(2),'Error','modal')
              estado = false;
              return
          end
          
          % Validar datos de nivel freático
          try
              eval(get(handles.edit_wfre,'String'));
          catch
              errordlg(paq_idiom(3),'Error','modal')
              estado = false;
              return
          end
          
          % Validar datos de amortiguamiento
          try
              eval(get(handles.edit_amort,'String'));
          catch
              errordlg(paq_idiom(4),'Error','modal')
              estado = false;
              return
          end
    
    
end