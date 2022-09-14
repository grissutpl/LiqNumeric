function varargout = gui_liq(varargin)
% GUI_LIQ MATLAB code for gui_liq.fig
%      GUI_LIQ, by itself, creates a new GUI_LIQ or raises the existing
%      singleton*.
%
%      H = GUI_LIQ returns the handle to a new GUI_LIQ or the handle to
%      the existing singleton*.
%
%      GUI_LIQ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_LIQ.M with the given input arguments.
%
%      GUI_LIQ('Property','Value',...) creates a new GUI_LIQ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_liq_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_liq_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_liq

% Last Modified by GUIDE v2.5 14-Mar-2019 22:36:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_liq_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_liq_OutputFcn, ...
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


% --- Executes just before gui_liq is made visible.
function gui_liq_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

global p_idiom path_master figHandle

    % Mover GUI al centro de la panatalla
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
    column_tipo (handles,p_idiom)
    %figHandle = varargin{1};
guidata(hObject, handles);

% UIWAIT makes gui_liq wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_liq_OutputFcn(hObject, eventdata, handles) 
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
    set(handles.text_profD,'String',dat_idiom.text_profD)
    set(handles.btn_liq,'String',dat_idiom.btn_liq)
    
    set(hObject,'Name',dat_idiom.gui_name_liq)
   
function column_tipo (handles,p_idiom)
    global path_master
    
    path_dat = load(path_master,'path_proj');
    path_proj = path_dat.path_proj;
    proj_dat = load(path_proj,'columna');
    column =proj_dat.columna;
    str = 'Columna_';   
    for i = 1:column
        Cell{i}= strcat(str,num2str(i));
    end
    set(handles.pop_columnas,'string',Cell)

    

% --- Executes on selection change in pop_columnas.
function pop_columnas_Callback(hObject, eventdata, handles)
% hObject    handle to pop_columnas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_columnas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_columnas


% --- Executes during object creation, after setting all properties.
function pop_columnas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_columnas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_profD_Callback(hObject, eventdata, handles)
    global p_idiom
    dataControl2(hObject,p_idiom)

    
    
% --- Executes during object creation, after setting all properties.
function edit_profD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_profD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_liq.
function btn_liq_Callback(hObject, eventdata, handles)

    global p_idiom path_master figHandle
    
    dat_master = load(path_master,'path_projF');
    path_projF = dat_master.path_projF;
    column = get(handles.pop_columnas,'Value');

    if isempty(get(handles.edit_profD, 'String'))
        if p_idiom == 1
            msgbox('No se ha ingresado datos btn liquid','Error','error')
        elseif p_idiom == 2
            msgbox('No data entered','Error','error')
        end
    else
        prof = str2double(get(handles.edit_profD, 'String'));
        axes(figHandle);
        cla
        grafica_licuefaccion(path_projF,column,prof,p_idiom);
        figHandle = gca;
    end
  