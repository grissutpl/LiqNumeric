function varargout = gui_comparacion(varargin)
% GUI_COMPARACION MATLAB code for gui_comparacion.fig
%      GUI_COMPARACION, by itself, creates a new GUI_COMPARACION or raises the existing
%      singleton*.
%
%      H = GUI_COMPARACION returns the handle to a new GUI_COMPARACION or the handle to
%      the existing singleton*.
%
%      GUI_COMPARACION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_COMPARACION.M with the given input arguments.
%
%      GUI_COMPARACION('Property','Value',...) creates a new GUI_COMPARACION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_comparacion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_comparacion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_comparacion

% Last Modified by GUIDE v2.5 31-May-2021 21:32:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_comparacion_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_comparacion_OutputFcn, ...
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


% --- Executes just before gui_comparacion is made visible.
function gui_comparacion_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Deshabilitar edit_time1 y edit_time2

    set(handles.edit_time1,'enable','off')
    set(handles.edit_time2,'enable','off')

% Variables globales requeridas
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
    
    im = imread('1.png','BackGround',[240,240,240]/255);
    set(handles.btn_info1,'CData',im)
    im = imread('1.png','BackGround',[240,240,240]/255);
    set(handles.btn_info2,'CData',im)
    
    changIdiom(hObject,handles,path_idiom)
    column_tipo (handles,p_idiom)
%     axes(figHandle);
%     cla 'reset'
%     figHandle= gca;
guidata(hObject, handles);

% UIWAIT makes gui_comparacion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_comparacion_OutputFcn(hObject, eventdata, handles) 
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
    set(handles.uib_g1,'Title',dat_idiom.uib_g1)
    set(handles.uib_g2,'Title',dat_idiom.uib_g1)
    set(handles.radio_prof1,'String',dat_idiom.radio_prof1)
    set(handles.radio_prof2,'String',dat_idiom.radio_prof1)
    set(handles.radio_time1,'String',dat_idiom.radio_time1)
    set(handles.radio_time2,'String',dat_idiom.radio_time1)
    set(handles.radio_total1,'String',dat_idiom.radio_total1)
    set(handles.radio_total2,'String',dat_idiom.radio_total1)
    set(handles.btn_grafica1,'String',dat_idiom.btn_grafica1)
    set(handles.btn_grafica2,'String',dat_idiom.btn_grafica1)
    
    set(hObject,'Name',dat_idiom.gui_nam)
   
function column_tipo (handles,p_idiom)
    global path_master
    
    path_dat = load(path_master,'path_proj');
    path_proj = path_dat.path_proj;
    proj_dat = load(path_proj,'columna');
    column =proj_dat.columna;
     
    if p_idiom == 1
        set(handles.pop_tipo1,'string',{'Desplazamiento X' 'Desplazamiento Y' 'Aceleración X' 'Aceleración Y' 'Presión de Poro' 'Esfuerzos Axiales XX' 'Esfuerzos Axiales YY' 'Esfuerzos de Corte XY' 'Deformación XX' 'Deformación YY' 'Distorsión XY'})
        set(handles.pop_tipo2,'string',{'Desplazamiento X' 'Desplazamiento Y' 'Aceleración X' 'Aceleración Y' 'Presión de Poro' 'Esfuerzos Axiales XX' 'Esfuerzos Axiales YY' 'Esfuerzos de Corte XY' 'Deformación XX' 'Deformación YY' 'Distorsión XY'})
        str = 'Columna_';
    elseif p_idiom == 2
        set(handles.pop_tipo1,'string',{'Displacement X' 'Displacement Y' 'Acceleration X' 'Acceleration Y' 'Pore Pressure' 'Axial stress XX' 'Axial stress YY' 'Shear stress XY' 'Deformation XX' 'Deformation YY' 'Distortion XY'})
        set(handles.pop_tipo2,'string',{'Displacement X' 'Displacement Y' 'Acceleration X' 'Acceleration Y' 'Pore Pressure' 'Axial stress XX' 'Axial stress YY' 'Shear stress XY' 'Deformation XX' 'Deformation YY' 'Distortion XY'})
        str = 'Column_';
    end
     
    for i = 1:column
        Cell{i}= strcat(str,num2str(i));
    end
    set(handles.pop_columna1,'string',Cell)
    set(handles.pop_columna2,'string',Cell)

    
      
function edit_prof2_Callback(hObject, eventdata, handles)
    global p_idiom
    dataControl2(hObject,p_idiom)
    

% --- Executes during object creation, after setting all properties.
function edit_prof2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prof2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time2_Callback(hObject, eventdata, handles)
    global p_idiom
    dataControl2(hObject,p_idiom)

% --- Executes during object creation, after setting all properties.
function edit_time2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_columna2.
function pop_columna2_Callback(hObject, eventdata, handles)
% hObject    handle to pop_columna2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_columna2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_columna2


% --- Executes during object creation, after setting all properties.
function pop_columna2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_columna2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_tipo2.
function pop_tipo2_Callback(hObject, eventdata, handles)
% hObject    handle to pop_tipo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_tipo2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_tipo2


% --- Executes during object creation, after setting all properties.
function pop_tipo2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_tipo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_grafica2.
function btn_grafica2_Callback(hObject, eventdata, handles)
    global p_idiom path_master figHandle
    
    dat_master = load(path_master,'path_proj','path_projF');
    path_projF = dat_master.path_projF;
    path_proj = dat_master.path_proj;
    dat_proj = load(path_proj,'motionDT','motionStep');
    dT = dat_proj.motionDT{1};
    step = dat_proj.motionStep{1};
    column = get(handles.pop_columna2,'Value');
    tipo = get(handles.pop_tipo2,'Value');
    m=0;
    n=0;
    xlab='';
    ylab='';
    if get(handles.radio_prof2, 'Value')==1
        if isempty(get(handles.edit_prof2, 'String'))
            if p_idiom == 1
                msgbox('No se ha ingresado datos','Error','error')
            elseif p_idiom == 2
                msgbox('No data entered','Error','error')
            end
        else
            prof = str2double(get(handles.edit_prof2, 'String'));
            
            [m,n,xlab,ylab]=grafica_profundidad(path_projF,column,tipo,prof,p_idiom);       
            
        end
    elseif get(handles.radio_time2, 'Value')==1
        if isempty(get(handles.edit_time2, 'String'))
            if p_idiom == 1
                msgbox('No se ha ingresado datos','Error','error')
            elseif p_idiom == 2
                    msgbox('No data entered','Error','error')
            end
        else
            time = str2double(get(handles.edit_time2, 'String'));
            [m,n,xlab,ylab]=grafica_tiempo(path_projF,column,tipo,time,dT,step,p_idiom);
        end
    elseif get(handles.radio_total2, 'Value')==1
      
        [m,n,xlab,ylab]=grafica_total(path_projF,column,tipo,p_idiom);
    end
 
    axes(figHandle);
    %cla 'reset'
    fig2=subplot(1,2,2);
    cla(fig2);
    plot(m,n)
    grid on
    xlabel(xlab)
    ylabel(ylab)
    figHandle = gca;
    
    

function edit_prof1_Callback(hObject, eventdata, handles)
    global p_idiom
    dataControl2(hObject,p_idiom)

% --- Executes during object creation, after setting all properties.
function edit_prof1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prof1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time1_Callback(hObject, eventdata, handles)
    global p_idiom
    dataControl2(hObject,p_idiom)

% --- Executes during object creation, after setting all properties.
function edit_time1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_columna1.
function pop_columna1_Callback(hObject, eventdata, handles)
% hObject    handle to pop_columna1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_columna1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_columna1


% --- Executes during object creation, after setting all properties.
function pop_columna1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_columna1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_tipo1.
function pop_tipo1_Callback(hObject, eventdata, handles)
% hObject    handle to pop_tipo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_tipo1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_tipo1


% --- Executes during object creation, after setting all properties.
function pop_tipo1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_tipo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_grafica1.
function btn_grafica1_Callback(hObject, eventdata, handles)
    global p_idiom path_master figHandle
    
    dat_master = load(path_master,'path_proj','path_projF');
    path_projF = dat_master.path_projF;
    path_proj = dat_master.path_proj;
    dat_proj = load(path_proj,'motionDT','motionStep');
    dT = dat_proj.motionDT{1};
    step = dat_proj.motionStep{1};
    column = get(handles.pop_columna1,'Value');
    tipo = get(handles.pop_tipo1,'Value');
    m=0;
    n=0;
    xlab='';
    ylab='';
    if get(handles.radio_prof1, 'Value')==1
        if isempty(get(handles.edit_prof1, 'String'))
            if p_idiom == 1
                msgbox('No se ha ingresado datos','Error','error')
            elseif p_idiom == 2
                msgbox('No data entered','Error','error')
            end
        else
            prof = str2double(get(handles.edit_prof1, 'String'));
            
            [m,n,xlab,ylab]=grafica_profundidad(path_projF,column,tipo,prof,p_idiom);       
            
        end
    elseif get(handles.radio_time1, 'Value')==1
        if isempty(get(handles.edit_time1, 'String'))
            if p_idiom == 1
                msgbox('No se ha ingresado datos','Error','error')
            elseif p_idiom == 2
                    msgbox('No data entered','Error','error')
            end
        else
            time = str2double(get(handles.edit_time1, 'String'));
            [m,n,xlab,ylab]=grafica_tiempo(path_projF,column,tipo,time,dT,step,p_idiom);
        end
    elseif get(handles.radio_total1, 'Value')==1
      
        [m,n,xlab,ylab]=grafica_total(path_projF,column,tipo,p_idiom);
    end
     axes(figHandle);
    %cla 'reset'
    fig1=subplot(1,2,1);
    cla(fig1);
    plot(m,n)
    grid on
    xlabel(xlab)
    ylabel(ylab)
    figHandle = gca;


% --- Executes on button press in btn_info2.
function btn_info2_Callback(hObject, eventdata, handles)
    col = get(handles.pop_columna2,'Value');
    gui_info(col)

% --- Executes on button press in btn_info1.
function btn_info1_Callback(hObject, eventdata, handles)

	col = get(handles.pop_columna1,'Value');
    gui_info(col)

% Dependiendo de la seleccion deshabilitar o habilitar edit_prod1,
% edit_prof2, edit_time1, edit_time2
function uib_g1_SelectionChangedFcn(hObject, eventdata, handles)
    
    value = get(hObject,'Tag');

    if strcmp(value, 'radio_prof1')

        set(handles.edit_prof1,'enable','on')
        set(handles.edit_time1,'enable','off')
        set(handles.edit_time1,'String',' ')

    elseif strcmp(value, "radio_time1")
        set(handles.edit_time1,'enable','on')
        set(handles.edit_prof1,'enable','off')
        set(handles.edit_prof1,'String',' ')

    elseif strcmp(value, 'radio_total1')
        set(handles.edit_time1,'enable','off')
        set(handles.edit_prof1,'enable','off')
        set(handles.edit_time1,'String',' ')
        set(handles.edit_prof1,'String',' ')
    end
    

% --- Executes when selected object is changed in uib_g2.
function uib_g2_SelectionChangedFcn(hObject, eventdata, handles)

value = get(hObject,'Tag');

if strcmp(value, 'radio_prof2')
    
    set(handles.edit_prof2,'enable','on')
    set(handles.edit_time2,'enable','off')
    set(handles.edit_time2,'String',' ')
        
elseif strcmp(value, 'radio_time2')
    set(handles.edit_time2,'enable','on')
    set(handles.edit_prof2,'enable','off')
    set(handles.edit_prof2,'String',' ')
    
elseif strcmp(value, 'radio_total2')
    set(handles.edit_time2,'enable','off')
    set(handles.edit_prof2,'enable','off')
    set(handles.edit_time2,'String',' ')
    set(handles.edit_prof2,'String',' ')
end
