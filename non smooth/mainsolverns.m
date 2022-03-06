function [Xz, fvalzo, Xd, fvald, Xls, fvalr, pdim] = mainsolverns(problem, N, rngs)
% algorithm 1: zeroth order method
% algorithm 2: non smooth direct search
% algorithm 3: non smooth direct search with line search extrapolation
rng(rngs);
if problem.num == 1
    n = problem.n;
    l = problem.l;
    problem.p = 1;
    problem.k = 1;
    manifold = spherefactory(n);
    % initialize problem parameters
    % define the problem
    ln = max([l, n]);
    Qin = randn(ln, ln);
    [S, V, D] = svd(Qin);
    Q = S(1:l, 1:n);
    problem.M = manifold;
    Xstart = manifold.rand();
    problem.tspacedim = n;
    problem.cost = @(X) sum(abs(Q*X));
    problem.xstart = Xstart;
elseif problem.num == 2
    density = problem.density;
    k = problem.r;
    m = problem.n;
    n = problem.m;
    M = fixedrankembeddedfactory(m, n, k);
    R = full(sprand(m,n, density));
    R = (R > 0);
    Y = randn(m, n);
    Y = Y.*R;
    % initialize problem parameters
    Xstart = M.rand();
    % define the problem
    problem.M = M;
    problem.n = m;
    problem.p = n;
    problem.k = 1;
    problem.Y = Y;
    problem.tspacedim = problem.n * problem.p;
    problem.xstart = Xstart;
    problem.cost = @(X) sum(abs(Y - (X.U * X.S * X.V').*R), 'all');     
else
    print('undefined problem!')
end
[Xz, fvalzo] = zerothorderR(problem, N);
[Xd, fvald] = directsearchnstrick(problem, N);    
[Xls, fvalr] = linesearchextnstrick(problem, N);
pdim = problem.tspacedim;
end