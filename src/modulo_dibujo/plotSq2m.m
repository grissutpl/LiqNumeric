function plotSq2m(b,h,m1,m2,pos)
    
    % Cálculo de coordenadas de los nodos
    
    p1 = [-0.5*b,-0.5*b*m1]+pos;
    p2 = [0.5*b,0.5*b*m1]+pos;
    p3 = [0.5*b,h+0.5*b*m2]+pos;
    p4 = [-0.5*b,h-0.5*b*m2]+pos;
    
    mat_nod = [p1;p2;p3;p4;p1];
    plot(mat_nod(:,1),mat_nod(:,2))

    axis 'equal'

end