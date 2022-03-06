% specify the save_folder variable where to save the profiles
% data and performance profiles for non smooth problems
% solver 1: direct search
% solver 2: direct search with extrapolation
startset = [17, 22, 27, 17];
endset = [21, 26, 31, 31];
tolset = [1,3];
save_folder = '';
for js = 1:length(startset)
    for is = 1:length(tolset)
        start = startset(js);
        ends = endset(js);
        tol = tolset(is);
        filename = strcat('testresultsns', string(start), string(ends));
        load(filename, 'problemvec', 'resultcell', 'dimvec');
        [a, b] = size(resultcell);
        maxiter = 100 * max(dimvec);
        H = zeros(maxiter, a, b);
        H(:) = Inf;
        N = dimvec;
        gate = 10^(-tol);
        for j = 1:a
            for i = 1:b
                fvalv = resultcell(j, i);
                fvalv = fvalv{1};
                H(1:length(fvalv), j, i) = fvalv;
            end
        end
        hl = data_profile(H,N,gate);
        if (start == 17) && (tol == 1)
            legend('ZO-RGD', 'RDS-DD+','RDSE-DD+', 'FontSize',14, 'Location', 'southeast')
        end
        saveas(gca, strcat(save_folder, filename, string(tol), 'dp'), 'epsc');
        close;
        hs = perf_profile(H, gate, 0);
        saveas(gca, strcat(save_folder, filename, string(tol), 'pp'), 'epsc');
        close;
    end
end