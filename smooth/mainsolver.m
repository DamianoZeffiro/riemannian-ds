function [Xz, fvalzo, Xd, fvald, Xls, fvalr, pdim] = mainsolver(problem, N, rngs)
rng(rngs);
if problem.num == 1
    n = problem.n;
    p = problem.p;
    l = problem.l;
    manifold = stiefelfactory(n, p);
    manifold.retr = manifold.retr_polar;
    % initialize problem parameters
    A = randn(l, n);
    X0 = randn(n, p);
    X0 = orth(X0);
    E = zeros(l, p);
    B = A * X0 + E;
    Xstart = randn(n, p);
    P = manifold.proj(X0, Xstart);
    Xstart = manifold.retr(X0, P, 1);
    % define the problem
    problem.M = manifold;
    problem.k = 1;
    problem.tspacedim = n * p;
    problem.solution = orth(X0);
    problem.cost = @(X) (norm(A*X - B, 'fro'))^2;
    problem.egrad = @(X) 2 * A.'*(A*X - B);
    problem.xstart = Xstart;
elseif problem.num == 2
    n = problem.n;
    p = 1;
    k = 1;
    manifold = spherefactory(n);
    % initialize problem parameters
    A = randn(n);
    A = (A + A')/2;
    lambdamin = min(eig(A));
    Xstart = randn(n, 1);
    Xstart = Xstart/norm(Xstart, 2);
    % define the problem
    problem.M = manifold;
    problem.p = p;
    problem.k = k;
    problem.tspacedim = n * p * k;
    problem.xstart = Xstart;
    problem.cost = @(X) X'*(A*X) - lambdamin;
%    problem.egrad = @(X) 2 * A * X;
elseif problem.num == 3
    n1 = problem.n1;
    n2 = problem.n2;
    a.M1 = spherefactory(n1);
    a.M2 = spherefactory(n2);
    M = productmanifold(a);
    A = randn(n1, n2);
    lambdamax = max(svds(A));
    Xstart = M.rand();
    % define the problem
    problem.M = M;
    problem.p1 = 1;
    problem.k1 = 1;
    problem.p2 = 1;
    problem.k2 = 1;
    problem.K = problem.n1 + problem.n2;
    problem.xstart = Xstart;
    problem.tspacedim = n1 + n2;
    problem.cost = @(X) X.M1'*(A*X.M2) + lambdamax;
    problem.egrad = @(X) struct('M1', A * X.M2, 'M2', A' * X.M1);
elseif problem.num == 4
    n1 = problem.d;
    p1 = problem.n;
    n2 = problem.n;
    p2 = problem.k;
    epsilon = problem.epsilon;
    lambda = problem.lambda;
    density = problem.density;
    a.M1 = obliquefactory(n1, p1);
    a.M2 = euclideanfactory(n2, p2);
    M = productmanifold(a);
    % initialize problem parameters
    Xstart = M.rand();
    X0 = M.rand();
    D0 = X0.M1;
    C0 = full(sprand(n2, p2, density));
    Y = D0 * C0;
    % define the problem
    problem.M = M;
    problem.n1 = n1;
    problem.p1 = p1;
    problem.k1 = 1;
    problem.n2 = n2;
    problem.p2 = p2;
    problem.k2 = 1;
    problem.tspacedim = problem.n1 * problem.p1 + problem.n2 * problem.p2;
    problem.xstart = Xstart;
    problem.cost = @(X) norm(Y - X.M1 * X.M2, 'fro')^2 + lambda * sum(sqrt(X.M2.^2 + epsilon^2),'all') - lambda * sum(sqrt(C0.^2 + epsilon^2),'all');
    %    problem.egrad = @(X) struct('M1', 2 * X.M1, 'M2', 2 * X.M2);
elseif problem.num == 5
    n = problem.n;
    p = 2;
    M = rotationsfactory(n, p);
    % initialize problem parameters
    R = M.rand();
    R1 = R(:,:,1);
    R2 = R(:,:,2);
    noisec = problem.noisec;
    H12 = R1 * R2' + noisec * randn(n);
    Xstart = M.rand();
    % define the problem
    problem.M = M;
    problem.n = n;
    problem.p = n;
    problem.k = p;
    problem.tspacedim = n * n * p;
    problem.solution = R;
    problem.cost = @(X) (norm(X(:, :, 1) - H12 * X(:, :, 2), 'fro'))^2;
    problem.xstart = Xstart;
elseif problem.num == 6
    n = problem.n;
    r = problem.r;
    m = problem.m;
    a.M1 = stiefelfactory(n, r);
    a.M2 = stiefelfactory(m, r );
    M = productmanifold(a);
    % initialize problem parameters
    A = randn(n, m);
    svdarray = svd(A);
    sums = sum(svdarray(1:r));
    Xstart = M.rand();
    % define the problem
    problem.M = M;
    problem.n1 = n;
    problem.p1 = r;
    problem.k1 = 1;
    problem.n2 = m;
    problem.p2 = r;
    problem.k2 = 1;
    problem.tspacedim = problem.n1 * problem.p1 + problem.n2 * problem.p2;
    problem.xstart = Xstart;
    problem.cost = @(X) trace(X.M1'*(A*X.M2)) + sums;
elseif problem.num == 7
    density = 0.1;
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
    problem.tspacedim = problem.n * problem.p;
    problem.xstart = Xstart;
    problem.cost = @(X) norm(Y - (X.U * X.S * X.V').*R, 'fro')^2; 
elseif problem.num == 8
    n = problem.n;
    d = problem.d;
    snum = 2;
    Y1 = randn(n, d);
    cost = randn();
    A = randn(n, n);
    Y2 = A * randn(n, d) + cost;
    alphaM = rand(1, d);
    alphasol = problem.alpha;
    Y = Y1 .* (ones(n, 1) * (alphaM > alphasol)) + Y2.*(ones(n, 1) * (alphaM <= alphasol));
    Y(n, :) = ones(1, d); % augmented datapoints
    baseM = sympositivedefinitefactory(n); 
    S = powermanifold(baseM, snum);
    alpha = multinomialfactory(snum, 1);
    Nm.S = S;
    Nm.alpha = alpha;
    M = productmanifold(Nm);
    Xstart = M.rand();
    problem.M = M;
    problem.snum = snum;
    problem.p = n;
    problem.k = snum;
    problem.Y = Y;
    problem.tspacedim = problem.n * problem.n * problem.k + problem.k;
    problem.xstart = Xstart;
    problem.cost = @(X) gmeqn(X.S, X.alpha, Y);    
else
    print('undefined problem!')
end
[Xz, fvalzo] = zerothorderR(problem, N);
[Xd, fvald] = directsearchext(problem, N);    
[Xls, fvalr] = linesearchext(problem, N);
pdim = problem.tspacedim;
end