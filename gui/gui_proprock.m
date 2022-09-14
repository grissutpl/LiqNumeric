function varargout = gui_proprock(varargin)
% Geometr�a de la columna de suelo

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_proprock_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_proprock_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_proprock is made visible.
function gui_proprock_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
    
    % Variables glonales requeridas
    global p_idiom path_master

    % Mover GUI al centro de la panatalla
    movegui(hObject,'center')
        
    % Cargar cadenas de texto a los recuadros de texto
    % Ruta de archivo maestro
    if isdeployed
       path_master = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_master = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    dat_master = load(path_master,'path_proj','p_idiom');
    path_proj = dat_master.path_proj;
    
    dat_str = load(path_proj,'rockDen_str','rockVS_str');
    
     set(handles.edit_drm,'String',dat_str.rockDen_str)
     set(handles.edit_voc,'String',dat_str.rockVS_str)
    
    p_idiom = dat_master.p_idiom;
    
    if p_idiom == 1
        if isdeployed
            path_idiom = strcat(ctfroot,'\idiom\pidiom_es.mat');
        else
           path_idiom = strcat(pwd,'\idiom\pidiom_es.mat'); 
        end
    elseif p_idiom == 2
        
        if isdeployed
            path_idiom = strcat(ctfroot,'\idiom\pidiom_en.mat');
        else
           path_idiom = strcat(pwd,'\idiom\pidiom_en.mat'); 
        end    
    end
    
    changIdiom(hObject,handles,path_idiom)
    
    % Colocar imagen del modelo de columna de suelo
    % Condicionar para el paquete de dioma
    
    axes(handles.axes1)
    
    if p_idiom == 1
        im = imread('2.png','BackGround',[1,1,1]);
    elseif p_idiom == 2
        im = imread('7.png','BackGround',[1,1,1]);
    end
    image(im)
    axis image
    axis off
    
    % Colocar iconos de botones
    im = imread('1.png','BackGround',[1,1,1]);
    set(handles.btn_ayu,'CData',im)
    
guidata(hObject, handles);

% UIWAIT makes gui_proprock wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_proprock_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function changIdiom(hObject,handles,path_idiom)

    % Cargar paquete de lenguaje

    dat_idiom = load(path_idiom);
    
    % Cambiar idioma de interfaz
    set(handles.uip_prm,'Title',dat_idiom.uip_prm)
    set(handles.uip_mcs,'Title',dat_idiom.uip_mcs)
    set(handles.text_drm,'String',dat_idiom.text_drm)
    set(handles.text_voc,'String',dat_idiom.text_voc)
    set(handles.btn_ok,'String',dat_idiom.btn_ok)
    
    set(hObject,'Name',dat_idiom.gui_nam_proprock)
    


% function edit_aco_Callback(hObject, eventdata, handles)
% % Control de datos
%     global p_idiom
%     dataControl(hObject,p_idiom)
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit_aco_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit_aco (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% function edit2_Callback(hObject, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% % --- Executes during object creation, after setting all properties.
% function edit2_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function edit_voc_Callback(hObject, eventdata, handles)
% Control de datos
    global p_idiom
%     dataControl(hObject,p_idiom)


% --- Executes during object creation, after setting all properties.
function edit_voc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_voc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_drm_Callback(hObject, eventdata, handles)
% Control de datos
    global p_idiom
%     dataControl(hObject,p_idiom)


% --- Executes during object creation, after setting all properties.
function edit_drm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_voc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function edit_amo_Callback(hObject, eventdata, handles)
% % Control de datos
%     global p_idiom
%     dataControl(hObject,p_idiom)
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit_amo_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit_voc (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% function edit5_Callback(hObject, eventdata, handles)
% % hObject    handle to edit5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit5 as text
% %        str2double(get(hObject,'String')) returns contents of edit5 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes on button press in pushbutton1.
% function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_ayu.
function btn_ayu_Callback(hObject, eventdata, handles)

    global p_idiom
    % Condicionar con el paquete de lenguaje

    if p_idiom == 1
        mse = '';
    elseif p_idiom == 2
        mse = '';
    end
        
    msgbox(mse,'modal')


% --- Executes on button press in btn_aco_vec.
% function btn_aco_vec_Callback(hObject, eventdata, handles)
    
%     % Variables globales requeridas
%     global path_master
% 
%     % Inicializar asistente de vectores
%     gui_vecman
%     
%     % Esperar acci�n de la GUI
%     uiwait
%     
%     % Comprobar creaci�n de vector
%     dat_master = load(path_master,'winc','vec_str');
% 
%     if dat_master.winc
%         set(handles.edit_aco,'String',dat_master.vec_str)
%         winc = false;
%         save(path_master,'winc','-append')
%     end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_drm_vec.
function btn_drm_vec_Callback(hObject, eventdata, handles)
% Variables globales requeridas
    global path_master

    % Inicializar asistente de vectores
    gui_vecman
    
    % Esperar acci�n de la GUI
    uiwait
    
    % Comprobar creaci�n de vector
    dat_master = load(path_master,'winc','vec_str');

    if dat_master.winc
        set(handles.edit_drm,'String',dat_master.vec_str)
        winc = false;
        save(path_master,'winc','-append')
    end


% --- Executes on button press in btn_voc_vec.
function btn_voc_vec_Callback(hObject, eventdata, handles)
% Variables globales requeridas
    global path_master

    % Inicializar asistente de vectores
    gui_vecman
    
    % Esperar acci�n de la GUI
    uiwait
    
    % Comprobar creaci�n de vector
    dat_master = load(path_master,'winc','vec_str');

    if dat_master.winc
        set(handles.edit_voc,'String',dat_master.vec_str)
        winc = false;
        save(path_master,'winc','-append')
    end



% --- Executes on button press in btn_ok.
function btn_ok_Callback(hObject, eventdata, handles)
% Almacenar datos de la geometr�a de la columna
    
    % Obtener datos de los recuadros de texto
    rockDen = get(handles.edit_drm,'String');
    rockVS = get(handles.edit_voc,'String');
    
    datosPropRock(rockDen,rockVS)

    
    close(gui_proprock)
    
% --- Eliminar
function btn_ok_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btn_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
