function plotAsis(path_sis,dt,faconv,amplif)
% Mostrar registro de aceleraciones s�smicas
    sismo = load(path_sis);
       
    [t,a] = formatAsis(dt,faconv,amplif,sismo);
    
    plot(t,a)
end