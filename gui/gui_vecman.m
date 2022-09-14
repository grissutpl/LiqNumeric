function varargout = gui_vecman(varargin)
% GUI_VECMAN MATLAB code for gui_vecman.fig
%      GUI_VECMAN, by itself, creates a new GUI_VECMAN or raises the existing
%      singleton*.
%
%      H = GUI_VECMAN returns the handle to a new GUI_VECMAN or the handle to
%      the existing singleton*.
%
%      GUI_VECMAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_VECMAN.M with the given input arguments.
%
%      GUI_VECMAN('Property','Value',...) creates a new GUI_VECMAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_vecman_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_vecman_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_vecman

% Last Modified by GUIDE v2.5 17-Feb-2019 16:04:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_vecman_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_vecman_OutputFcn, ...
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


% --- Executes just before gui_vecman is made visible.
function gui_vecman_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for gui_vecman
handles.output = hObject;
    global p_idiom
    % Mover GUI al centro de la pantalla
    movegui(hObject,'center')

    % Cargar cadenas de texto a los recuadros de texto
    % Ruta de archivo maestro
    if isdeployed
       path_master = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_master = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    dat_master = load(path_master,'p_idiom');
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
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_vecman wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_vecman_OutputFcn(hObject, eventdata, handles) 
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
    set(handles.uip_dve,'Title',dat_idiom.uip_dve)
    set(handles.uip_tel,'Title',dat_idiom.uip_tel)
    set(handles.text_vin,'String',dat_idiom.text_vin)
    set(handles.text_vfi,'String',dat_idiom.text_vfi)
    set(handles.text_nue,'String',dat_idiom.text_nue)
    set(handles.btn_ok,'String',dat_idiom.btn_ok)
    set(handles.btn_eval,'String',dat_idiom.btn_eval)
    
    set(hObject,'Name',dat_idiom.gui_nam_vecman)


% --- Executes on button press in btn_eval.
function btn_eval_Callback(hObject, eventdata, handles)
% Generar elementos del vetor
     
    edit_nue_Callback(handles.edit_nue, eventdata, handles)
    edit_vin_Callback(handles.edit_vin, eventdata, handles)
    edit_vfi_Callback(handles.edit_vfi, eventdata, handles)
    
    % Captura de valores de los recuadros de texto
    vi = str2double(get(handles.edit_vin,'String'));
    vf = str2double(get(handles.edit_vfi,'String'));
    ne = str2double(get(handles.edit_nue,'String'));
        
    if any(isnan([vi,vf,ne]))
        return
    end
    
    
    
    vec_val = linspace(vi,vf,ne);
    
    set(handles.uitable1,'Data',vec_val)
    set(handles.btn_ok,'Enable','on')


function edit_vin_Callback(hObject, eventdata, handles)
% Control de datos
    global p_idiom

    dataControl(hObject,p_idiom)
    nanControl(hObject,p_idiom)
    % Inhabilitar botón aceptar
    set(handles.btn_ok,'Enable','off')

% --- Executes during object creation, after setting all properties.
function edit_vin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vfi_Callback(hObject, eventdata, handles)
% Control de datos
    global p_idiom

    dataControl(hObject,p_idiom)
    nanControl(hObject,p_idiom)
    % Inhabilitar botón aceptar
    set(handles.btn_ok,'Enable','off')
    
function edit_vfi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vfi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nue_Callback(hObject, eventdata, handles)
% Control de datos
    global p_idiom

    dataControl(hObject,p_idiom)
    
    val = str2double(get(hObject,'String'));
    
    if val <= 0 || isnan(val)
       if p_idiom == 1
           mse = 'El número de elementos debe ser mayor a cero.';
       elseif p_idiom == 2
           mse = 'The number of elements must be greater than zero';
       end
       
       errordlg(mse,'Error','modal')
       uiwait
       set(hObject,'String','1')
    end
    
    % Inhabilitar botón aceptar
    set(handles.btn_ok,'Enable','off')

% --- Executes during object creation, after setting all properties.
function edit_nue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btn_ok_Callback(hObject, eventdata, handles)
% Almacenar valores del vector
    global path_master
    
    % Captura de valores de los recuadros de texto
    vi = get(handles.edit_vin,'String');
    vf = get(handles.edit_vfi,'String');
    ne = get(handles.edit_nue,'String');
              
    % Generación de string de vector
    vec_str = strcat('linspace(',num2str(vi),',',num2str(vf),',',num2str(ne),')');
    
    % Variable de cambio de ventana
    winc = 'true';
    
    % Amacenar vector
    save(path_master,'vec_str','winc','-append')
    
    set(handles.btn_ok,'Enable','off')
    
    close(gui_vecman)
