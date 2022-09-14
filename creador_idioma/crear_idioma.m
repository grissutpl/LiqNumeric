% Este script no forma parte del software.
% Ha sido desarrollado con el objetivo de facilitar la creación de paquetes
% de idioma y almacenarlos en archivos mat


% ======================================================================= %
%       E S P A Ñ O L
% ======================================================================= %
clc
clear

% Variables para la interfaz gui_main.fig ---------------------------------
% Menú
gui_nam_main = 'OpenLiq 2.0';
% menú archivo
mb_arc = 'Archivo';
mb_newproj = 'Nuevo';
mb_open = 'Abrir';
mb_example = 'Ejemplos';
%menú características del suelo
mb_geo = 'Columna de suelo';
mb_geo_col = 'Geometría de la columna de suelo';
m_prorm = 'Propiedades de roca madre';
mb_estr = 'Estratos de suelo';
%menú de sismo
mb_sism = 'Sismo';
mb_redsis = 'Registro sísmico';
%menú de visualización
mb_conf_geo = 'Configuración geométrica';
mb_graf = 'Visualización';
mb_comparacion = 'Gráficas de comparacion';
mb_liq = 'Gráfica de licuefacción';
mb_result = 'Resultados';
mb_all = 'Todas las columnas';
mb_select = 'Seleccionar columna';
% menú ajustes
mb_conf = 'Ajustes';
m_cid   = 'Idioma';
mb_id_es = 'Español';
mb_id_en = 'English';
mb_options  = 'Opciones de análisis';
% menú ayuda
mb_help = 'Ayuda';
mb_about = 'Acerda de';

% cambiar nombre de iconos
% grupo 1
bntg_1 = 'Análisis';
text_permutar = 'Permutar variables';
text_analizar = 'Analizar';
% grupo 2
bntg_2 = 'Columna de suelo';
text_geo = 'Geometría de columna';
text_roca = 'Prop. Roca madre';
text_estrato = 'Prop. Estratos';
% grupo 3
bntg_3 = 'Sismo';
text_sismo = 'Regístro sísmico';
% grupo 4
bntg_4 = 'Opciones';
text_analisis = 'Opciones de análisis';
% grupo 5
bntg_5 = 'Idioma';
text_id1 = 'Español';
text_id2 = 'Ingles';

% Variables para la interfaz gui_geocol.fig -------------------------------
gui_nam = 'Geometría de la columna de suelo';

uip_gcs = 'Geometría de la columna de suelo';
uip_mcs = 'Modelo de columna de suelo';

text_aco = 'Ancho de la columna';
text_pnf = 'Prof. nivel freático';
text_amo = 'Amortiguamiento';

btn_ok = 'Aceptar';

% Variables para la interfaz gui_vecman.fig -------------------------------

gui_nam_vecman = 'Generador de vectores';

uip_dve = 'Datos del vector';
uip_tel = 'Elementos';

text_vin = 'Valor inicial';
text_vfi = 'Valor final';
text_nue = 'Número de elementos';
btn_eval = 'Evaluar';

% Variables para la interfaz gui_proprock.fig -----------------------------
gui_nam_proprock = 'Propiedades de la roca madre';

uip_prm = 'Propiedades de la roca madre';
text_drm = 'Densidad de la roca madre';
text_voc = 'Velocidad de onda de corte';

% Variables para la interfaz gui_regsis.fig -------------------------------

gui_nam_regsis = 'Registro sísmico';

uip_regs = 'Registro sísmico';
uip_aclgr = 'Acelerograma';
uip_file = 'Archivo de registro sísmico';

text_dti = 'Incremento de tiempo (dT)';
text_urs = 'Unidad de registro sísmico';
text_fcn = 'Factor de conversión';
text_amp = 'Amplificación';
text_path = 'Ruta de archivo';

btn_load = 'Cargar registro';

% Variables para la interfaz gui_algoritmo.fig -------------------------------

uip_estatico = 'Análisis estático';
uip_dinamico = 'Análisis dinámico';
text_rest = 'Restricciones';
text_rest1 = 'Restricciones';
text_num = 'Numerador';
text_num1 = 'Numerador';
text_analisis2 = 'Análisis';
text_analisis1 = 'Análisis';
text_tol = 'Tolerancia';
text_tol1 = 'Tolerancia';
text_iter = 'Iteraciones';
text_iter1 = 'Iteraciones';
text_print = 'Impresión';
text_print1 = 'Impresión';
text_sistem = 'Sistema';
text_sistem1 = 'Sistema';
text_algoritmo = 'Algoritmo';
text_algoritmo1 = 'Algoritmo';
text_integrador = 'Integrador';
text_integrador1 = 'Integrador';
text_fmax = 'Frecuencia máxima';
text_elem = '# Elementos';
btn_algoritmo = 'Aceptar';
gui_nam_analisis = 'Opciones de análisis';

% Variables para la interfaz gui_estratos.fig ---------------------------------

gui_nam_estrato = 'Características mecánicas del suelo';
uip_prop = 'Propiedades mecánicas del suelo';
text_tipo = 'Tipo';
text_espesor = 'Espesor (m)';
text_pendiente = 'Pendiente (%)';
text15 = 'Crear estrato';
text27 = 'Aplicar cambio';
uip_estratos = 'Estratos del suelo';
btn_edit = 'Editar';
btn_del = 'Eliminar';
uip_resumen = 'Resumen de propiedades';

% Variables para la interfaz gui_comparacion.fig -------------------------------

gui_name_comp = 'Comparación de gráficas';
uib_g1 = 'Gráfica 1';
radio_prof1 = 'Profundidad (m)';
radio_time1 = 'Tiempo (s)';
radio_total1 = 'Resultados totales';
btn_grafica1 = 'Graficar';

% Variables para la interfaz gui_geocol.fig -------------------------------

gui_name_liq = 'Gráfica de licuefacción';
text_profD = 'Profundidad (m)';
btn_liq = 'Graficar';

% Variables para la interfaz gui_col.fig -------------------------------

gui_nam_conf_col = 'Geometría';
btn_graf_conf = 'Graficar';

% ------------------------------------------------------------------------ 

save(strcat(pwd,'\idiom\pidiom_es.mat'))

% ======================================================================= %
%       I N G L É S
% ======================================================================= %
clc
clear

% Variables para la interfaz gui_main.fig ---------------------------------
% Menú
gui_nam_main = 'OpenLiq 2.0';
% menú archivo
mb_arc = 'File';
mb_newproj = 'New';
mb_open = 'Open';
mb_example = 'Examples';
%menú características del suelo
mb_geo = 'Soil column';
mb_geo_col = 'Soil column geometry ';
m_prorm = 'Bedrock properties';
mb_estr = 'Soil layer';
%menú de sismo
mb_sism = 'Earthquake';
mb_redsis = 'Record seismic';
%menú de visualización
mb_conf_geo = 'Geometric configuration';
mb_graf = 'Display';
mb_comparacion = 'Comparison graphs';
mb_liq = 'Graph of liquefaction';
mb_result = 'Results';
mb_all = 'All columns';
mb_select = 'Select column';
% menú ajustes
mb_conf = 'Settings';
m_cid   = 'Language';
mb_id_es = 'Spanish';
mb_id_en = 'English';
mb_options  = 'Analysis options';
% menú ayuda
mb_help = 'Help';
mb_about = 'About';

% cambiar nombre de iconos
% grupo 1
bntg_1 = 'Analysis';
text_permutar = 'Merge variables';
text_analizar = 'Analyze';
% grupo 2
bntg_2 = 'Soil column';
text_geo = 'Soil column geometry';
text_roca = 'Bedrock properties';
text_estrato = 'Layers properties';
% grupo 3
bntg_3 = 'Earthquake';
text_sismo = 'Record seismic';
% grupo 4
bntg_4 = 'Options';
text_analisis = 'Analysis options';
% grupo 5
bntg_5 = 'Language';
text_id1 = 'Spanish';
text_id2 = 'English';

% Variables para la interfaz gui_geocol.fig -------------------------------
gui_nam = 'Soil column geometry';

uip_gcs = 'Soil column geometry';
uip_mcs = 'Soil column model';

text_aco = 'Column width';
text_pnf = 'Watertable depth';
text_amo = 'Damping coeff';

btn_ok = 'OK';

% Variables para la interfaz gui_vecman.fig ------------------------------

gui_nam_vecman = 'Vector generator';

uip_dve = 'Vector data';
uip_tel = 'Elements';

text_vin = 'Initial value';
text_vfi = 'Final value';
text_nue = 'Number of elements';
btn_eval = 'Eval';

% Variables para la interfaz gui_proprock.fig -----------------------------
gui_nam_proprock = 'Properties of bedrock';

uip_prm = 'Properties of bedrock';
text_drm = 'Bedrock mass density';
text_voc = 'Shear wave velocity';

% Variables para la interfaz gui_regsis.fig -------------------------------

gui_nam_regsis = 'Seismic record';

uip_regs = 'Seismic record';
uip_aclgr = 'Accelerogram';
uip_file = 'Seismic record file';

text_dti = 'Increase of time (dT)';
text_urs = 'Seismic record unit';
text_fcn = 'Conversion factor';
text_amp = 'Amplification';
text_path = 'File path';

btn_load = 'Load record';

% Variables para la interfaz gui_algoritmo.fig -------------------------------

uip_estatico = 'Static analysis';
uip_dinamico = 'Dynamic analysis';
text_rest = 'Constrains';
text_rest1 = 'Constrains';
text_num = 'Numberer';
text_num1 = 'Numberer';
text_analisis2 = 'Analysis';
text_analisis1 = 'Analysis';
text_tol = 'Tolerance';
text_tol1 = 'Tolerance';
text_iter = 'Iterations';
text_iter1 = 'Iterations';
text_print = 'Print';
text_print1 = 'Print';
text_sistem = 'System';
text_sistem1 = 'System';
text_algoritmo = 'Algorithm';
text_algoritmo1 = 'Algorithm';
text_integrador = 'Integrator';
text_integrador1 = 'Integrator';
text_fmax = 'Maximum frequency';
text_elem = '# Elements';
btn_algoritmo = 'Ok';
gui_nam_analisis= 'Analysis options';

% Variables para la interfaz gui_estratos.fig ---------------------------------

gui_nam_estrato = 'Mechanical properties of soil ';
uip_prop = ' Mechanical properties of soil ';
text_tipo = 'Type';
text_espesor = 'Thickness (m)';
text_pendiente = 'Slope (%)';
text15 = 'Create layer';
text27 = 'Apply change';
uip_estratos = 'Soil layer';
btn_edit = 'Edit';
btn_del = 'Delete';
uip_resumen = 'Summary of properties';

% Variables para la interfaz gui_comparacion.fig -------------------------------

gui_name_comp = 'Comparison of graphics';
uib_g1 = 'Graph 1';
radio_prof1 = 'Depth (m)';
radio_time1 = 'Time (s)';
radio_total1 = 'Total Results';
btn_grafica1 = 'Graph';

% Variables para la interfaz gui_geocol.fig -------------------------------

gui_name_liq = 'Graph of liquefaction';
text_profD = 'Depth (m)';
btn_liq = 'Graph';

% Variables para la interfaz gui_col.fig -------------------------------

gui_nam_conf_col = 'Geometry';
btn_graf_conf = 'Graph';

% ------------------------------------------------------------------------ 
save(strcat(pwd,'\idiom\pidiom_en.mat'))


% ------------------------------------------------------------------------ 
p_idiom = 1;

save(strcat(pwd,'\mat\mfbi_001.mat'),'p_idiom','-append')

clear