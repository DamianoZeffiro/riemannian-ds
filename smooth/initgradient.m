function gx = initgradient(X, problem)
if ismember(problem.num, [7])
    gx = problem.M.proj(X, zeros(problem.n, problem.p));
elseif ismember(problem.num, [1, 2, 5]) && problem.k == 1
    gx = zeros(problem.n, problem.p);
elseif ismember(problem.num, [1,2, 5]) && problem.k > 1
    gx = zeros(problem.n, problem.p);
elseif ismember(problem.num, [8])
    gx.S = cell(problem.k, 1);
    gx.alpha = zeros(problem.k, 1);
    for j = 1:problem.k
        gx.S{j} = zeros(problem.n);
    end
elseif ismember(problem.num, [3,4,6])
    gx.M1 = zeros(problem.n1, problem.p1);
    gx.M2 = zeros(problem.n2, problem.p2);
end
end