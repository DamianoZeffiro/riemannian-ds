function a = xlsinstancecreator(first, last, pvec)
tot = last - first  + 1;
nump = size(pvec, 2);
a = cell(nump * tot, 1);
sheetname = 'experiments_sizes.xlsx';
sizevec = [5, 3, 4, 8, 4, 5, 5, 5];
currnum = 1;
for h = 1:nump
    j = pvec(h);
    sj = sizevec(j);
    v = zeros(tot, sj);
    v(:, 1) = j;
    rangev = 2:sj;
    rangeread = strcat('A', num2str(first), ':', char('A' + sj - 2), num2str(last));
    v(:, rangev) = xlsread(sheetname, strcat('p', num2str(j)),  rangeread);
    for l = currnum:currnum + tot - 1
        a{l} = v(l - currnum + 1, :);
    end
    currnum = currnum + tot;
end
end