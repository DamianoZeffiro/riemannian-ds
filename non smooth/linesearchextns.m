function [X, fval] = linesearchextns(problem, Nmul, fvalr, M)
%algorithm
% initialize parameters
N = Nmul * problem.tspacedim;
alphae = problem.alpha_epsilon_ls;
ctest = 1;
thetaa = 0.95;
thetaexp = 0.5;
% if problem.num == 2
%     ctest = 1;
%     thetaa = 0.99;
%     thetaexp = 0.8;    
% end
fval = fvalr;
X = problem.xstart;
fcalls = M;
js = 1;
psobol = sobolpoint(problem, js);
sobolj = 1000;
while fcalls < N  %
    if fcalls == M
        fcalls = fcalls + 1;
        fbest = problem.cost(X);
        fval(fcalls) = fbest;
    end
    while fcalls < N        
        %Emat = Emat;
        Emat = randomelgenerator(problem, X, psobol, sobolj);
        sobolj = sobolj + 1;
        Xt = problem.M.retr(X, Emat, alphae);
        fcalls = fcalls + 1;
        ft = problem.cost(Xt);
        fval(fcalls) = ft;
        if ft < fbest - ctest*(alphae^2)
            keepgo = 1;
            fttprev = ft;
            while keepgo && fcalls < N
                alphae = alphae/thetaexp;
                Xtt = problem.M.retr(X, Emat, alphae);
                fcalls = fcalls + 1;
                ftt = problem.cost(Xtt);
                fval(fcalls) = ftt;
                if ftt >= fbest - ctest*alphae^2 || ftt >= fttprev
                    alphae = alphae * thetaexp;
                    keepgo = 0;
                else
                    fttprev = ftt;
                end
            end
            X = problem.M.retr(X, Emat, alphae);
            fbest = fval(fcalls - 1); %offset because last evaluation is always unsuccesfull
            continue
        else
            alphae = thetaa * alphae;
        end
        if fcalls >= N
            break
        end
    end
end
end