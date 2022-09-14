function list = numListStr(n,prefig)

    el = 1:n;

    list = cell(n,1);

    for i = 1:n
       list{i,1} = horzcat(prefig,num2str(el(i)));
    end
end