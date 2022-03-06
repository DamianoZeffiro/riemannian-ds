function [X, fval] = zerothorderR(problem, Nmul)
%algorithm
% initialize parameters
hs = 1.64/(problem.tspacedim); % step-size
N = problem.tspacedim * Nmul;
K = problem.tspacedim;
mu = 1e-8; % mu <= epsilon^2/n^(3/2)
fval = zeros(1, N);
fcalls = 0;
X = problem.xstart;
while fcalls < N
j = 0;
gx = initgradient(X, problem);
fcalls = fcalls + 1;
fcurr = problem.cost(X);
fval(fcalls) = fcurr;
while j < K && fcalls < N
    fcalls = fcalls + 1;
    j = j + 1;
    u = ambientinit(problem);
    temp = problem.M.proj(X, u);
    fretr = problem.cost(problem.M.retr(X, temp, mu)); 
    gx = superlincomb(X, 1, gx, (fretr - fcurr)/mu, temp, problem);
    fval(fcalls) = fretr;
end
if j == K
    gx = supermulti(X, 1/K, gx, problem);
    X = problem.M.retr(X, gx, -hs);
    if ismember(problem.num, [8])
        X = applycorrection(X);
    end  
end
end
end