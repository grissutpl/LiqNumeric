function varargout = gui_info(varargin)
% GUI_INFO MATLAB code for gui_info.fig
%      GUI_INFO, by itself, creates a new GUI_INFO or raises the existing
%      singleton*.
%
%      H = GUI_INFO returns the handle to a new GUI_INFO or the handle to
%      the existing singleton*.
%
%      GUI_INFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INFO.M with the given input arguments.
%
%      GUI_INFO('Property','Value',...) creates a new GUI_INFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_info_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_info_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_info

% Last Modified by GUIDE v2.5 19-Mar-2019 14:47:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_info_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_info_OutputFcn, ...
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


% --- Executes just before gui_info is made visible.
function gui_info_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

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
    
    dat_master = load(path_master,'p_idiom','path_projF');
    
    path_projF = dat_master.path_projF;
    p_idiom = dat_master.p_idiom;

    mostrar(path_projF,p_idiom,handles,varargin{1})
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_info wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_info_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function mostrar(path_projF,idioma,handles,columna)

    if idioma == 1
        titulos = {'Espesor de columna (m):';'Prof. nivel freático (m):';'Coef. amortiguamiento (%):';'Vs onda en roca (m/s):';'Densidad de roca (Mg/m3):'};
        titulos2 = {'Tipo';'Espesor (m):';'Pendiente (%)';'Rho (T/m3):';'Gr (kPa):';'Br (kPa):';'Bc (kPa):';...
               'f (º):';'Vperm (m/s):';'Hperm (m/s):';'Vs (m/s):';'refPress';'surf';'e (adim):';'Coef. contr. 1';...
               'Coef. contr. 3';'Coef. dilt. 1';'Coef. dilat.3';'PTAng (º)';'cohesion (kPa)'};
    elseif idioma == 2
        titulos = {'Column width (m):';'Watertable depth (m):';'Damping coeff (%):';'Shear wave velocity (m/s):';'Bedrock mass density (Mg/m3):'};
        titulos2 = {'Type';'Thickness (m):';'Slope (%)';'Rho (T/m3):';'Gr (kPa):';'Br (kPa):';'Bc (kPa):';...
               'f (º):';'Vperm (m/s):';'Hperm (m/s):';'Vs (m/s):';'refPress';'surf';'e (adim):';'Coef. contr. 1';...
               'Coef. contr. 3';'Coef. dilt. 1';'Coef. dilat.3';'PTAng (º)';'cohesion (kPa)'};
    end
    
    set(handles.uitable1,'RowName',titulos);
    set(handles.uitable2,'RowName',titulos2);
    
    % crgar datos de las columnas
    path_col = strcat(path_projF,'pre_proceso\','columna_',num2str(columna),'\columna_',num2str(columna),'.mat');
	path_dat = load(path_col,'sElemX','waterTable','rockVS','rockDen','damp','tipo',...
                    'grade','layerThick','rho','refShearModul','refBulkModul','uBulk',...
                    'frictionAng','Vs','vPerm','hPerm','refPress','surf','e','contrac1',...
                    'contrac3','dilat1','dilat3','PTAng','cohesion');
	
	sElemX          = path_dat.sElemX;
	waterTable      = path_dat.waterTable;
	rockVS          = path_dat.rockVS;
	rockDen         = path_dat.rockDen;
	damp            = path_dat.damp;
    tipo            = path_dat.tipo;
    grade           = path_dat.grade;
    layerThick      = path_dat.layerThick;
    rho             = path_dat.rho;
    refShearModul   = path_dat.refShearModul;
    refBulkModul    = path_dat.refBulkModul;
    uBulk           = path_dat.uBulk;
    frictionAng     = path_dat.frictionAng;
    Vs              = path_dat.Vs;
    vPerm           = path_dat.vPerm;
    hPerm           = path_dat.hPerm;
    refPress        = path_dat.refPress;
    surf            = path_dat.surf;
    e               = path_dat.e;
    contrac1        = path_dat.contrac1;
    contrac3        = path_dat.contrac3;
    dilat1          = path_dat.dilat1;
    dilat3          = path_dat.dilat3;
    PTAng           = path_dat.PTAng;
    cohesion        = path_dat.cohesion;
    
    datos = {sElemX;waterTable;damp*100;rockVS;rockDen};
    datos2 = {tipo{:};layerThick{:};grade{:};rho{:};...
            refShearModul{:};refBulkModul{:};uBulk{:};...
            frictionAng{:};vPerm{:};hPerm{:};Vs{:};refPress{:};...
            surf{:};e{:};contrac1{:};contrac3{:};dilat1{:};...
            dilat3{:};PTAng{:};cohesion{:}};
    set(handles.uitable1,'Data',datos);
    set(handles.uitable2,'Data',datos2);
    
