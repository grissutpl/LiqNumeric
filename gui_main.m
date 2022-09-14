function varargout = gui_main(varargin)
% GUI_MAIN MATLAB code for gui_main.fig
%      GUI_MAIN, by itself, creates a new GUI_MAIN or raises the existing
%      singleton*.
%
%      H = GUI_MAIN returns the handle to a new GUI_MAIN or the handle to
%      the existing singleton*.
%
%      GUI_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MAIN.M with the given input arguments.
%
%      GUI_MAIN('Property','Value',...) creates a new GUI_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_main

% Last Modified by GUIDE v2.5 24-Jun-2022 10:04:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_main_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_main_OutputFcn, ...
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


% --- Executes just before gui_main is made visible.
function gui_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_main (see VARARGIN)

% Choose default command line output for gui_main
handles.output = hObject;

    % Variables globales requeridas
    global p_idiom path_master path_idiom figHandle
    
    % Reconoce todos los directorios del programa
    addpath(genpath('.'))

    % Mover GUI al centro de la panatalla
    movegui(hObject,'center')
    
    % Colocar imagenes
	im = imread('3.png','BackGround',[240,240,240]/255);
    set(handles.btn_analisis,'CData',im)
	
    im = imread('4.png','BackGround',[240,240,240]/255);
    set(handles.btn_esp,'CData',im)
    
    im = imread('5.png','BackGround',[240,240,240]/255);
    set(handles.btn_eng,'CData',im)
    
    im = imread('9.png','BackGround',[240,240,240]/255);
    set(handles.btn_perm,'CData',im)
    
    im = imread('10.png','BackGround',[240,240,240]/255);
    set(handles.btn_bed,'CData',im)
    
    im = imread('11.png','BackGround',[240,240,240]/255);
    set(handles.btn_solay,'CData',im)
    
    im = imread('12.png','BackGround',[240,240,240]/255);
    set(handles.btn_geocol,'CData',im)
    
    im = imread('13.png','BackGround',[240,240,240]/255);
    set(handles.btn_sis,'CData',im)
    
    im = imread('14.png','BackGround',[240,240,240]/255);
    set(handles.btn_opc,'CData',im)
    
    %im = imread('15.png','BackGround',[240,240,240]/255);
    %set(handles.btn_const,'CData',im)
    
    % Cargar cadenas de texto a los recuadros de texto
    % Ruta de archivo maestro
    if isdeployed
       path_master = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_master = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    dat_master = load(path_master,'p_idiom');
    p_idiom = dat_master.p_idiom;
    
    changIdiom(handles,p_idiom)
    
    figHandle = handles.graficos;%findobj('Tag','graficos');  

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function changIdiom(handles,p_idiom)

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
    % menú archivo
    set(handles.mb_arc,'Label',dat_idiom.mb_arc)
    set(handles.mb_newproj,'Label',dat_idiom.mb_newproj)
    set(handles.mb_open,'Label',dat_idiom.mb_open)
    set(handles.mb_example,'Label',dat_idiom.mb_example)
    % menú columna suelo
    set(handles.mb_geo,'Label',dat_idiom.mb_geo)
    set(handles.m_prorm,'Label',dat_idiom.m_prorm)
    set(handles.mb_geo_col,'Label',dat_idiom.mb_geo_col)
    set(handles.mb_estr,'Label',dat_idiom.mb_estr)
    % menú sismo
    set(handles.mb_sism,'Label',dat_idiom.mb_sism)
    set(handles.mb_redsis,'Label',dat_idiom.mb_redsis)
    %menú de visualización
    set(handles.mb_conf_geo,'Label',dat_idiom.mb_conf_geo)
    set(handles.mb_graf,'Label',dat_idiom.mb_graf)
    set(handles.mb_comparacion,'Label',dat_idiom.mb_comparacion)
    set(handles.mb_liq,'Label',dat_idiom.mb_liq)
    set(handles.mb_result,'Label',dat_idiom.mb_result)
    set(handles.mb_all,'Label',dat_idiom.mb_all)
    set(handles.mb_select,'Label',dat_idiom.mb_select)
    % menú ajustes
    set(handles.mb_conf,'Label',dat_idiom.mb_conf)
    set(handles.m_cid,'Label',dat_idiom.m_cid)
    set(handles.mb_id_es,'Label',dat_idiom.mb_id_es)
    set(handles.mb_id_en,'Label',dat_idiom.mb_id_en)
    set(handles.mb_options,'Label',dat_idiom.mb_options)
    % menú ayuda
    set(handles.mb_help,'Label',dat_idiom.mb_help)
    set(handles.mb_about,'Label',dat_idiom.mb_about)
    % cambiar nombre de iconos
    
    % grupo 1
    set(handles.bntg_1,'Title',dat_idiom.bntg_1)
    set(handles.text_permutar,'String',dat_idiom.text_permutar)
	set(handles.text_analizar,'String',dat_idiom.text_analizar)
    % grupo 2
    set(handles.bntg_2,'Title',dat_idiom.bntg_2)
    set(handles.text_geo,'String',dat_idiom.text_geo)
    set(handles.text_roca,'String',dat_idiom.text_roca)
    set(handles.text_estrato,'String',dat_idiom.text_estrato)
    % grupo 3
    set(handles.bntg_3,'Title',dat_idiom.bntg_3)
    set(handles.text_sismo,'String',dat_idiom.text_sismo)
    % grupo 4
    set(handles.bntg_4,'Title',dat_idiom.bntg_4)
    set(handles.text_analisis,'String',dat_idiom.text_analisis)
    % grupo 5
    set(handles.bntg_5,'Title',dat_idiom.bntg_5)
    set(handles.text_id1,'String',dat_idiom.text_id1)
    set(handles.text_id2,'String',dat_idiom.text_id2)

% --------------------------------------------------------------------
function mb_arc_Callback(hObject, eventdata, handles)
% hObject    handle to mb_arc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_geo_Callback(hObject, eventdata, handles)
% hObject    handle to mb_geo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_geo_col_Callback(hObject, eventdata, handles)
% Mostrar GUI de geometría de columna
    gui_geocol


% --------------------------------------------------------------------
function mb_conf_Callback(hObject, eventdata, handles)
% hObject    handle to mb_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_cid_Callback(hObject, eventdata, handles)
% hObject    handle to m_cid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function mb_id_es_Callback(hObject, eventdata, handles)
% Cambiar idioma a español
    global path_master 
    
    p_idiom = 1;
    save(path_master,'p_idiom','-append')
    changIdiom(handles,p_idiom)

function mb_id_en_Callback(hObject, eventdata, handles)
% Cambiar idioma a inglés
    global path_master 
    
    p_idiom = 2;
    save(path_master,'p_idiom','-append')
    changIdiom(handles,p_idiom)


% --------------------------------------------------------------------
function m_prorm_Callback(hObject, eventdata, handles)
% Inicializar GUI de propiedades de roca madre
gui_proprock


% --------------------------------------------------------------------
function mb_sism_Callback(hObject, eventdata, handles)
% hObject    handle to mb_sism (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_redsis_Callback(hObject, eventdata, handles)
% Inicializar GUI
    gui_regsis


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% Cambiar dimensiones del ribbon
    pos = get(hObject,'Position');    
    rib_pos = [0,pos(4)-110,pos(3),110];
    rib_pos1 = [0,pos(4)-pos(4),pos(3),pos(4)-115];
    set(handles.ribbon,'Position',rib_pos)
    set(handles.ribbon1,'Position',rib_pos1)


% --------------------------------------------------------------------
function mb_estr_Callback(hObject, eventdata, handles)
% Abrir GUI de estratos
    gui_estratos
    
    

% --------------------------------------------------------------------
function mb_newproj_Callback(hObject, eventdata, handles)
%Crear nuevo proyecto
    global path_master
    % Seleccionar la ubicación donde guardar
    [name,path] = uiputfile('*.*','Guardar proyecto','OpenLiqProj');
    
    if name == 0
       return 
    end
    
    % Ruta de la carpeta de proyecto
    path_projF = strcat(path,name,'\');
    
    % Ruta del archivo de proyecto
    path_proj = strcat(path_projF,name,'.mat');
    
    % Crear carpeta
    mkdir(path_projF)
    
    % Almacenar rutas en archivo maestro
    save(path_master,'path_projF','path_proj','-append')
    
    % inicializar variables
    newProj(path_proj,path_projF)
    cla 'reset'
    enabled_btn(handles)
   


% --- Executes on button press in btn_perm.
function btn_perm_Callback(hObject, eventdata, handles)

    global p_idiom path_master
 
    % Ruta del archivo de proyecto
    path_dat = load(path_master,'path_proj','p_idiom');
    path_proj = path_dat.path_proj;
	p_idiom = path_dat.p_idiom;
	% Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'sElemX','damp','waterTable','rockDen','rockVS','motionStep','numLayers');
	
	sElemX          = proj_dat.sElemX;
    damp            = proj_dat.damp;
	waterTable      = proj_dat.waterTable;
    rockDen         = proj_dat.rockDen;
	rockVS          = proj_dat.rockVS;
    motionStep      = proj_dat.motionStep; 
	numLayers       = proj_dat.numLayers;
	
	if isempty(sElemX) || isempty(damp) || isempty(waterTable)
		if p_idiom == 1
        msgbox('No existen datos de geometría de columna','Error','error');
		elseif p_idiom == 2
        msgbox('There isn´t column geometry data','Error','error');
		end
	elseif isempty(rockDen) || isempty(rockVS)
		if p_idiom == 1
        msgbox('No existen datos de roca madre','Error','error');
		elseif p_idiom == 2
        msgbox('There isn´t rock data','Error','error');
		end
	elseif isempty(motionStep)
		if p_idiom == 1
        msgbox('No existen datos de sismo','Error','error');
		elseif p_idiom == 2
        msgbox('There isn´t earthquake data','Error','error');
		end
	elseif isempty(numLayers)
		if p_idiom == 1
        msgbox('No existen datos de estratos','Error','error');
		elseif p_idiom == 2
        msgbox('There aren´t strata data','Error','error');
		end
	else
		% Crear permutaciones
		permutEngine()
		saveEngine()
        
        if p_idiom == 1
            uiwait(msgbox('Operación completada','Success','modal'));
		elseif p_idiom == 2
            uiwait(msgbox('Operation Completed','Success','modal'));
		end
	end

function btn_geocol_Callback(hObject, eventdata, handles)
% Ejecutar acción
    mb_geo_col_Callback(handles.mb_geo_col, eventdata, handles)

function btn_bed_Callback(hObject, eventdata, handles)
% Ejecutar acción
    m_prorm_Callback(handles.m_prorm, eventdata, handles)
    
function btn_solay_Callback(hObject, eventdata, handles)
% Ejecutar acción
    mb_estr_Callback(handles.mb_estr, eventdata, handles)


% --- Executes on button press in btn_sis.
function btn_sis_Callback(hObject, eventdata, handles)
    mb_redsis_Callback(handles.mb_redsis, eventdata, handles)


% --- Executes on button press in btn_opc.
function btn_opc_Callback(hObject, eventdata, handles)
    mb_options_Callback(handles.mb_options, eventdata, handles)


% --- Executes on button press in btn_const.
function btn_const_Callback(hObject, eventdata, handles)
% hObject    handle to btn_const (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_esp.
function btn_esp_Callback(hObject, eventdata, handles)
    mb_id_es_Callback(handles.mb_id_es, eventdata, handles)


% --- Executes on button press in btn_eng.
function btn_eng_Callback(hObject, eventdata, handles)
    mb_id_en_Callback(handles.mb_id_en, eventdata, handles)


% --------------------------------------------------------------------
function mb_about_Callback(hObject, eventdata, handles)
    global path_master p_idiom
    path_dat = load(path_master,'p_idiom');
	p_idiom = path_dat.p_idiom;
    
    im = imread('logo.jpg');
    if p_idiom == 1
        d = dialog('Position',[450 300 400 320],'Name','Autores');
        txt = uicontrol('Parent',d,'Style','text','Position',[11 0 380 300],...
                       'String','OpenLiq v2.0',...
                       'FontWeight','bold','FontSize',11);

        txt = uicontrol('Parent',d,'Style','text','Position',[215 0 310 258],...
                       'String',{'Implementada por:';'';...
                       'Saritama, Jorge Luis ';'';...
                       'Coautores:';'';'Duque, Edwin Patricio';'';...
                       'Quiñones, Santiago';},...
                       'FontSize',9,'HorizontalAlignment','left');

        txt = uicontrol('Parent',d,'Style','text','Position',[50 0 310 105],...
                       'String',{'Departamento de estructuras, transporte y construcción';...
                       'Titulación de Ingeniería Civil';...
                       'Universidad Técnica Particular de Loja'},...
                       'FontSize',8,'HorizontalAlignment','left');

        ima = uicontrol('Parent',d,'CData',im,'Position',[50 120 140 140]);

        btn = uicontrol('Parent',d,'Position',[160 20 80 28],'String','Cerrar',...
                            'FontSize',9,'Callback','delete(gcf)');
    elseif p_idiom == 2
        d = dialog('Position',[450 300 400 320],'Name','Autors');

        txt = uicontrol('Parent',d,'Style','text','Position',[11 0 380 300],...
                       'String','OpenLiq v2.0',...
                       'FontWeight','bold','FontSize',11);

        txt = uicontrol('Parent',d,'Style','text','Position',[215 0 310 258],...
                       'String',{'Developed by:';'';...
                       'Saritama, Jorge Luis ';'';...
                       'Co-authors:';'';'Duque, Edwin Patricio';'';...
                       'Quiñones, Santiago';},...
                       'FontSize',9,'HorizontalAlignment','left');

        txt = uicontrol('Parent',d,'Style','text','Position',[50 0 310 105],...
                       'String',{'Departamento de estructuras, transporte y construcción';...
                       'Titulación de Ingeniería Civil';...
                       'Universidad Técnica Particular de Loja'},...
                       'FontSize',8,'HorizontalAlignment','left');

        ima = uicontrol('Parent',d,'CData',im,'Position',[50 120 140 140]);

        btn = uicontrol('Parent',d,'Position',[160 20 80 30],'String','Close',...
                            'FontSize',9,'Callback','delete(gcf)');
    end

% --------------------------------------------------------------------
function mb_help_Callback(hObject, eventdata, handles)
% hObject    handle to mb_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_options_Callback(hObject, eventdata, handles)
    %abrir gui de configuracion de análisis
    gui_algoritmo

% --------------------------------------------------------------------
function mb_open_Callback(hObject, eventdata, handles)
    global path_master
    
    [file,path] = uigetfile({'.mat'});

    if file == 0
        return
    end
  
    openProj(path,file)
    enabled_btn(handles)
    cla 'reset'

% --------------------------------------------------------------------
function mb_example_Callback(hObject, eventdata, handles)
    if isdeployed
       direc = strcat(ctfroot,'\ejemplos'); 
    else
       direc = strcat(pwd,'\ejemplos'); 
    end
    
    [file,path] = uigetfile({'.mat'},'Pick Another File',direc);

    if file == 0
        return
    end
    
    % corrección de ruta de sismo en ejemplo
    path_sis = strcat(path,'sismo-Ejemplo-Base-2.txt');
    save(strcat(path,file),'path_sis','-append')
    
    openProj(path,file)
    
    
    
    enabled_btn(handles)
    cla 'reset'
    



% funcion para bloquear los botones hasta crear nuevo archivo
function enabled_btn(handles)
    
    %activar botones
    % menú columna suelo
    set(handles.mb_geo,'Enable','on')
    % menú sismo
    set(handles.mb_sism,'Enable','on')
    % menú ajustes
    set(handles.mb_options,'Enable','on')
    % menú visualización
    set(handles.mb_graf,'Enable','on')
    % grupo 1
    set(handles.btn_perm,'Enable','on')
    set(handles.btn_analisis,'Enable','on')
    % grupo 2
    set(handles.btn_geocol,'Enable','on')
    set(handles.btn_bed,'Enable','on')
    set(handles.btn_solay,'Enable','on')
    % grupo 3
    set(handles.btn_sis,'Enable','on')
    % grupo 4
    set(handles.btn_opc,'Enable','on')


% --- Executes on button press in btn_analisis.
function btn_analisis_Callback(hObject, eventdata, handles)
    
    global p_idiom path_master proc  
 
    % Ruta del archivo de proyecto
    path_dat = load(path_master,'path_proj','path_projF','p_idiom');
    path_proj = path_dat.path_proj;
	path_projF = path_dat.path_projF;
    p_idiom = path_dat.p_idiom;
	% Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'columna');
	
	columna = proj_dat.columna;
	
    if ~isempty(columna)
        
        if p_idiom == 1
            t = 'Procesando...';
            t1 = 'Por favor espere...';
        elseif p_idiom == 2
            t = 'Processing...';
            t1 = 'Please wait...';
        end
        scrsz = get(0,'ScreenSize');
        hFig = figure('Position',[0.5*scrsz(3)-190 0.5*scrsz(4)-50 350 300],'MenuBar','none',...
                'WindowStyle','modal','NumberTitle','off','Name','Análisis');

        MyBox1 = uicontrol('style','text');
        set(MyBox1,'String',t)
        set(MyBox1,'Position',[52,280,250,20],'FontWeight','bold','fontSize',10)
        set(MyBox1,'backgroundcolor',get(hFig,'color'))
        MyBox2 = uicontrol('style','text');
        set(MyBox2,'String',t1)
        set(MyBox2,'Position',[53,250,250,20],'fontSize',8)
        set(MyBox2,'backgroundcolor',get(hFig,'color'))
        btnStop = uicontrol(hFig, 'Style','pushbutton','Position',...
            [116 16 102 34],'String', 'Stop', 'Callback',@stop_callback);
        
        txtLog = uicontrol(hFig, 'Style', 'Edit','HorizontalAlignment', ...
            'left', 'Position', [15 73 322 167], 'Max', 2, 'Min', 0);
        
        
        comando = 'OpenSees.exe main.tcl';
        startInfo = System.Diagnostics.ProcessStartInfo('cmd.exe', ...
                          sprintf('/c "%s"', comando));
        
        % oculta venta CMD de ejecución
        %startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
        
        % borra resultados previos de análisis
        fclose('all');
        pathStatusAnalisis = strcat(path_projF,'post_proceso\Analysis_executed.txt');
        if isfile(pathStatusAnalisis)
            delete(pathStatusAnalisis);
        end
        
        proc = System.Diagnostics.Process.Start(startInfo);
        
        if isempty(proc)
            error('Failed to launch process');
        end
        
        
        strAnalisis = '';
        while true
            if proc.HasExited
                fprintf('\nProcess exited with status %d\n', proc.ExitCode);
                break
            end
            
            contentFileStatus = '';
            if isfile(pathStatusAnalisis)
                contentFileStatus = fileread(pathStatusAnalisis);
            end
            
            pause(2.0);
            
            % actualiza solo si hay nueva información
            if strlength(contentFileStatus) > strlength(strAnalisis)
                expr = '[^\n]*';
                contentFileStatus = regexp(contentFileStatus,expr,'match');
                set(txtLog, 'String', contentFileStatus)
                strAnalisis = contentFileStatus;
            end
        end
        
        delete(hFig)
        
        path = strcat(path_projF,'post_proceso/Error.dat');
        if exist(path)
            a = importdata(path);
            msgbox(a,'Error','error');
            return
            %agregar valor de grafico = fale
        else
            graficos = 1;
            save(path_proj,'graficos','-append')
            if p_idiom == 1
                msgbox('Análisis completado');
            elseif p_idiom == 2
                msgbox('Completed analysis');
            end
        end
    else
        if p_idiom == 1
            msgbox('Generar permutaciones','Error','error');
		elseif p_idiom == 2
            msgbox('Generate combinations','Error','error');
        end
    end
% --------------------------------------------------------------------
function mb_graf_Callback(hObject, eventdata, handles)
% hObject    handle to mb_graf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_comparacion_Callback(hObject, eventdata, handles)
    % Ruta del archivo de proyecto
    global path_master
    path_dat = load(path_master,'path_proj','p_idiom');
    path_proj = path_dat.path_proj;
    p_idiom = path_dat.p_idiom;
	% Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'graficos');
	graficos = proj_dat.graficos;
    
    if graficos == 1
        gui_comparacion(handles.graficos)
    else
        if p_idiom == 1
            msgbox('No se ha generado el análisis.','Error','error');
		elseif p_idiom == 2
            msgbox('Analysis hasn´t been generated.','Error','error');
        end 
    end



% --------------------------------------------------------------------
function mb_liq_Callback(hObject, eventdata, handles)
    global path_master
    path_dat = load(path_master,'path_proj','p_idiom');
    path_proj = path_dat.path_proj;
    p_idiom = path_dat.p_idiom;
    % Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'graficos');
	graficos = proj_dat.graficos;
    
    if graficos == 1
        gui_liq(handles.graficos)
    else
        if p_idiom == 1
            msgbox('No se ha generado el análisis.','Error','error');
		elseif p_idiom == 2
            msgbox('Analysis hasn´t been generated.','Error','error');
        end 
    end


% --------------------------------------------------------------------
function mb_result_Callback(hObject, eventdata, handles)
% hObject    handle to mb_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_all_Callback(hObject, eventdata, handles)
	global p_idiom path_master
 
    % Ruta del archivo de proyecto
    path_dat = load(path_master,'path_proj','path_projF','p_idiom');
    path_proj = path_dat.path_proj;
	path_projF = path_dat.path_projF;
    p_idiom = path_dat.p_idiom;
    % Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'columna','motionDT','motionStep','graficos');
	
	columna = proj_dat.columna;
    graficos = proj_dat.graficos;
    if graficos == 1
        if p_idiom == 1
            [nombre,direccion]= uiputfile('*.*','Seleccione destino');
        elseif p_idiom == 2
            [nombre,direccion]= uiputfile('*.*','Select folder');
        end
        if nombre == 0
            return
        end
    
        for i=1:columna
            resultado(path_projF,direccion,nombre,i)
        end
    else
        if p_idiom == 1
            msgbox('No se ha generado el análisis.','Error','error');
		elseif p_idiom == 2
            msgbox('Analysis hasn´t been generated.','Error','error');
        end 
    end
    
    
% --------------------------------------------------------------------
function mb_select_Callback(hObject, eventdata, handles)
% hObject    handle to mb_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mb_conf_geo_Callback(hObject, eventdata, handles)
    global path_master
    path_dat = load(path_master,'path_proj','p_idiom');
    path_proj = path_dat.path_proj;
    p_idiom = path_dat.p_idiom;
    % Cargar datos a los recuadros de texto
    proj_dat = load(path_proj,'columna');  
    columna = proj_dat.columna;
    
    if ~isempty(columna)
        gui_col
    else
        if p_idiom == 1
            msgbox('No se ha generado el análisis.','Error','error');
		elseif p_idiom == 2
            msgbox('Analysis hasn´t been generated.','Error','error');
        end 
    end
    
  % --------------------------------------------------------------------
  function stop_callback(hObject, ~)
      try
        cmd = 'TASKKILL /F /IM OpenSees.exe';
        system(cmd)
      catch
        disp('Error al detener opensees')
      end
      
      
