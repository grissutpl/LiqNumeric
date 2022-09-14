function varargout = gui_algoritmo(varargin)
% GUI_ALGORITMO MATLAB code for gui_algoritmo.fig
%      GUI_ALGORITMO, by itself, creates a new GUI_ALGORITMO or raises the existing
%      singleton*.
%
%      H = GUI_ALGORITMO returns the handle to a new GUI_ALGORITMO or the handle to
%      the existing singleton*.
%
%      GUI_ALGORITMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ALGORITMO.M with the given input arguments.
%
%      GUI_ALGORITMO('Property','Value',...) creates a new GUI_ALGORITMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_algoritmo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_algoritmo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_algoritmo

% Last Modified by GUIDE v2.5 08-Mar-2019 00:27:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_algoritmo_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_algoritmo_OutputFcn, ...
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


% --- Executes just before gui_algoritmo is made visible.
function gui_algoritmo_OpeningFcn(hObject, eventdata, handles, varargin)
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
    
    dat_master = load(path_master,'path_proj','p_idiom');
    path_proj = dat_master.path_proj;
    
    inicializar(handles,path_proj)
    
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

guidata(hObject, handles);

% UIWAIT makes gui_algoritmo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_algoritmo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function inicializar (handles,path)
                   
    dat_str = load(path,'restricion','alphasp','alphamp',...
                  'numerador','analisis','test','tol',...
                  'iter','impresion','sistema','algorit',...
                  'coef','integrador','gamma','beta',...
                  'restricion1','alphasp1','alphamp1',...
                  'numerador1','analisis1','test1',...
                  'tol1','iter1','impresion1','sistema1',...
                  'algorit1','coef1','integrador1','gamma1',...
                  'beta1');
    
    set(handles.pop_rest,'Value',dat_str.restricion)
    set(handles.pop_rest1,'Value',dat_str.restricion1)
    set(handles.edit_sp,'String',dat_str.alphasp)
    set(handles.edit_sp1,'String',dat_str.alphasp1)
    set(handles.edit_mp,'String',dat_str.alphamp)
    set(handles.edit_mp1,'String',dat_str.alphamp1)
    set(handles.pop_num,'Value',dat_str.numerador)
    set(handles.pop_analisis,'Value',dat_str.analisis)
    set(handles.pop_test,'Value',dat_str.test)
    set(handles.pop_num1,'Value',dat_str.numerador1)
    set(handles.pop_analisis1,'Value',dat_str.analisis1)
    set(handles.pop_test1,'Value',dat_str.test1)
    set(handles.edit_tol,'String',dat_str.tol)
    set(handles.edit_iter,'String',dat_str.iter)
    set(handles.edit_tol1,'String',dat_str.tol1)
    set(handles.edit_iter1,'String',dat_str.iter1)
    set(handles.pop_print,'Value',dat_str.impresion)
    set(handles.pop_print1,'Value',dat_str.impresion1)
    set(handles.pop_sistem,'Value',dat_str.sistema)
    set(handles.pop_algoritmo,'Value',dat_str.algorit)
    set(handles.pop_sistem1,'Value',dat_str.sistema1)
    set(handles.pop_algoritmo1,'Value',dat_str.algorit1)
    set(handles.edit_c,'String',dat_str.coef)
    set(handles.edit_c1,'String',dat_str.coef1)
    set(handles.pop_integrador,'Value',dat_str.integrador)
    set(handles.pop_integrador1,'Value',dat_str.integrador1)
    set(handles.edit_gamma,'String',dat_str.gamma)
    set(handles.edit_beta,'String',dat_str.beta)
    set(handles.edit_gamma1,'String',dat_str.gamma1)
    set(handles.edit_beta1,'String',dat_str.beta1)
    
    
   
function changIdiom(hObject,handles,path_idiom)

    % Cargar paquete de lenguaje

    dat_idiom = load(path_idiom);
    
    % Cambiar idioma de interfaz
    set(handles.uip_estatico ,'Title',dat_idiom.uip_estatico)
    set(handles.uip_dinamico,'Title',dat_idiom.uip_dinamico)
    set(handles.text_rest,'String',dat_idiom.text_rest)
    set(handles.text_num,'String',dat_idiom.text_num)
    set(handles.text_analisis2,'String',dat_idiom.text_analisis2)
    set(handles.text_tol,'String',dat_idiom.text_tol)
    set(handles.text_iter,'String',dat_idiom.text_iter)
    set(handles.text_print,'String',dat_idiom.text_print)
    set(handles.text_sistem,'String',dat_idiom.text_sistem)
    set(handles.text_algoritmo,'String',dat_idiom.text_algoritmo)
    set(handles.text_integrador,'String',dat_idiom.text_integrador)
    set(handles.text_rest1,'String',dat_idiom.text_rest1)
    set(handles.text_num1,'String',dat_idiom.text_num1)
    set(handles.text_analisis1,'String',dat_idiom.text_analisis1)
    set(handles.text_tol1,'String',dat_idiom.text_tol1)
    set(handles.text_iter1,'String',dat_idiom.text_iter1)
    set(handles.text_print1,'String',dat_idiom.text_print1)
    set(handles.text_sistem1,'String',dat_idiom.text_sistem1)
    set(handles.text_algoritmo1,'String',dat_idiom.text_algoritmo1)
    set(handles.text_integrador1,'String',dat_idiom.text_integrador1)
    set(handles.btn_algoritmo,'String',dat_idiom.btn_algoritmo)
    
    set(hObject,'Name',dat_idiom.gui_nam_analisis)
    
   
% --- Executes on selection change in pop_num.
function pop_num_Callback(hObject, eventdata, handles)
    
    global p_idiom 
    select = get(hObject,'Value');
    tool_numerador (handles.pop_num,p_idiom,select)

    
% --- Executes during object creation, after setting all properties.
function pop_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_rest.
function pop_rest_Callback(hObject, eventdata, handles)

    global p_idiom 
    select = get(hObject,'Value');
    tool_const (handles.pop_rest,handles.edit_sp,handles.edit_mp,p_idiom,select)
     
       
% --- Executes during object creation, after setting all properties.
function pop_rest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_rest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sp_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_sp,p_idiom);
if estado
    return
end

% --- Executes during object creation, after setting all properties.
function edit_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_mp,p_idiom);
if estado
    return
end


% --- Executes during object creation, after setting all properties.
function edit_mp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in pop_test.
function pop_test_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_test (handles.pop_test,handles.edit_tol,handles.edit_iter,handles.pop_print,p_idiom,select)

% --- Executes during object creation, after setting all properties.
function pop_test_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_tol_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_tol,p_idiom);
if estado
    return
end


% --- Executes during object creation, after setting all properties.
function edit_tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_iter_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_iter,p_idiom);
if estado
    return
end


% --- Executes during object creation, after setting all properties.
function edit_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_print.
function pop_print_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function pop_print_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_analisis.
function pop_analisis_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_analisis (handles.pop_analisis,p_idiom,select)


% --- Executes during object creation, after setting all properties.
function pop_analisis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_analisis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_sistem.
function pop_sistem_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_sistem (handles.pop_sistem,p_idiom,select)


% --- Executes during object creation, after setting all properties.
function pop_sistem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_sistem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in pop_algoritmo.
function pop_algoritmo_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_algoritmo (handles.pop_algoritmo,handles.edit_c,p_idiom,select)



% --- Executes during object creation, after setting all properties.
function pop_algoritmo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_algoritmo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_c,p_idiom);
if estado
    return
end

% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_integrador.
function pop_integrador_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_integrador (handles.pop_integrador,handles.edit_gamma,handles.edit_beta,p_idiom,select)


% --- Executes during object creation, after setting all properties.
function pop_integrador_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_integrador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gamma_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_gamma,p_idiom);
if estado
    return
end


% --- Executes during object creation, after setting all properties.
function edit_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_beta_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_beta,p_idiom);
if estado
    return
end
% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in pop_integrador1.
function pop_integrador1_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_integrador (handles.pop_integrador1,handles.edit_gamma1,handles.edit_beta1,p_idiom,select)


% --- Executes during object creation, after setting all properties.
function pop_integrador1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_integrador1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_gamma1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_gamma1,p_idiom);
if estado
    return
end

% --- Executes during object creation, after setting all properties.
function edit_gamma1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gamma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_beta1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_beta1,p_idiom);
if estado
    return
end

% --- Executes during object creation, after setting all properties.
function edit_beta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in pop_algoritmo1.
function pop_algoritmo1_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_algoritmo (handles.pop_algoritmo1,handles.edit_c1,p_idiom,select)


% --- Executes during object creation, after setting all properties.
function pop_algoritmo1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_algoritmo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_c1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_c1,p_idiom);
if estado
    return
end

% --- Executes during object creation, after setting all properties.
function edit_c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_analisis1.
function pop_analisis1_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_analisis (handles.pop_analisis1,p_idiom,select)
    

% --- Executes during object creation, after setting all properties.
function pop_analisis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_analisis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_sistem1.
function pop_sistem1_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_sistem (handles.pop_sistem1,p_idiom,select)


    % --- Executes during object creation, after setting all properties.
function pop_sistem1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_sistem1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_test1.
function pop_test1_Callback(hObject, eventdata, handles)
    
global p_idiom 
select = get(hObject,'Value');
tool_test (handles.pop_test1,handles.edit_tol1,handles.edit_iter1,handles.pop_print1,p_idiom,select)
    

% --- Executes during object creation, after setting all properties.
function pop_test1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_test1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_tol1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_tol1,p_idiom);
if estado
    return
end
%str=get(hObject,'String');
%validar(str)

% --- Executes during object creation, after setting all properties.
function edit_tol1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tol1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_iter1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_iter1,p_idiom);
if estado
    return
end

% --- Executes during object creation, after setting all properties.
function edit_iter1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iter1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_print1.
function pop_print1_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function pop_print1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_print1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_num1.
function pop_num1_Callback(hObject, eventdata, handles)

global p_idiom 
select = get(hObject,'Value');
tool_numerador (handles.pop_num1,p_idiom,select)

% --- Executes during object creation, after setting all properties.
function pop_num1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in pop_rest1.
function pop_rest1_Callback(hObject, eventdata, handles)
    
global p_idiom 
select = get(hObject,'Value');
tool_const (handles.pop_rest1,handles.edit_sp1,handles.edit_mp1,p_idiom,select)



% --- Executes during object creation, after setting all properties.
function pop_rest1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_rest1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sp1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_sp1,p_idiom);
if estado
    return
end


% --- Executes during object creation, after setting all properties.
function edit_sp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mp1_Callback(hObject, eventdata, handles)

global p_idiom

estado = dataControl2(handles.edit_mp1,p_idiom);
if estado
    return
end


% --- Executes during object creation, after setting all properties.
function edit_mp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_algoritmo.
function btn_algoritmo_Callback(hObject, eventdata, handles)

    const = get(handles.pop_rest,'Value');
    const1 = get(handles.pop_rest1,'Value');
    sp = get(handles.edit_sp,'String');
    sp1 = get(handles.edit_sp1,'String');
    mp = get(handles.edit_mp,'String');
    mp1 = get(handles.edit_mp1,'String');
    numember = get(handles.pop_num,'Value');
    analisis = get(handles.pop_analisis,'Value');
    test = get(handles.pop_test,'Value');
    numember1 = get(handles.pop_num1,'Value');
    analisis1 = get(handles.pop_analisis1,'Value');
    test1 = get(handles.pop_test1,'Value');
    tol = get(handles.edit_tol,'String');
    iter = get(handles.edit_iter,'String');
    tol1 = get(handles.edit_tol1,'String');
    iter1 = get(handles.edit_iter1,'String');
    print = get(handles.pop_print,'Value');
    print1 = get(handles.pop_print1,'Value');
    sistem = get(handles.pop_sistem,'Value');
    algoritmo = get(handles.pop_algoritmo,'Value');
    sistem1 = get(handles.pop_sistem1,'Value');
    algoritmo1 = get(handles.pop_algoritmo1,'Value');
    coef = get(handles.edit_c,'String');
    coef1 = get(handles.edit_c1,'String');
    integrador = get(handles.pop_integrador,'Value');
    integrador1 = get(handles.pop_integrador1,'Value');
    gamma = get(handles.edit_gamma,'String');
    beta = get(handles.edit_beta,'String');
    gamma1 = get(handles.edit_gamma1,'String');
    beta1 = get(handles.edit_beta1,'String');
    
    
    datosAlgorithm(const,const1,sp,sp1,mp,mp1,numember,analisis,test,numember1,analisis1,test1,tol,iter,tol1,iter1,print,print1,sistem,algoritmo,sistem1,algoritmo1,coef,coef1,integrador,integrador1,gamma,beta,gamma1,beta1)

    close(gui_algoritmo)


function tool_numerador(elemento,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['El numerador simple asigna grados de libertad a los nodos en función de cómo se almacenan los nodos en el dominio.']
         elseif valor==2
            elemento.TooltipString = ['El numerador RCM usa el algoritmo inverso Cuthill McKee para numerar los grados de libertad.']
         end

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['The Plain numberer assigns degrees-of-freedom to the nodes based on how the nodes are stored in the domain.']
        elseif valor==2
            elemento.TooltipString = ['The RCM numberer uses the reverse Cuthill McKee algorithm to number the degrees of freedom.']
        end
    end

function tool_const(elemento,elemento1,elemento2,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['Este comando crea un PlainHandler que solo es capaz de imponer restricciones homogéneas de un solo punto.',...
                                      char(10),'Si existen otros tipos de restricciones en el dominio, se debe especificar un controlador de restricciones diferente.']
            elemento1.TooltipString = ['']
            elemento2.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento2,'enable','off')
            set(elemento1,'String','0')
            set(elemento2,'String','0')
         elseif valor==2
            elemento.TooltipString = ['Este comando se usa para construir un PenaltyConstraintHandler que hará que las restricciones se apliquen utilizando un método de penalización.',...
                                    char(10), 'El método de penalización consiste en agregar grandes números a la matriz de rigidez y los vectores de fuerza de restauración para imponer un DOF cero o nulo prescrito.']
            elemento1.TooltipString = ['alphaSP  factor utilizado al agregar la restricción de un solo punto en el sistema de ecuaciones']
            elemento2.TooltipString = ['alphaMP  factor utilizado al agregar la restricción de múltiples puntos en el sistema de ecuaciones']
            set(elemento1,'enable','on')
            set(elemento2,'enable','on')
         elseif valor==3
            elemento.TooltipString = ['Este comando se usa para construir un LagrangeConstraintHandler que hará que las restricciones se apliquen utilizando el método de los multiplicadores de Lagrange']
            elemento.TooltipString = ['alphaSP  factor utilizado al agregar la restricción de un solo punto en el sistema de ecuaciones (opcional, predeterminado = 1.0)']
            elemento.TooltipString = ['alphaMP  factor utilizado al agregar la restricción de puntos múltiples en el sistema de ecuaciones (opcional, predeterminado = 1.0)']
            set(elemento1,'enable','on')
            set(elemento2,'enable','on')
         elseif valor==4
            elemento.TooltipString = ['Este comando se usa para construir un TransofrmationConstraintHandler que hará que las restricciones se apliquen utilizando el método de transformación.']
            elemento1.TooltipString = ['']
            elemento2.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento2,'enable','off')
            set(elemento1,'String','0')
            set(elemento2,'String','0')
         end

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['This command creates a PlainHandler which is only capable of enforcing homogeneous single-point constraints.',...  
                                       char(10),'If other types of constraints exist in the domain, a different constraint handler must be specified']
            elemento1.TooltipString = ['']
            elemento2.TooltipString = ['']            
            set(elemento1,'enable','off')
            set(elemento2,'enable','off')
            set(elemento1,'String','0')
            set(elemento2,'String','0')
        elseif valor==2
            elemento.TooltipString = ['This command is used to construct a PenaltyConstraintHandler which will cause the constraints to be enforced using a penalty method.',...
                                    char(10), 'The penalty method consists of adding large numbers to the stiffness matrix and the restoring-force vectors to impose a prescribed zero or nonzero DOF.']
            elemento1.TooltipString = ['alphaSP  factor used when adding the single-point constraint into the system of equations']
            elemento2.TooltipString = ['alphaMP  factor used when adding the multi-point constraint into the system of equations']
            set(elemento1,'enable','on')
            set(elemento2,'enable','on')
        elseif valor==3
            elemento.TooltipString = ['This command is used to construct a LagrangeConstraintHandler which will cause the constraints to be enforced using the method of Lagrange multipliers.']
            elemento1.TooltipString = ['alphaSP  factor used when adding the single-point constraint into the system of equations (optional, default=1.0)']
            elemento2.TooltipString = ['alphaMP  factor used when adding the multi-point constraint into the system of equations (optional, default=1.0)']
            set(elemento1,'enable','on')
            set(elemento2,'enable','on')
        elseif valor==4
            elemento.TooltipString = ['This command is used to construct a TransofrmationConstraintHandler which will cause the constraints to be enforced using the transformation method.']
            elemento1.TooltipString = ['']
            elemento2.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento2,'enable','off')
            set(elemento1,'String','0')
            set(elemento2,'String','0')
        end
    end
    
function tool_test(elemento,elemento1,elemento2,elemento3,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['Este comando se usa para construir un objeto CTestNormUnbalance que prueba la convergencia de fuerza positiva si la norma 2 del vector b (el desequilibrio) en el objeto LinearSOE es menor que la tolerancia especificada.']
         elseif valor==2
            elemento.TooltipString = ['Este comando se usa para construir un objeto CTestNormDispIncr que prueba la convergencia de fuerza positiva si la norma 2 del vector x (el incremento de desplazamiento) en el objeto LinearSOE es menor que la tolerancia especificada.']
         elseif valor==3
            elemento.TooltipString = ['Este comando se usa para construir un objeto CTestEnergyIncr que prueba la convergencia de fuerza positiva si la mitad del producto interno de los vectores x y b (incremento de desplazamiento y desequilibrio) en el objeto LinearSOE es menor que la tolerancia especificada.']
         end
        elemento1.TooltipString = ['tolerancia    tolerancia de convergencia']
        elemento2.TooltipString = ['iteraciones   número máximo de iteraciones que se realizarán antes de que se devuelva "falla para converger"']
        elemento3.TooltipString = ['impresión     bandera utilizada para imprimir información sobre convergencia (opcional):',...
                                    char(10),'0  sin salida de impresión (predeterminado)',...
                                    char(10),'1  imprimir información en cada paso',...
                                    char(10),'2  Imprimir información cuando se haya logrado la convergencia',...
                                    char(10),'4  Norma de impresión, vectores dU y dR',...  
                                    char(10),'5  en caso de fallo de convergencia, continúe, imprima un mensaje de error, pero no detenga el análisis']

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['This command is used to construct a CTestNormUnbalance object which tests positive force convergence if the 2-norm of the b vector (the unbalance) in the LinearSOE object is less than the specified tolerance.']
        elseif valor==2
            elemento.TooltipString = ['This command is used to construct a CTestNormDispIncr object which tests positive force convergence if the 2-norm of the x vector (the displacement increment) in the LinearSOE object is less than the specified tolerance.']
        elseif valor==3
            elemento.TooltipString = ['This command is used to construct a CTestEnergyIncr object which tests positive force convergence if one half of the inner-product of the x and b vectors (displacement increment and unbalance) in the LinearSOE object is less than the specified tolerance.']
        end
        elemento1.TooltipString = ['tolerance    convergence tolerance']
        elemento2.TooltipString = ['iterations   maximum number of iterations that will be performed before "failure to converge" is returned']
        elemento3.TooltipString = ['print    flag used to print information on convergence (optional)',...
                                    char(10),'0    no print output (default)',...
                                    char(10),'1    print information on each step',...
                                    char(10),'2    print information when convergence has been achieved',...   
                                    char(10),'4    print norm, dU and dR vectors',...
                                    char(10),'5    at convergence failure, carry on, print error message, but do not stop analysis']

    end

function tool_sistem(elemento,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['Este comando se utiliza para construir un sistema de ecuaciones con bandas no simétricas que se factorizará y resolverá durante el análisis utilizando el solucionador general de la banda de Lapack.']
         elseif valor==2
            elemento.TooltipString = ['Este comando se utiliza para construir un objeto de sistema de ecuaciones con bandas definidas positivas simétricas que se factorizará y resolverá durante el análisis utilizando el solucionador de spd de banda de Lapack.']
         elseif valor==3
            elemento.TooltipString = ['Este comando se utiliza para construir un sistema de perfil de ecuaciones definidas positivas simétricas que se factorizará y resolverá durante el análisis utilizando un solucionador de perfiles.']
         elseif valor==4
            elemento.TooltipString = ['Este comando se utiliza para construir un sistema general de objetos de ecuaciones dispersas que se factorizará y resolverá durante el análisis utilizando el solucionador SuperLU.']
         elseif valor==5
            elemento.TooltipString = ['Este comando se utiliza para construir un sistema general de objetos de ecuaciones dispersas que se factorizará y resolverá durante el análisis utilizando el solucionador UMFPACK.']
         elseif valor==6
            elemento.TooltipString = ['Este comando se utiliza para construir un sistema de ecuaciones definidas positivas simétricas dispersas que se factorizará y resolverá durante el análisis utilizando un solucionador dispersado desarrollado en la Universidad de Stanford por Kincho Law.']
         end

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['This command is used to construct an un-symmetric banded system of equations object which will be factored and solved during the analysis using the Lapack band general solver.']
        elseif valor==2
            elemento.TooltipString = ['This command is used to construct a symmetric positive definite banded system of equations object which will be factored and solved during the analysis using the Lapack band spd solver.']
        elseif valor==3
            elemento.TooltipString = ['This command is used to construct symmetric positive definite profile system of equations object which will be factored and solved during the analysis using a profile solver.']
        elseif valor==4
            elemento.TooltipString = ['This command is used to construct a general sparse system of equations object which will be factored and solved during the analysis using the SuperLU solver.']
        elseif valor==5
            elemento.TooltipString = ['This command is used to construct a general sparse system of equations object which will be factored and solved during the analysis using the UMFPACK solver']
        elseif valor==6
            elemento.TooltipString = ['This command is used to construct a sparse symmetric positive definite system of equations object which will be factored and solved during the analysis using a sparse solver developed at Stanford University by Kincho Law.']
        end
    end
   
function tool_algoritmo(elemento,elemento1,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo lineal que toma una iteración para resolver el sistema de ecuaciones.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
         elseif valor==2
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo NewtonRaphson que usa el método de Newton-Raphson para avanzar al siguiente paso de tiempo.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
         elseif valor==3
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo NewtonLineSearch que usa el método de Newton-Raphson con la búsqueda de líneas para avanzar al siguiente paso de tiempo.']
            elemento1.TooltipString = ['c    relación limitante entre los residuos antes y después de la actualización incremental (entre 0.5 y 0.8)']
            set(elemento1,'enable','on')
         elseif valor==4
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo ModifiedNewton que usa el método Modified Newton-Raphson para avanzar al siguiente paso de tiempo. La diferencia entre este método y el método de Newton-Raphson es que la rigidez tangente no se actualiza en cada paso,'...
                                        char(10),'evitando así los costosos cálculos necesarios en los sistemas con múltiples DOF. Sin embargo, se pueden necesitar más iteraciones para alcanzar una precisión prescrita.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
         elseif valor==5
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo KrylovNewton que usa un método de Newton modificado con aceleración del subespacio Krylov para avanzar al siguiente paso de tiempo.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
         elseif valor==6
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo BFGS para sistemas simétricos que realiza sucesivas actualizaciones de rango dos de la tangente en la primera iteración del paso de tiempo actual.']
            elemento1.TooltipString = ['c    Número de iteraciones dentro de un intervalo de tiempo hasta que se forma una nueva tangente']
            set(elemento1,'enable','on')
         elseif valor==7
            elemento.TooltipString = ['Este comando se usa para construir un objeto de algoritmo de Broyden para sistemas asimétricos generales que realizan sucesivas actualizaciones de rango uno de la tangente en la primera iteración del paso de tiempo actual.']
            elemento1.TooltipString = ['c  Número de iteraciones dentro de un intervalo de tiempo hasta que se forma una nueva tangente']
            set(elemento1,'enable','on')
         end

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['This command is used to construct a Linear algorithm object which takes one iteration to solve the system of equations.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
        elseif valor==2
            elemento.TooltipString = ['This command is used to construct a NewtonRaphson algorithm object which uses the Newton-Raphson method to advance to the next time step.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
        elseif valor==3
            elemento.TooltipString = ['This command is used to construct a NewtonLineSearch algorithm object which uses the Newton-Raphson method with line search to advance to the next time step.']
            elemento1.TooltipString = ['c    limiting ratio between the residuals before and after the incremental update (between 0.5 and 0.8)']
            set(elemento1,'enable','on')
        elseif valor==4
            elemento.TooltipString = ['This command is used to construct a ModifiedNewton algorithm object which uses the Modified Newton-Raphson method to advance to the next time step. The difference between this method and the Newton-Raphson method is that the tangent stiffness is not updated at each step,'...
                                        char(10),'thus avoiding expensive calculations needed in multi-DOF systems. However, more iterations may be needed to reach a prescribed accuracy.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
        elseif valor==5
            elemento.TooltipString = ['This command is used to construct a KrylovNewton algorithm object which uses a modified Newton method with Krylov subspace acceleration to advance to the next time step.']
            elemento1.TooltipString = ['']
            set(elemento1,'enable','off')
            set(elemento1,'String','0')
        elseif valor==6
            elemento.TooltipString = ['This command is used to construct a BFGS algorithm object for symmetric systems which performs successive rank-two updates of the tangent at the first iteration of the current time step.']
            elemento1.TooltipString = ['c  number of iterations within a time step until a new tangent is formed']
            set(elemento1,'enable','on')
        elseif valor==7
            elemento.TooltipString = ['This command is used to construct a Broyden algorithm object for general unsymmetric systems which performs successive rank-one updates of the tangent at the first iteration of the current time step.']
            elemento1.TooltipString = ['c    number of iterations within a time step until a new tangent is formed']
            set(elemento1,'enable','on')
        end
    end
    
function tool_integrador(elemento,elemento1,elemento2,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['Este comando se utiliza para construir un objeto TransientIntegrator de tipo Newmark.']
            elemento1.TooltipString = ['gamma  Parámetro Newmark g']
            elemento2.TooltipString = ['beta     Parámetro Newmark b']
         end

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['This command is used to construct a TransientIntegrator object of type Newmark.']
            elemento1.TooltipString = ['gamma   Newmark parameter g']
            elemento2.TooltipString = ['beta    Newmark parameter b']            
        end
    end
    
function tool_analisis(elemento,idiom,valor)
    
    if idiom == 1
         if valor==1
            elemento.TooltipString = ['Resuelve el análisis dependiente del tiempo. El paso de tiempo en este tipo de análisis es constante. El paso de tiempo en la salida también es constante.']
         elseif valor==2
            elemento.TooltipString = ['Realiza el mismo tipo de análisis que el objeto Análisis transitorio. El paso del tiempo, sin embargo, es variable.',...
                                    char(10),' Este método se utiliza cuando hay problemas de convergencia con el objeto Análisis de transitorios en un pico o cuando el paso de tiempo es demasiado pequeño.',...
                                    char(10),' El paso de tiempo en la salida también es variable.']
         end

    elseif idiom == 2
        if valor==1
            elemento.TooltipString = ['Solves the time-dependent analysis. The time step in this type of analysis is constant. The time step in the output is also constant.']
        elseif valor==2 
            elemento.TooltipString = ['performs the same analysis type as the Transient Analysis object. The time step, however, is variable. ',...
                                    char(10),'This method is used when there are convergence problems with the Transient Analysis object at a peak or when the time step is too small. The time step in the output is also variable.']
        end
    end
    
