function motionStep = historialVel(path_projF,sismo,motionDT,faconv,amplif)

% pilas sismo no es una ruta / Comentario para freddy

%     sismo = load('sismo-Ejemplo-Base-2.txt');
%     motionDT = 0.01;
%     faconv = 9.81;
%     amplif = 1;
    
    % Determinar dimensiones del registro sísmico
    [nf,nc] = size(sismo);
    
    % Vector de aceleraciones sísmicas.
    % Nota: Vector con dimensiones nf*nc filas y 1 columna
    
    motionStep = nf*nc;
    
    a = zeros(motionStep,1);
    
%     tic
    for i = 1:nf
       inc = i*nc-nc+1;
       a(inc:i*nc,1) = sismo(i,1:nc);
    end
%     toc
    
    amod = a*faconv*amplif;
    v = cumtrapz(amod); % Integración numérica por trapecios papu
    v = motionDT*v;
    
    path = strcat(path_projF,'pre_proceso\velocityHistory.out');
    if isdeployed
       path_path = strcat(ctfroot,'\velocityHistory.out'); 
    else
       path_path = strcat(pwd,'\velocityHistory.out'); 
    end
    save(path_path,'v','-ascii')
    save(path,'v','-ascii')
    
%     cla
% hold on
%     
%     x = linspace(0,0.05*nf*nc,nc*nf);
%     
%     plot(x,v)