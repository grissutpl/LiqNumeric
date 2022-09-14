%% Test Columna 1 - Result displacementx.out
%!OpenSees main.tcl
path_proj_example = '..\ejemplos\3capas_nocohesivo\';
path_despx_actual = strcat(path_proj_example,'post_proceso\','columna_1\dinamico','\desplazamientos','\displacementx.out');
path_despx_expected = '.\expected\displacementx.out';
dispx_actual = importdata(path_despx_actual);
dispx_expected = importdata(path_despx_expected);

assert(isequal(dispx_actual(:,:), dispx_expected(:,:)))