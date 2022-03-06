function [X, fval, M] = directsearchext(problem, Nmul)
%algorithm
% initialize parameters
tspacedim = problem.tspacedim;
N = Nmul * problem.tspacedim; 
alpha = 1;
ctest = 0.77;
thetaa = 0.61;
thetaexp = 0.99;
alpha_eps = problem.alpha_epsilon;
fval = zeros(1, N);
Es = ebasisgenerator(problem);
X = problem.xstart;
fcalls = 0;
while fcalls < N  %
    if fcalls == 0
        fcalls = fcalls + 1;
        fbest = problem.cost(X);
        fval(fcalls) = fbest;
    end
    h = 1;
    foundone = 0;
    while h <= tspacedim && fcalls < N
        hdir = 1;
        while hdir < 3
            H = Es{h};
            if hdir == 1
                Emat = problem.M.proj(X, H);
            else
                Emat = supermulti(X, -1, Emat, problem);
            end
            %Emat = Emat;
            Xt = problem.M.retr(X, Emat, alpha);
            fcalls = fcalls + 1;
            ft = problem.cost(Xt);
            fval(fcalls) = ft;
            if ft < fbest - ctest*(alpha^2)
                X = Xt;
                fbest = ft;
                hdir = 3;
                alpha = alpha/thetaexp;
                foundone = 1;
            else
                hdir = hdir + 1;
            end
            if fcalls >= N
                break
            end
        end
    h = h + 1;  
    if foundone == 1
        break
    end
    end
    if foundone == 0
        alpha = alpha * thetaa;
    end
    if alpha < alpha_eps
        M = fcalls;
        break
    end
end
if fcalls == N
    M = N;
end
end