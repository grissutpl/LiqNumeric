function varargout = gui_regsis(varargin)
% GUI_REGSIS MATLAB code for gui_regsis.fig
%      GUI_REGSIS, by itself, creates a new GUI_REGSIS or raises the existing
%      singleton*.
%
%      H = GUI_REGSIS returns the handle to a new GUI_REGSIS or the handle to
%      the existing singleton*.
%
%      GUI_REGSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_REGSIS.M with the given input arguments.
%
%      GUI_REGSIS('Property','Value',...) creates a new GUI_REGSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_regsis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_regsis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_regsis

% Last Modified by GUIDE v2.5 03-Mar-2019 14:19:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_regsis_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_regsis_OutputFcn, ...
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


% --- Executes just before gui_regsis is made visible.
function gui_regsis_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
    
    global path_master p_idiom path_proj
    
    % Mover GUI al centro de la panatalla
    movegui(hObject,'center')
        
    % Ruta de archivo maestro
    if isdeployed
       path_master = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_master = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
 
    % Ruta del archivo de proyecto
    path_proj = load(path_master,'path_proj');
    path_proj = path_proj.path_proj;
    
    dat_master = load(path_master,'p_idiom');
    p_idiom = dat_master.p_idiom;
    
    % Cambio de idioma de la interfaz
    changIdiom(handles,hObject,p_idiom)
    
    % Colocar iconos de botones
    im = imread('1.png','BackGround',[240,240,240]/255);
    set(handles.btn_ayu,'CData',im)
    
    im = imread('16.png','BackGround',[240,240,240]/255);
    set(handles.btn_draw,'CData',im)
    
    % Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'path_sis','motionDT','faconv','famp');
    
    set(handles.edit_dti,'String',proj_dat.motionDT)
    set(handles.edit_fcn,'String',proj_dat.faconv)
    set(handles.edit_amp,'String',proj_dat.famp)
    set(handles.edit_path,'String',proj_dat.path_sis)
    
    defecto(handles)
    
    % dibuja la aceleracion
    if isfile(proj_dat.path_sis)
        dibujar(handles)
    else
        if strlength(proj_dat.path_sis) > 0
            if p_idiom == 1
                    msgbox('No existe el registro');
            elseif p_idiom == 2
                    msgbox('There is no seismic record');
            end
        end
    end
    
    
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_regsis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_regsis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function defecto(handles)
% Obtener ruta de archivo
    global p_idiom
    
    x = 0;
    y = 0;
    axes(handles.axes1)
    plot(x,y)
    
    if p_idiom == 1
        xlabel('Tiempo (s)')
        ylabel('Aceleración (m/s^{2})')
    elseif p_idiom == 2
        xlabel('Time (s)')
        ylabel('Aceleration (m/s^{2})')
    end



function dibujar(handles)

    % Obtener ruta de archivo
    global path_proj p_idiom
    
    % Almacenar ruta de archivo
    path_sis = load(path_proj,'path_sis');
    path_sis = path_sis.path_sis;
      
    motionDT = str2double(get(handles.edit_dti,'String'));
    faconv = str2double(get(handles.edit_fcn,'String'));
    amplif = str2double(get(handles.edit_amp,'String'));
       
    axes(handles.axes1)
    plotAsis(path_sis,motionDT,faconv,amplif)
    
    if p_idiom == 1
        xlabel('Tiempo (s)')
        ylabel('Aceleración (m/s^{2})')
    elseif p_idiom == 2
        xlabel('Time (s)')
        ylabel('Aceleration (m/s^{2})')
    end

function changIdiom(handles,hObject,p_idiom)

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

    % Cargar paquete de lenguaje

    dat_idiom = load(path_idiom);
    
    % Cambiar idioma de interfaz
    set(handles.text_dti,'String',dat_idiom.text_dti)
    set(handles.text_urs,'String',dat_idiom.text_urs)
    set(handles.text_fcn,'String',dat_idiom.text_fcn)
    set(handles.text_amp,'String',dat_idiom.text_amp)
    set(handles.text_path,'String',dat_idiom.text_path)
    set(handles.uip_regs,'Title',dat_idiom.uip_regs)
    set(handles.uip_file,'Title',dat_idiom.uip_file)
    set(handles.uip_aclgr,'Title',dat_idiom.uip_aclgr)
    set(handles.btn_load,'String',dat_idiom.btn_load)
    set(handles.btn_ok,'String',dat_idiom.btn_ok)
    set(hObject,'Name',dat_idiom.gui_nam_regsis)
    
% --- Executes on button press in btn_ok.
function btn_ok_Callback(hObject, eventdata, handles)
% Almacenar datos

    global path_master path_proj
    
    motionDT = str2double(get(handles.edit_dti,'String'));
    faconv = str2double(get(handles.edit_fcn,'String'));
    famp = str2double(get(handles.edit_amp,'String'));
    path_sis = get(handles.edit_path,'String');
    % Ruta de carpeta de proyecto
    path_projF = load(path_master,'path_projF');
    path_projF = path_projF.path_projF;
    
    % Leer archivo de registro sísmico
    sismo = load(path_sis);
        
    % Crear el archivo  velocityHistory.out
    motionStep = historialVel(path_projF,sismo,motionDT,faconv,famp);
    
    motionDT = num2cell(motionDT);
    motionStep = num2cell(motionStep);
    
    save(path_proj,'motionDT','faconv','famp','motionStep','-append')
    
    close(gui_regsis)

% --- Executes on button press in btn_load.
function btn_load_Callback(hObject, eventdata, handles)
% Cargar registro sísmico

    global path_proj p_idiom

    % Obtener ruta de archivo
    if p_idiom == 1
        mse = 'Seleccionar el registro sísmico';
    elseif p_idiom == 2
        mse = 'Select the seismic record';
    end
    
	[filename,path] = uigetfile('*.txt',mse);
    
    if filename == 0
       return 
    end

	path_sis = strcat(path,filename);
    
    set(handles.edit_path,'String',path_sis)
    save(path_proj,'path_sis','-append')

    dibujar(handles)


    
    
    
function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path as text
%        str2double(get(hObject,'String')) returns contents of edit_path as a double


% --- Executes during object creation, after setting all properties.
function edit_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dti_Callback(hObject, eventdata, handles)

    global p_idiom
    
    estado = dataControl2(handles.edit_dti,p_idiom);
    
    if estado
        return
    end
    
    defecto(handles)


    
    
% --- Executes during object creation, after setting all properties.
function edit_dti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fcn_Callback(hObject, eventdata, handles)
    
    global p_idiom
    
    estado = dataControl2(handles.edit_fcn,p_idiom);
    
    if estado
        return
    end
    
    defecto(handles)


% --- Executes during object creation, after setting all properties.
function edit_fcn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fcn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ppm_urs.
function ppm_urs_Callback(hObject, eventdata, handles)
% Colocar factr de registro

    factor = get(handles.ppm_urs,'Value');

    switch factor
        case 1
            set(handles.edit_fcn,'String','9.81');
        case 2
            set(handles.edit_fcn,'String','0.01');
        case 3
            set(handles.edit_fcn,'String','0.001');
    end
    
    
    defecto(handles)
    
% --- Executes during object creation, after setting all properties.
function ppm_urs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppm_urs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amp_Callback(hObject, eventdata, handles)
    global p_idiom
    
    estado = dataControl2(handles.edit_amp,p_idiom);
    
    if estado
        return
    end
    
    defecto(handles)


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_ayu.
function btn_ayu_Callback(hObject, eventdata, handles)
    global p_idiom   
    if p_idiom == 1
        msgbox({'Conversión del registro sísmico de aceleraciones a velocidades.';
            'El usuario debe cargar el archivo de aceleración sin encabezados y en formato .txt'});
    elseif p_idiom == 2
            msgbox({'Conversion of seismic record from acceleration to velocity.'
            'The user must load the acceleration file without headers and in .txt format.'});
    end


% --- Executes on button press in btn_draw.
function btn_draw_Callback(hObject, eventdata, handles)

    try
        dibujar(handles)
    end
