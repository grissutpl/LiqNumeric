function text = resumEst(iest)

    %% Ruta de almacenamiento
    
    if isdeployed
       path_file = strcat(ctfroot,'\mat\mfbi_001.mat'); 
    else
       path_file = strcat(pwd,'\mat\mfbi_001.mat'); 
    end
    
    path_file = load(path_file,'path_proj','p_idiom');
    path_proj = path_file.path_proj;
    p_idiom = path_file.p_idiom;

    if p_idiom == 1
        type1 = 'Arena';
        type2 = 'Arcilla';
        espesor = 'Espesor';
        pendiente = 'Pendiente';
    elseif p_idiom == 2
        type1 = 'Sand';
        type2 = 'Clay';
        espesor = 'Thickness';
        pendiente = 'Slope';
    end
    
%     % Obtener valores previamente almacenados
    dat_cpa = load(path_proj);
     
    tipo = dat_cpa.tipo{iest};
    disp(tipo)
        grade_str           = dat_cpa.grade_str{iest};
        layerThick_str      = dat_cpa.layerThick_str{iest};
        rho_str             = dat_cpa.rho_str{iest};
        refShearModul_str   = dat_cpa.refShearModul_str{iest};
        refBulkModul_str    = dat_cpa.refBulkModul_str{iest};
        uBulk_str           = dat_cpa.uBulk_str{iest};
        frictionAng_str     = dat_cpa.frictionAng_str{iest};
        vPerm_str           = dat_cpa.vPerm_str{iest};
        hPerm_str           = dat_cpa.hPerm_str{iest};
        Vs_str              = dat_cpa.Vs_str{iest};
        refPress_str        = dat_cpa.refPress_str{iest};
        surf_str            = dat_cpa.surf_str{iest};
        e_str               = dat_cpa.e_str{iest};
        contrac1_str        = dat_cpa.contrac1_str{iest};
        contrac3_str        = dat_cpa.contrac3_str{iest};
        dilat1_str          = dat_cpa.dilat1_str{iest};
        dilat3_str          = dat_cpa.dilat3_str{iest};
        PTAng_str           = dat_cpa.PTAng_str{iest};
        cohesion_str        = dat_cpa.cohesion_str{iest};

    if tipo == 1
        
        text = {'Material';...
                type1;...
                espesor;...
                layerThick_str;...
                pendiente;...
                grade_str;...
                'Rho';...
                rho_str;...
                'Gr(kPa)';...
                refShearModul_str;...
                'Br';...
                refBulkModul_str;...
                'Bc';...
                uBulk_str;...
                'f';...
                frictionAng_str;...
                'Vperm';...
                vPerm_str;...
                'Hperm';...
                hPerm_str;...
                'Vs';...
                Vs_str;...
                'refPress';...
                refPress_str;...
                'surf';...
                surf_str;...
                'e';...
                e_str;...
                'contrac1';...
                contrac1_str;...
                'contrac3';...
                contrac3_str;...
                'dilat1';...
                dilat1_str;...
                'dilat3';...
                dilat3_str;...
                'PTAng';...
                PTAng_str
                };
    elseif tipo == 2
        
        text = {'Material';...
                type2;...
                espesor;...
                layerThick_str;...
                pendiente;...
                grade_str;...
                'Rho';...
                rho_str;...
                'Gr(kPa)';...
                refShearModul_str;...
                'Br';...
                refBulkModul_str;...
                'Bc';...
                uBulk_str;...
                'f';...
                frictionAng_str;...
                'Vperm';...
                vPerm_str;...
                'Hperm';...
                hPerm_str;...
                'Vs';...
                Vs_str;...
                'refPress';...
                refPress_str;...
				'surf';...
                surf_str;...
                'cohesion';...
                cohesion_str
                };
    end   
end
