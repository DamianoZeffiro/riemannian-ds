function [X, fval] = linesearchext(problem, Nmul)
%algorithm
% initialize parameters
tspacedim = problem.tspacedim;
N = Nmul * problem.tspacedim; 
alphae = ones(tspacedim, 2);
ctest = 0.11;
thetaa = 0.81;
thetaexp = 0.32;
fval = zeros(1, N);
if ismember(problem.num, [3, 4, 6])
    Es = ebasisgenerator2(problem);
elseif ismember(problem.num, [1, 2, 5, 7])
    Es = ebasisgenerator(problem);
elseif ismember(problem.num, [8])
    Es = ebasisgeneratorGM(problem);
end
X = problem.xstart;
fcalls = 0;
while fcalls < N  %
    if fcalls == 0
        fcalls = fcalls + 1;
        fbest = problem.cost(X);
        fval(fcalls) = fbest;
    end
    h = 1;
    while h <= tspacedim && fcalls < N
        hdir = 1;
        while hdir < 3
            H = Es{h};
            if hdir == 1
                Emat = problem.M.proj(X, H);
                alphain = 1;
            else
                Emat = supermulti(X, -1, Emat, problem);
            end
            %Emat = Emat;
            Xt = problem.M.retr(X, Emat, alphae(h,alphain));
            fcalls = fcalls + 1;
            ft = problem.cost(Xt);
            fval(fcalls) = ft;
            if ft < fbest - ctest*(alphae(h,alphain)^2)
                keepgo = 1;
                fttprev = ft;
                while keepgo && fcalls < N
                    alphae(h,alphain) = alphae(h,alphain)/thetaexp;
                    Xtt = problem.M.retr(X, Emat, alphae(h,alphain));
                    fcalls = fcalls + 1;
                    ftt = problem.cost(Xtt);
                    fval(fcalls) = ftt;
                    if ftt >= fbest - ctest*(alphae(h,alphain)^2) || ftt >= fttprev
                        alphae(h,alphain) = alphae(h,alphain) * thetaexp;
                        keepgo = 0;
                    else
                        fttprev = ftt;
                    end
                end
                X = problem.M.retr(X, Emat, alphae(h,alphain));
                hdir = 3;
                fbest = fval(fcalls - 1); %offset because last evaluation is always unsuccesfull
                continue
            else
                alphae(h, alphain) = thetaa * alphae(h, alphain);
                hdir = hdir + 1;
            end
            if fcalls >= N
                break
            end
        end
    h = h + 1;    
    end
end
end