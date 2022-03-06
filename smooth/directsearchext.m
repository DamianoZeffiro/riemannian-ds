function [X, fval] = directsearchext(problem, Nmul)
%algorithm
% initialize parameters
tspacedim = problem.tspacedim;
N = Nmul * problem.tspacedim; 
alpha = 1;
ctest = 0.77;
thetaa = 0.61;
thetaexp = 1;
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
end
end