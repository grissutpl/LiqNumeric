% Precondiciones
path_proj_example = '..\ejemplos\3capas_nocohesivo\';
rutaArchivoModelo = strcat(path_proj_example, 'pre_proceso\algoritmo_analisis.txt');

%% Test  model file exists
assert(isfile(rutaArchivoModelo)==1, 'algoritmo_analisis.txt does not exist')

%% Test: model variables
% ANÁLISIS ESTÁTICO 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'constraints_e'), 'Penalty')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'c1_e'), '1e+14')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'c2_e'), '1e+14')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'test_e'), 'NormDispIncr')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'tol_e'), '0.0001')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'iter_e'), '100')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'salida_e'), '2')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'alg_e'), 'KrylovNewton')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'val_e'), '0')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'numberer_e'), 'RCM')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'system_e'), 'ProfileSPD')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'integrator_e'), 'Newmark')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'gama_e'), '0.5')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'beta_e'), '0.25')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'analysis_e'), 'Transient')) 
% ANÁLISIS DINÁMICO 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'constraints_d'), 'Penalty')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'c1_d'), '1e+16')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'c2_d'), '1e+16')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'test_d'), 'NormDispIncr')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'tol_d'), '0.009')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'iter_d'), '200')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'salida_d'), '2')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'alg_d'), 'KrylovNewton')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'val_d'), '0')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'numberer_d'), 'RCM')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'system_d'), 'ProfileSPD')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'integrator_d'), 'Newmark')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'gama_d'), '0.5')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'beta_d'), '0.25')) 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'analysis_d'), 'Transient')) 
% Número de columnas para el análisis 
assert(strcmp(obtener_val_modelo(rutaArchivoModelo, 'columnas'), '8')) 