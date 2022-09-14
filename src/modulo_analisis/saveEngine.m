function saveEngine()
% Leer archivo de información permutada
if isdeployed
    path_master = strcat(ctfroot,'\mat\mfbi_001.mat');
else
    path_master = strcat(pwd,'\mat\mfbi_001.mat');
end


path_dat = load(path_master,'path_projF','path_proj');
path_proj = path_dat.path_proj;
path_projF = path_dat.path_projF;

path_pre = strcat(path_projF,'pre_proceso');
path_post = strcat(path_projF,'post_proceso');



dat_per = load(strcat(path_pre,'\mfpi.mat'));

in_per = dat_per.col_per;

% Determinar cuantos casos de columnas hay y su numero de estratos
[nrow,ncol] = size(in_per);

% Número de estratos
nest = ncol - 7; % Pilas es 8 corresponde a los 8 datos de entrada





% Crear carpera columnas
path_colF = strcat(path_projF,'pre_proceso\');
% if exist(path_colF,'dir')
%    rmdir(path_colF,'s') 
% end
%     mkdir(path_colF)
    

%soilThick,sElemX,waterTable,damp,rockDen,rockVS,motionDT,motionStep,est{:}
% de_text = cell(nest,1);
proj_dat = load(path_proj,'numLayers','faconv','famp','path_sis',...
                  'restricion','alphasp','alphamp','numerador',...
                  'analisis','test','tol','iter','impresion',...
                  'sistema','algorit','coef','integrador','gamma',...
                  'beta','restricion1','alphasp1','alphamp1','numerador1',...
                  'analisis1','test1','tol1','iter1','impresion1',...
                  'sistema1','algorit1','coef1','integrador1',...
                  'gamma1','beta1');
              
numLayers = proj_dat.numLayers;
faconv  = proj_dat.faconv;
famp    = proj_dat.famp;
path_sis = proj_dat.path_sis;

%crear archivo de análisis
restricion      = proj_dat.restricion;
alphasp         = proj_dat.alphasp;
alphamp         = proj_dat.alphamp;
numerador       = proj_dat.numerador;
analisis        = proj_dat.analisis;
test            = proj_dat.test;
tol             = proj_dat.tol;
iter            = proj_dat.iter;
impresion       = proj_dat.impresion;
sistema         = proj_dat.sistema;
algorit         = proj_dat.algorit;
coef            = proj_dat.coef;
integrador      = proj_dat.integrador;
gamma           = proj_dat.gamma;
beta            = proj_dat.beta;
restricion1     = proj_dat.restricion1;
alphasp1        = proj_dat.alphasp1;
alphamp1        = proj_dat.alphamp1;
numerador1      = proj_dat.numerador1;
analisis1       = proj_dat.analisis1;
test1           = proj_dat.test1;
tol1            = proj_dat.tol1;
iter1           = proj_dat.iter1;
impresion1      = proj_dat.impresion1;
sistema1        = proj_dat.sistema1;
algorit1        = proj_dat.algorit1;
coef1           = proj_dat.coef1;
integrador1     = proj_dat.integrador1;
gamma1          = proj_dat.gamma1;
beta1           = proj_dat.beta1;

    if restricion==1  
        text_rest = 'Plain';
    elseif restricion == 2
        text_rest = 'Penalty';
    elseif restricion == 3
        text_rest = 'Lagrange';
    elseif restricion == 4
        text_rest = 'Transformation';
    end
   
        
    if restricion1==1  
        text_rest1 = 'Plain';
    elseif restricion1 == 2
        text_rest1 = 'Penalty';
    elseif restricion1 == 3
        text_rest1 = 'Lagrange';
    elseif restricion1 == 4
        text_rest1 = 'Transformation';
    end
        
    if numerador==1  
        text_num = 'Plain';
    elseif numerador == 2
        text_num = 'RCM';
    end
    
        
    if numerador1==1  
        text_num1 = 'Plain';
    elseif numerador1 == 2
        text_num1 = 'RCM';
    end
        
        
    if analisis==1  
        text_ana = 'Transient';
    elseif analisis == 2
        text_ana = 'Variable Transient';
    end
      
    if analisis1==1  
        text_ana1 = 'Transient';
    elseif analisis1 == 2
        text_ana1 = 'Variable Transient';
    end
        
        
    if test==1  
        text_test = 'NormUnbalance';
    elseif test == 2
        text_test = 'NormDispIncr';
    elseif test == 3
        text_test = 'EnergyIncr';
    end
        
    if test1==1  
        text_test1 = 'NormUnbalance';
    elseif test1 == 2
        text_test1 = 'NormDispIncr';
    elseif test1 == 3
        text_test1 = 'EnergyIncr';
    end
        
     
    
    if sistema==1  
        text_sistem = 'BandGeneral';
    elseif sistema == 2
        text_sistem = 'BandSPD';
    elseif sistema == 3
        text_sistem = 'ProfileSPD';
    elseif sistema == 4
        text_sistem = 'SparseGeneral';
    elseif sistema == 5
        text_sistem = 'UmfPack';
    elseif sistema == 6
        text_sistem = 'SparseSPD';
    end
    
    if sistema1==1  
        text_sistem1 = 'BandGeneral';
    elseif sistema1 == 2
        text_sistem1 = 'BandSPD';
    elseif sistema1 == 3
        text_sistem1 = 'ProfileSPD';
    elseif sistema1 == 4
        text_sistem1 = 'SparseGeneral';
    elseif sistema1 == 5
        text_sistem1 = 'UmfPack';
    elseif sistema1 == 6
        text_sistem1 = 'SparseSPD';
    end
        
    
    
    if algorit==1  
        text_alg = 'Linear';
    elseif algorit == 2
        text_alg = 'Newton';
    elseif algorit == 3
        text_alg = 'NewtonLineSearch';
    elseif algorit == 4
        text_alg = 'ModifiedNewton';
    elseif algorit == 5
        text_alg = 'KrylovNewton';
    elseif algorit == 6
        text_alg = 'BFGS';
    elseif algorit == 7
        text_alg = 'Broyden';
    end
    
    if algorit1==1  
        text_alg1 = 'Linear';
    elseif algorit1 == 2
        text_alg1 = 'Newton';
    elseif algorit1 == 3
        text_alg1 = 'NewtonLineSearch';
    elseif algorit1 == 4
        text_alg1 = 'ModifiedNewton';
    elseif algorit1 == 5
        text_alg1 = 'KrylovNewton';
    elseif algorit1 == 6
        text_alg1 = 'BFGS';
    elseif algorit1 == 7
        text_alg1 = 'Broyden';
    end
    
    if impresion == 1
        imp = 0;
    elseif impresion == 2 
        imp = 1;
    elseif impresion == 3 
        imp = 2;
    elseif impresion == 4 
        imp = 3;
    elseif impresion == 5 
        imp = 4;
    elseif impresion == 6 
        imp = 5;
    end
    
    if impresion1 == 1
        imp1 = 0;
    elseif impresion1 == 2 
        imp1 = 1;
    elseif impresion1 == 3 
        imp1 = 2;
    elseif impresion1 == 4 
        imp1 = 3;
    elseif impresion1 == 5 
        imp1 = 4;
    elseif impresion1 == 6 
        imp1 = 5;
    end
    
    if integrador==1  
        text_int = 'Newmark';
    end
    
    if integrador1==1  
        text_int1 = 'Newmark';
    end
    
    path = strcat(path_projF,'pre_proceso\algoritmo_analisis.txt');
    
    archivo = fopen(path,'w','n','UTF-8');
   
   fprintf(archivo,'#ANÁLISIS ESTÁTICO \n\n');
    fprintf(archivo,'set constraints_e %s \n',text_rest);
    fprintf(archivo,'set c1_e %s \n',alphasp);
    fprintf(archivo,'set c2_e %s \n\n',alphamp);
    fprintf(archivo,'set test_e %s \n',text_test);
    fprintf(archivo,'set tol_e %s \n',tol);
    fprintf(archivo,'set iter_e %i \n',iter);
    fprintf(archivo,'set salida_e %i \n\n',imp);
    fprintf(archivo,'set alg_e %s \n',text_alg);
    fprintf(archivo,'set val_e %f \n\n',coef);
    fprintf(archivo,'set numberer_e %s \n\n',text_num);
    fprintf(archivo,'set system_e %s \n\n',text_sistem);
    fprintf(archivo,'set integrator_e %s \n\n',text_int);
    fprintf(archivo,'set gama_e %s \n',gamma);
    fprintf(archivo,'set beta_e %s \n',beta);
    fprintf(archivo,'set analysis_e %s \n\n\n',text_ana);
    fprintf(archivo,'#ANÁLISIS DINÁMICO \n\n');
    fprintf(archivo,'set constraints_d %s \n',text_rest1);
    fprintf(archivo,'set c1_d %s \n',alphasp1);
    fprintf(archivo,'set c2_d %s \n\n',alphamp1);
    fprintf(archivo,'set test_d %s \n',text_test1);
    fprintf(archivo,'set tol_d %s \n',tol1);
    fprintf(archivo,'set iter_d %i \n',iter1);
    fprintf(archivo,'set salida_d %i \n\n',imp1);
    fprintf(archivo,'set alg_d %s \n',text_alg1);
    fprintf(archivo,'set val_d %i \n',coef1);
    fprintf(archivo,'set numberer_d %s \n\n',text_num1);
    fprintf(archivo,'set system_d %s \n\n',text_sistem1);
    fprintf(archivo,'set integrator_d %s \n\n',text_int1);
    fprintf(archivo,'set gama_d %s \n',gamma1);
    fprintf(archivo,'set beta_d %s \n',beta1);
    fprintf(archivo,'set analysis_d %s \n\n\n',text_ana1);
    fprintf(archivo,'#Número de columnas para el análisis \n\n');
    fprintf(archivo,'set columnas %i \n\n\n',nrow);
    fclose(archivo);
%

vec_plot = cell(nrow,1);

for i = 1:nrow
    
    % Crear sub carpeta
    mkdir(strcat(path_colF,'columna_',num2str(i)))
    pathf = strcat(path_colF,'columna_',num2str(i),'\columna_',num2str(i),'.txt');
    pathmf = strcat(path_colF,'columna_',num2str(i),'\columna_',num2str(i),'.mat');
    geo_file = fopen(pathf,'w');
    
    
    dg_text = {'########################## DATOS GENERALES ##########################';...
               horzcat('set sElemX ',num2str(in_per{i,1}));... 
               horzcat('set waterTable ',num2str(in_per{i,2}));... 
               horzcat('set damp ',num2str(in_per{i,3}));... 
               horzcat('set rockDen ',num2str(in_per{i,4}));... 
               horzcat('set rockVS ',num2str(in_per{i,5}));... 
               horzcat('set motionDT ',num2str(in_per{i,6}));...
               horzcat('set motionStep ',num2str(in_per{i,7}));...
               horzcat('set numLayers ',num2str(numLayers));...
               ''};
           
    fprintf(geo_file,'%s\n',dg_text{:});
    
            for j = 1:nest
                
                de_text = {horzcat('##########################    ESTRATO ',...
                    num2str(j),'    ##########################');
                    horzcat('set tipo(',num2str(j),') ',num2str(in_per{i,j+7}(1)));...
                    horzcat('set grade(',num2str(j),') ',num2str(in_per{i,j+7}(2)));...
                    horzcat('set layerThick(',num2str(j),') ',num2str(in_per{i,j+7}(3)));...
                    horzcat('set rho(',num2str(j),') ',num2str(in_per{i,j+7}(4)));...
                    horzcat('set refShearModul(',num2str(j),') ',num2str(in_per{i,j+7}(5)));...
                    horzcat('set refBulkModul(',num2str(j),') ',num2str(in_per{i,j+7}(6)));...
                    horzcat('set uBulk(',num2str(j),') ',num2str(in_per{i,j+7}(7)));...
                    horzcat('set frictionAng(',num2str(j),') ',num2str(in_per{i,j+7}(8)));...
                    horzcat('set vPerm(',num2str(j),') ',num2str(in_per{i,j+7}(9)));...
                    horzcat('set hPerm(',num2str(j),') ',num2str(in_per{i,j+7}(10)));...
                    horzcat('set Vs(',num2str(j),') ',num2str(in_per{i,j+7}(11)));...
                    horzcat('set refPress(',num2str(j),') ',num2str(in_per{i,j+7}(12)));...
                    horzcat('set surf(',num2str(j),') ',num2str(in_per{i,j+7}(13)));...
                    horzcat('set e(',num2str(j),') ',num2str(in_per{i,j+7}(14)));...
                    horzcat('set PTAng(',num2str(j),') ',num2str(in_per{i,j+7}(15)));...
                    horzcat('set contrac1(',num2str(j),') ',num2str(in_per{i,j+7}(16)));...
                    horzcat('set contrac3(',num2str(j),') ',num2str(in_per{i,j+7}(17)));...
                    horzcat('set dilat1(',num2str(j),') ',num2str(in_per{i,j+7}(18)));...
                    horzcat('set dilat3(',num2str(j),') ',num2str(in_per{i,j+7}(19)));...
                    horzcat('set cohesion(',num2str(j),') ',num2str(in_per{i,j+7}(20)));...
                    ''};
                fprintf(geo_file,'%s\n',de_text{:});
            end    
    fclose(geo_file);
    
    % Creación de archivo mat
    archivo         = 2;
    columna         = {};
    graficos        = 0;
    tipo    = num2cell(cellfun(@(v)v(1),in_per(i,8:ncol)'))';
    grade   = num2cell(cellfun(@(v)v(2),in_per(i,8:ncol)'))';
    layerThick      = num2cell(cellfun(@(v)v(3),in_per(i,8:ncol)'))';
    rho             = num2cell(cellfun(@(v)v(4),in_per(i,8:ncol)'))';
    refShearModul   = num2cell(cellfun(@(v)v(5),in_per(i,8:ncol)'))';
    refBulkModul    = num2cell(cellfun(@(v)v(6),in_per(i,8:ncol)'))';
    uBulk           = num2cell(cellfun(@(v)v(7),in_per(i,8:ncol)'))';
    frictionAng     = num2cell(cellfun(@(v)v(8),in_per(i,8:ncol)'))';
    vPerm           = num2cell(cellfun(@(v)v(9),in_per(i,8:ncol)'))';
    hPerm           = num2cell(cellfun(@(v)v(10),in_per(i,8:ncol)'))';
    Vs              = num2cell(cellfun(@(v)v(11),in_per(i,8:ncol)'))';
    refPress        = num2cell(cellfun(@(v)v(12),in_per(i,8:ncol)'))';
    surf            = num2cell(cellfun(@(v)v(13),in_per(i,8:ncol)'))';
    e               = num2cell(cellfun(@(v)v(14),in_per(i,8:ncol)'))';
    PTAng           = num2cell(cellfun(@(v)v(15),in_per(i,8:ncol)'))';
    contrac1        = num2cell(cellfun(@(v)v(16),in_per(i,8:ncol)'))';
    contrac3        = num2cell(cellfun(@(v)v(17),in_per(i,8:ncol)'))';
    dilat1          = num2cell(cellfun(@(v)v(18),in_per(i,8:ncol)'))';
    dilat3          = num2cell(cellfun(@(v)v(19),in_per(i,8:ncol)'))';
    cohesion        = num2cell(cellfun(@(v)v(20),in_per(i,8:ncol)'))';
    
    
    sElemX      = in_per{i,1};
    waterTable  = in_per{i,2};
    damp        = in_per{i,3};
    rockDen     = in_per{i,4};
    rockVS      = in_per{i,5};
    motionDT    = in_per{i,6};
    motionStep  = in_per{i,7};
    
    
    vec_plot{i} = {tipo,grade,layerThick,sElemX};
    
    newMatFile(archivo,columna, graficos,tipo,sElemX,numLayers,motionStep,motionDT,...
    faconv,famp,grade,layerThick,rho,refShearModul,refBulkModul,uBulk,...
    frictionAng,e,vPerm,hPerm,Vs,waterTable,damp,rockDen,rockVS,contrac1,...
    contrac3,dilat1,dilat3,PTAng,cohesion,refPress,surf,pathmf,path_sis,...
    restricion,alphasp,alphamp,numerador,analisis,test,tol,iter,impresion,...
    sistema,algorit,coef,integrador,gamma,beta,restricion1,alphasp1,alphamp1,...
    numerador1,analisis1,test1,tol1,iter1,impresion1,sistema1,...
    algorit1,coef1,integrador1,gamma1,beta1)
    
end
% 

    save(strcat(path_post,'\colplotdat.mat'),'vec_plot')
    
    %guardar numero de permutaciones
    columna = nrow;
    
    % Almacenamiento de datos
    name_colum = {'columna'
                };   
    % 
    
    save(path_proj,name_colum{:},'-append')

end


