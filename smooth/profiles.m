% specify the savefolder variable where to save the profiles
% for smooth problems:
% solver 1: zeroth order
% solver 2: direct search
% solver 3: extrapolation
% for non smooth problems
% solver 1: direct search
% solver 2: direct search with extrapolation
startset = [2, 7, 12, 2];
endset = [6, 11, 16, 16]; 
tolset = [1,3]; % negative logs of tolerance parameter
save_folder = '';
for js=1:length(startset)
    for is=1:length(tolset)
        start = startset(js);
        endj = endset(js);
        tol = tolset(is);
        filename = strcat('testresultshs164', string(start), string(endj));
        load(filename, 'problemvec', 'resultcell', 'dimvec');
        [a, b] = size(resultcell);
        maxiter = 100 * max(dimvec);
        H = zeros(maxiter, a, b);
        H(:) = Inf;
        N = dimvec;
        gate = 10^(-tol);
        filename = strcat(save_folder, filename, string(tol));
        for j = 1:a
            for i = 1:b
                fvalv = resultcell(j, i);
                fvalv = fvalv{1};
                H(1:length(fvalv), j, i) = fvalv;
            end
        end
        hl = data_profile(H,N,gate);
        if (tol==1) && (start==2)
            legend('ZO-RGD', 'RDS-SB', 'RDSE-SB', 'FontSize',14, 'Location', 'southeast')
        end
        saveas(gca, strcat(filename, 'dp'), 'epsc');
        close;
        hs = perf_profile(H, gate, 0);
        saveas(gca, strcat(filename, 'pp'), 'epsc');
        close;
    end
end
