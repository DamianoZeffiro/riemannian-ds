% input instance sizes in experiments_sizes.xlsx
% in each batch of tests, rows between startset[j] and endset[j]
% are considered for each instance
startset = [2, 7, 12, 2];
endset = [6, 11, 16, 16];
N = 100; % maximum number of objective eval as multiple of dimension
for j = 1:length(startset)
    startj = startset(j);
    endj = endset(j);
    main(startj, endj, N);
end
    