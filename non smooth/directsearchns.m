function [X, fval] = directsearchns(problem, Nmul, fval, M)
% algorithm
% initialize parameters
N = Nmul * problem.tspacedim;
alpha = problem.alpha_epsilon;
ctest = 1;
thetaa = 0.95;
thetaexp = 0.5;
% if problem.num == 2
%     ctest = 0.12;
%     thetaa = 0.92;
%     thetaexp = 0.1;    
% end
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
    while  fcalls < N
        H = randomelgenerator(problem, X, psobol, sobolj);
        sobolj = sobolj + 1;
        %Emat = Emat;
        Xt = problem.M.retr(X, H, alpha);
        fcalls = fcalls + 1;
        ft = problem.cost(Xt);
        fval(fcalls) = ft;
        if ft < fbest - ctest*(alpha^2)
            X = Xt;
            fbest = ft;
            alpha = alpha/thetaexp;
        else
            alpha = alpha * thetaa;
        end
        if fcalls >= N
            break
        end
    end
end

end