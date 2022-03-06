% input instance sizes in experiments_sizesns.xlsx
% in each batch of tests, rows between startset[j] and endset[j]
% are considered for each instance
startset = [17, 22, 27, 17];
endset = [21, 26, 31, 31];
N = 100; % maximum number of objective eval as multiple of dimension
for j = 1:length(startset)
    first = startset(j);
    last = endset(j);
    mainns(first, last, N);
end
