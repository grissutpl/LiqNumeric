function [t,a] = formatAsis(motionDT,faconv,amplif,sismo)

%     sismo = load('sismo-Ejemplo-Base-2.txt');
%     dT = 0.01;
%     faconv = 9.81;
%     amplif = 1;
    
    % Determinar dimensiones del registro sísmico
    [nf,nc] = size(sismo);
    
    % Vector de aceleraciones sísmicas.
    % Nota: Vector con dimensiones nf*nc filas y 1 columna
    
    a = zeros(nf*nc,1);
    
    tic
    for i = 1:nf
       inc = i*nc-nc+1;
       a(inc:i*nc,1) = sismo(i,1:nc);
    end
    toc

    a = a*faconv*amplif;
    t = linspace(0,motionDT*nf*nc,nf*nc);
    