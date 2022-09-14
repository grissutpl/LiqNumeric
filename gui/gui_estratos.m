function varargout = gui_estratos(varargin)
% GUI_ESTRATOS MATLAB code for gui_estratos.fig
%      GUI_ESTRATOS, by itself, creates a new GUI_ESTRATOS or raises the existing
%      singleton*.
%
%      H = GUI_ESTRATOS returns the handle to a new GUI_ESTRATOS or the handle to
%      the existing singleton*.
%
%      GUI_ESTRATOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ESTRATOS.M with the given input arguments.
%
%      GUI_ESTRATOS('Property','Value',...) creates a new GUI_ESTRATOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_estratos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_estratos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_estratos

% Last Modified by GUIDE v2.5 11-Mar-2019 14:35:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_estratos_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_estratos_OutputFcn, ...
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


% --- Executes just before gui_estratos is made visible.
function gui_estratos_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
    % Variables glonales requeridas
    global p_idiom path_master path_proj

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
	
	%cargar estratos en caso de haberlos
	dat_proj = load(path_proj,'numLayers');
    numLayers = dat_proj.numLayers;
	if ~isempty(numLayers)
		list = numListStr(numLayers,'Estrato ');
		set(handles.ltb_layer,'String',list)
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
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
	inicializar (handles,p_idiom)
    select = get(handles.pop_tipo,'Value');
    tipo (select,handles)
    
    % Cargar imagenes de botones
    
    % Botón crear estrato
    im = imread('8.png','BackGround',[240,240,240]/255);
    set(handles.btn_cest,'CData',im)
    
    im = imread('1.png','BackGround',[240,240,240]/255);
    set(handles.btn_ayuda,'CData',im)

guidata(hObject, handles);

% UIWAIT makes gui_estratos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_estratos_OutputFcn(hObject, eventdata, handles) 
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
    set(handles.uip_prop,'Title',dat_idiom.uip_prop)
    set(handles.uip_estratos,'Title',dat_idiom.uip_estratos)
	set(handles.uip_resumen,'Title',dat_idiom.uip_resumen)
	set(handles.text_tipo,'String',dat_idiom.text_tipo)
    set(handles.text_espesor,'String',dat_idiom.text_espesor)
    set(handles.text_pendiente,'String',dat_idiom.text_pendiente)
    set(handles.text15,'String',dat_idiom.text15)
	set(handles.text27,'String',dat_idiom.text27)
    set(handles.btn_edit,'String',dat_idiom.btn_edit)
    set(handles.btn_del,'String',dat_idiom.btn_del)
	
    set(hObject,'Name',dat_idiom.gui_nam_estrato)
  
  
function inicializar (handles,idiom)  
% Agregar item a popupmenu
if idiom == 1
	set(handles.pop_tipo,'string',{'Arena' 'Arcilla'})
elseif idiom == 2
	set(handles.pop_tipo,'string',{'Sand' 'Clay'})
end

% poner ayudas en edits
if idiom==1
	handles.edit_rho.TooltipString = ['Densidad de masa de suelo sarutado']
	handles.edit_gr.TooltipString = ['Módulo de corte']
	handles.edit_br.TooltipString = ['Módulo de bulk']
	handles.edit_bc.TooltipString = ['Módulo de bulk no drenado']
	handles.edit_f.TooltipString = ['Ángulo de fricción']
	handles.edit_vperm.TooltipString = ['Coeficiente de permeabilidad en dirección vertical']
	handles.edit_hperm.TooltipString = ['Coeficiente de permeabilidad en dirección horizontal']
	handles.edit_vs.TooltipString = ['Velocidad del suelo']
	handles.edit_ref.TooltipString = ['Presión de confinamiento efectiva medida de referencia a la que se definen Gr , Br. valor predeterminado 100']
	handles.edit_surf.TooltipString = ['Número de superficies de rendimiento, opcional (debe ser inferior a 40, el valor predeterminado es 20)']
	handles.edit_e.TooltipString = ['Proporción de vacios iniciales']
	handles.edit_cc1.TooltipString = ['Una constante no negativa que define la tasa de disminución del volumen inducida por cizallamiento (contracción) o la acumulación de presión de poros.',...
										char(10),'Un valor mayor corresponde a una velocidad de contracción más rápida.']
	handles.edit_cc3.TooltipString = ['Una constante no negativa que refleja el efecto de Ks.']
	handles.edit_cd1.TooltipString = ['Constantes no negativas que definen la tasa de aumento de volumen inducido por cizallamiento (dilatación).',...
										char(10),'Los valores más grandes corresponden a una mayor tasa de dilatación.']
	handles.edit_cd3.TooltipString = ['Una constante no negativa que refleja el efecto de Ks.']
	handles.edit_pta.TooltipString = ['Ángulo de transformación de fase.']
	handles.edit_cohesion.TooltipString = ['Cohesión aparente sin confinamiento efectivo.']
elseif idiom==2 
	handles.edit_rho.TooltipString = ['Saturated soil mass density.']
	handles.edit_gr.TooltipString = ['Shear modulus']
	handles.edit_br.TooltipString = ['Bulk modulus']
	handles.edit_bc.TooltipString = ['Undrained bulk modulus']
	handles.edit_f.TooltipString = ['friction angle']
	handles.edit_vperm.TooltipString = ['Permeability coefficient in vertical directions'] 
	handles.edit_hperm.TooltipString = ['Permeability coefficient in horizontal directions']
	handles.edit_vs.TooltipString = ['Soil speed']
	handles.edit_ref.TooltipString = ['Reference mean effective confining pressure at which Gr, Br.Default is 100']
	handles.edit_surf.TooltipString = ['Number of yield surfaces, optional (must be less than 40, default is 20).']
	handles.edit_e.TooltipString = ['Initial void ratio']
	handles.edit_cc1.TooltipString = ['A non-negative constant defining the rate of shear-induced volume decrease (contraction) or pore pressure buildup.']	
	handles.edit_cc3.TooltipString = ['A non-negative constant reflecting Ks effect.']
	handles.edit_cd1.TooltipString = ['Non-negative constants defining the rate of shear-induced volume increase (dilation).Larger values correspond to stronger dilation rate.']
	handles.edit_cd3.TooltipString = ['A non-negative constant reflecting Ks effect.']
	handles.edit_pta.TooltipString = ['Phase transformation angle']
	handles.edit_cohesion.TooltipString = ['Apparent cohesion at zero effective confinement']
	%set(elemento1,'enable','off')
end


function creaVector(handles)
% Variables globales requeridas
    global path_master

    % Inicializar asistente de vectores
    gui_vecman
    
    % Esperar acción de la GUI
    uiwait
    
    % Comprobar creación de vector
    dat_master = load(path_master,'winc','vec_str');

    if dat_master.winc
        set(handles,'String',dat_master.vec_str)
        winc = false;
        save(path_master,'winc','-append')
    end


function edit_lyt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lyt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lyt as text
%        str2double(get(hObject,'String')) returns contents of edit_lyt as a double


% --- Executes during object creation, after setting all properties.
function edit_lyt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lyt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_dr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dr as text
%        str2double(get(hObject,'String')) returns contents of edit_dr as a double


% --- Executes during object creation, after setting all properties.
function edit_dr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_rho_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_gr_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_gr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_br_Callback(hObject, eventdata, handles)
% hObject    handle to edit_br (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_br as text
%        str2double(get(hObject,'String')) returns contents of edit_br as a double


% --- Executes during object creation, after setting all properties.
function edit_br_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_br (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bc as text
%        str2double(get(hObject,'String')) returns contents of edit_bc as a double


% --- Executes during object creation, after setting all properties.
function edit_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f as text
%        str2double(get(hObject,'String')) returns contents of edit_f as a double


% --- Executes during object creation, after setting all properties.
function edit_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_e_Callback(hObject, eventdata, handles)
% hObject    handle to edit_e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_e as text
%        str2double(get(hObject,'String')) returns contents of edit_e as a double


% --- Executes during object creation, after setting all properties.
function edit_e_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_vperm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vperm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vperm as text
%        str2double(get(hObject,'String')) returns contents of edit_vperm as a double


% --- Executes during object creation, after setting all properties.
function edit_vperm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vperm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hperm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hperm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hperm as text
%        str2double(get(hObject,'String')) returns contents of edit_hperm as a double


% --- Executes during object creation, after setting all properties.
function edit_hperm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hperm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vs as text
%        str2double(get(hObject,'String')) returns contents of edit_vs as a double


% --- Executes during object creation, after setting all properties.
function edit_vs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_vecdr.
function btn_vecdr_Callback(hObject, eventdata, handles)
	creaVector(handles.edit_dr)



function edit_gra_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gra as text
%        str2double(get(hObject,'String')) returns contents of edit_gra as a double


% --- Executes during object creation, after setting all properties.
function edit_gra_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_vecpend.
function btn_vecpend_Callback(hObject, eventdata, handles)
creaVector(handles.edit_gra)

% --- Executes on button press in brn_vecrho.
function brn_vecrho_Callback(hObject, eventdata, handles)
creaVector(handles.edit_rho)


% --- Executes on button press in btn_vecgr.
function btn_vecgr_Callback(hObject, eventdata, handles)
creaVector(handles.edit_gr)


% --- Executes on button press in btn_vecbr.
function btn_vecbr_Callback(hObject, eventdata, handles)
creaVector(handles.edit_br)


% --- Executes on button press in btn_vecbc.
function btn_vecbc_Callback(hObject, eventdata, handles)
creaVector(handles.edit_bc)


% --- Executes on button press in btn_vecf.
function btn_vecf_Callback(hObject, eventdata, handles)
creaVector(handles.edit_f)


% --- Executes on button press in btn_vece.
function btn_vece_Callback(hObject, eventdata, handles)
creaVector(handles.edit_e)


% --- Executes on button press in btn_vecperm1.
function btn_vecperm1_Callback(hObject, eventdata, handles)
creaVector(handles.edit_vperm)


% --- Executes on button press in btn_vecperm2.
function btn_vecperm2_Callback(hObject, eventdata, handles)
creaVector(handles.edit_hperm)


% --- Executes on button press in btn_vecvs.
function btn_vecvs_Callback(hObject, eventdata, handles)
creaVector(handles.edit_vs)


% --- Executes on selection change in ltb_layer.
function ltb_layer_Callback(hObject, eventdata, handles)
% Mostrar propiedades
    global path_proj
	
	dat_proj = load(path_proj);
	
	if ~isempty(dat_proj.numLayers)
		iest = get(hObject,'Value');
		text = resumEst(iest);
		
		set(handles.ltb_sum,'String',text)
	end

% --- Executes during object creation, after setting all properties.
function ltb_layer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ltb_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_calc.
%function btn_calc_Callback(hObject, eventdata, handles)
    % Cálcular parámetros para arena
    % Obtener el valor de la densidad relativa
%    dr = eval(strcat(get(handles.edit_dr,'String'),';'));
    
%    resulps = paramArena(dr);
    
    % Colocar los valores cálculados en los recuadros de texto
    
%    set(handles.edit_cc1,'String',crearStrVector(resulps{1}))
%    set(handles.edit_cc3,'String',crearStrVector(resulps{2}))
%    set(handles.edit_cd1,'String',crearStrVector(resulps{3}))
%    set(handles.edit_cd3,'String',crearStrVector(resulps{4}))
%    set(handles.edit_rho,'String',crearStrVector(resulps{5}))
%    set(handles.edit_gr,'String',crearStrVector(resulps{6}))
%    set(handles.edit_br,'String',crearStrVector(resulps{7}))
%    set(handles.edit_f,'String',crearStrVector(resulps{8}))
%    set(handles.edit_e,'String',crearStrVector(resulps{9}))
%    set(handles.edit_bc,'String',crearStrVector(resulps{10}))
%    set(handles.edit_vs,'String',crearStrVector(resulps{11}))
%    set(handles.edit_pta,'String',crearStrVector(resulps{12}))
%    set(handles.edit_vperm,'String',crearStrVector(resulps{13}))
%    set(handles.edit_hperm,'String',crearStrVector(resulps{14}))
    

% --- Executes on button press in btn_edit.
function btn_edit_Callback(hObject, eventdata, handles)
% Editar información de estrato
    global path_proj ne_edit

    % Obtener el número del estrato seleccionado
    ne_edit = get(handles.ltb_layer,'Value');
    
    % Determinar el tipo de estrato / Arena o arcilla
    dat_proj = load(path_proj);
	
    if ~isempty(dat_proj.numLayers)
	
		tipo1 = dat_proj.tipo;
		
		tipo_ee = tipo1{ne_edit};
		
		% Cargar información a los recuadros de texto
		set(handles.pop_tipo,'Value',tipo_ee)
        tipo (tipo_ee,handles)
		set(handles.edit_lyt,'String',dat_proj.layerThick{ne_edit}) 
		set(handles.edit_gra,'String',dat_proj.grade_str{ne_edit})  
		set(handles.edit_rho,'String',dat_proj.rho_str{ne_edit}) 
		set(handles.edit_gr,'String',dat_proj.refShearModul_str{ne_edit}) 
		set(handles.edit_br,'String',dat_proj.refBulkModul_str{ne_edit}) 
		set(handles.edit_bc,'String',dat_proj.uBulk_str{ne_edit}) 
		set(handles.edit_f,'String',dat_proj.frictionAng_str{ne_edit})  
		set(handles.edit_vperm,'String',dat_proj.vPerm_str{ne_edit}) 
		set(handles.edit_hperm,'String',dat_proj.hPerm_str{ne_edit}) 
		set(handles.edit_vs,'String',dat_proj.Vs_str{ne_edit})
		set(handles.edit_ref,'String',dat_proj.refPress_str{ne_edit})
		set(handles.edit_surf,'String',dat_proj.surf_str{ne_edit})
		set(handles.edit_e,'String',dat_proj.e_str{ne_edit})
		set(handles.edit_cc1,'String',dat_proj.contrac1_str{ne_edit})
		set(handles.edit_cc3,'String',dat_proj.contrac3_str{ne_edit})
		set(handles.edit_cd1,'String',dat_proj.dilat1_str{ne_edit})
		set(handles.edit_cd3,'String',dat_proj.dilat3_str{ne_edit})
		set(handles.edit_pta,'String',dat_proj.PTAng_str{ne_edit})      
		set(handles.edit_cohesion,'String',dat_proj.cohesion_str{ne_edit})

		set(handles.btn_chng1,'Enable','on')
		set(hObject,'Enable','off')
		set(handles.btn_del,'Enable','off')
		set(handles.btn_cest,'Enable','off')
    end
    

% --- Executes on button press in btn_cest.
function btn_cest_Callback(hObject, eventdata, handles)
% Almacenar datos
    global path_proj
    
    tipo            = get(handles.pop_tipo,'Value');
    layerThick      = get(handles.edit_lyt,'String');
    grade           = get(handles.edit_gra,'String');
    rho             = get(handles.edit_rho,'String');
    refShearModul   = get(handles.edit_gr,'String');
    refBulkModul    = get(handles.edit_br,'String');
    uBulk           = get(handles.edit_bc,'String');
    frictionAng     = get(handles.edit_f,'String');
    vPerm           = get(handles.edit_vperm,'String');
    hPerm           = get(handles.edit_hperm,'String');
    Vs              = get(handles.edit_vs,'String');
    refPress        = get(handles.edit_ref,'String');
    surf            = get(handles.edit_surf,'String');
    e               = get(handles.edit_e,'String');
    contrac1        = get(handles.edit_cc1,'String');
    contrac3        = get(handles.edit_cc3,'String');
    dilat1          = get(handles.edit_cd1,'String');
    dilat3          = get(handles.edit_cd3,'String');
    PTAng           = get(handles.edit_pta,'String');
    cohesion        = get(handles.edit_cohesion,'String');
    
    datosEstrat(tipo,grade,layerThick,rho,refShearModul,refBulkModul,...
                uBulk,frictionAng,vPerm,hPerm,Vs,refPress,surf,e,...
                contrac1,contrac3,dilat1,dilat3,PTAng,cohesion)

    dat_proj = load(path_proj,'numLayers');
    numLayers = dat_proj.numLayers;
    
    list = numListStr(numLayers,'Estrato ');
    
    set(handles.ltb_layer,'String',list)
    
    limpiar(handles)  


% --- Executes on button press in btn_chng1.
function btn_chng1_Callback(hObject, eventdata, handles)
% Almacenar datos
    global ne_edit
    
    tipo            = get(handles.pop_tipo,'Value');
    layerThick      = get(handles.edit_lyt,'String');
    grade           = get(handles.edit_gra,'String');
    rho             = get(handles.edit_rho,'String');
    refShearModul   = get(handles.edit_gr,'String');
    refBulkModul    = get(handles.edit_br,'String');
    uBulk           = get(handles.edit_bc,'String');
    frictionAng     = get(handles.edit_f,'String');
    vPerm           = get(handles.edit_vperm,'String');
    hPerm           = get(handles.edit_hperm,'String');
    Vs              = get(handles.edit_vs,'String');
    refPress        = get(handles.edit_ref,'String');
    surf            = get(handles.edit_surf,'String');
    e               = get(handles.edit_e,'String');
    contrac1        = get(handles.edit_cc1,'String');
    contrac3        = get(handles.edit_cc3,'String');
    dilat1          = get(handles.edit_cd1,'String');
    dilat3          = get(handles.edit_cd3,'String');
    PTAng           = get(handles.edit_pta,'String');
    cohesion        = get(handles.edit_cohesion,'String');
    
    
    editDatosEstrat(tipo,grade,layerThick,rho,refShearModul,refBulkModul,...
                uBulk,frictionAng,vPerm,hPerm,Vs,refPress,surf,e,...
                contrac1,contrac3,dilat1,dilat3,PTAng,cohesion,ne_edit)

    % Ocultar
    set(hObject,'Enable','off')
    set(handles.btn_edit,'Enable','on')
    set(handles.btn_del,'Enable','on')
    set(handles.btn_cest,'Enable','on')
    limpiar(handles)  
    
    function limpiar(handles)   
    % Limpiar recuadros de texto
    tipo = get(handles.pop_tipo,'Value');
    set(handles.edit_lyt,'String','');
    set(handles.edit_gra,'String','');
    set(handles.edit_rho,'String','');
    set(handles.edit_gr,'String','');
    set(handles.edit_br,'String','');
    set(handles.edit_bc,'String','');
    set(handles.edit_f,'String','');
    set(handles.edit_vperm,'String','');
    set(handles.edit_hperm,'String','');
    set(handles.edit_vs,'String','');
    set(handles.edit_ref,'String','');
    set(handles.edit_surf,'String','');
    if tipo == 2
        set(handles.edit_cohesion,'String','');
    elseif tipo == 1
        set(handles.edit_e,'String','');
        set(handles.edit_cc1,'String','');
        set(handles.edit_cc3,'String','');
        set(handles.edit_cd1,'String','');
        set(handles.edit_cd3,'String','');
        set(handles.edit_pta,'String','');
    end
    
       
    
% --- Executes on button press in btn_del.
function btn_del_Callback(hObject, eventdata, handles)
    
    global path_proj

    iedit = get(handles.ltb_layer,'Value');
    delDatosEstrat(iedit);
    
    dat_proj = load(path_proj,'numLayers');
    numLayers = dat_proj.numLayers;
    
    list = numListStr(numLayers,'Estrato ');
    
    set(handles.ltb_layer,'String',list)
    
    limpiar(handles)  


% --- Executes on selection change in ltb_sum.
function ltb_sum_Callback(hObject, eventdata, handles)
% hObject    handle to ltb_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ltb_sum contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ltb_sum


% --- Executes during object creation, after setting all properties.
function ltb_sum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ltb_sum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cc1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cc1 as text
%        str2double(get(hObject,'String')) returns contents of edit_cc1 as a double


% --- Executes during object creation, after setting all properties.
function edit_cc1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_veccc1.
function btn_veccc1_Callback(hObject, eventdata, handles)
creaVector(handles.edit_cc1)


function edit_cc3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cc3 as text
%        str2double(get(hObject,'String')) returns contents of edit_cc3 as a double


% --- Executes during object creation, after setting all properties.
function edit_cc3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_veccc3.
function btn_veccc3_Callback(hObject, eventdata, handles)
creaVector(handles.edit_cc3)


function edit_cd1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cd1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cd1 as text
%        str2double(get(hObject,'String')) returns contents of edit_cd1 as a double


% --- Executes during object creation, after setting all properties.
function edit_cd1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cd1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_veccd1.
function btn_veccd1_Callback(hObject, eventdata, handles)
creaVector(handles.edit_cd1)



function edit_cd3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cd3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cd3 as text
%        str2double(get(hObject,'String')) returns contents of edit_cd3 as a double


% --- Executes during object creation, after setting all properties.
function edit_cd3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cd3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_veccd3.
function btn_veccd3_Callback(hObject, eventdata, handles)
creaVector(handles.edit_cd3)



function edit_pta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pta as text
%        str2double(get(hObject,'String')) returns contents of edit_pta as a double


% --- Executes during object creation, after setting all properties.
function edit_pta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_vecang.
function btn_vecang_Callback(hObject, eventdata, handles)
creaVector(handles.edit_pta)


% --- Executes on selection change in pop_tipo.
function pop_tipo_Callback(hObject, eventdata, handles)
	select = get(handles.pop_tipo,'Value');
	tipo(select,handles)
	
		

% --- Executes during object creation, after setting all properties.
function pop_tipo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref as text
%        str2double(get(hObject,'String')) returns contents of edit_ref as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_vecref.
function btn_vecref_Callback(hObject, eventdata, handles)
	creaVector(handles.edit_ref)


% --- Executes on button press in btn_vecesp.
function btn_vecesp_Callback(hObject, eventdata, handles)
	creaVector(handles.edit_lyt)


function edit_surf_Callback(hObject, eventdata, handles)
    global p_idiom
    dataControl2(hObject,p_idiom)
    
    
function edit_surf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_surf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_cohesion_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cohesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cohesion as text
%        str2double(get(hObject,'String')) returns contents of edit_cohesion as a double


% --- Executes during object creation, after setting all properties.
function edit_cohesion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cohesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_veccohe.
function btn_veccohe_Callback(hObject, eventdata, handles)
	creaVector(handles.edit_cohesion)


% función que nos permite elegir tipo de suelo y condicionar valores de
% entrada
function tipo (select,handles)
    % deshabilita el ingreso de la pendiente y lo establece en 0
    set(handles.edit_gra,'Enable','off')
    set(handles.edit_gra,'String','0')
    set(handles.btn_vecpend,'Enable','off')
    
	if select == 1
		set(handles.edit_cohesion,'Enable','off')
        set(handles.edit_cohesion,'String','-1')
		set(handles.edit_e,'Enable','on')
        set(handles.edit_e,'String','')
		set(handles.edit_cc1,'Enable','on')
        set(handles.edit_cc1,'String','')
		set(handles.edit_cc3,'Enable','on')
        set(handles.edit_cc3,'String','')
		set(handles.edit_cd1,'Enable','on')
        set(handles.edit_cd1,'String','')
		set(handles.edit_cd3,'Enable','on')
        set(handles.edit_cd3,'String','')
		set(handles.edit_pta,'Enable','on')
        set(handles.edit_pta,'String','')
		set(handles.btn_veccohe,'Enable','off')
		set(handles.btn_veccc1,'Enable','on')
		set(handles.btn_veccc3,'Enable','on')
		set(handles.btn_veccd1,'Enable','on')
		set(handles.btn_veccd3,'Enable','on')
		set(handles.btn_vece,'Enable','on')
		set(handles.btn_vecang,'Enable','on')
	elseif select == 2
		set(handles.edit_cohesion,'Enable','on')
		set(handles.edit_e,'Enable','off')
		set(handles.edit_cc1,'Enable','off')
		set(handles.edit_cc3,'Enable','off')
		set(handles.edit_cd1,'Enable','off')
		set(handles.edit_cd3,'Enable','off')
		set(handles.edit_pta,'Enable','off')
        set(handles.edit_cohesion,'String','')
		set(handles.edit_e,'String','-1')
		set(handles.edit_cc1,'String','-1')
		set(handles.edit_cc3,'String','-1')
		set(handles.edit_cd1,'String','-1')
		set(handles.edit_cd3,'String','-1')
		set(handles.edit_pta,'String','-1')
		set(handles.btn_veccohe,'Enable','on')
		set(handles.btn_veccc1,'Enable','off')
		set(handles.btn_veccc3,'Enable','off')
		set(handles.btn_veccd1,'Enable','off')
		set(handles.btn_veccd3,'Enable','off')
		set(handles.btn_vece,'Enable','off')
		set(handles.btn_vecang,'Enable','off')
	end	


% --- Executes on button press in btn_ayuda.
function btn_ayuda_Callback(hObject, eventdata, handles)
    im = imread('17.png');
    f=figure(1);
    set(f,'Position',[230 950 900 200],'NumberTitle','off','MenuBar','none')
    imshow(im,'Border','Tight')
