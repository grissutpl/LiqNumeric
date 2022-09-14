function varargout = gui_col(varargin)
% GUI_COL MATLAB code for gui_col.fig
%      GUI_COL, by itself, creates a new GUI_COL or raises the existing
%      singleton*.
%
%      H = GUI_COL returns the handle to a new GUI_COL or the handle to
%      the existing singleton*.
%
%      GUI_COL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_COL.M with the given input arguments.
%
%      GUI_COL('Property','Value',...) creates a new GUI_COL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_col_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_col_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_col

% Last Modified by GUIDE v2.5 21-Mar-2019 09:53:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_col_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_col_OutputFcn, ...
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


% --- Executes just before gui_col is made visible.
function gui_col_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_col (see VARARGIN)

% Choose default command line output for gui_col
handles.output = hObject;
    % Variables globales requeridas
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
    dat_idiom = load(path_idiom);
    set(handles.btn_graf_conf,'String',dat_idiom.btn_graf_conf)
    set(hObject,'Name',dat_idiom.gui_nam_conf_col)

    column_tipo (handles,p_idiom)
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_col wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_col_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function column_tipo (handles,p_idiom)
    global path_master
    
    path_dat = load(path_master,'path_proj');
    path_proj = path_dat.path_proj;
    proj_dat = load(path_proj,'columna');
    column =proj_dat.columna;
     
    if p_idiom == 1
        str = 'Columna_';
    elseif p_idiom == 2
        str = 'Column_';
    end 
    for i = 1:column
        Cell{i}= strcat(str,num2str(i));
    end
    set(handles.pop_col_conf,'string',Cell)
    

% --- Executes on selection change in pop_col_conf.
function pop_col_conf_Callback(hObject, eventdata, handles)
% hObject    handle to pop_col_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_col_conf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_col_conf


% --- Executes during object creation, after setting all properties.
function pop_col_conf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_col_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_graf_conf.
function btn_graf_conf_Callback(hObject, eventdata, handles)
    global figHandle
    
    column = get(handles.pop_col_conf,'Value');
    axes(figHandle);
    fig1 = subplot(1,1,1);
    cla(fig1)
    plotColumna(column)
	figHandle = gca;
    
