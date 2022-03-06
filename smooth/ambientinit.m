function u = ambientinit(problem)
if ismember(problem.num, [1, 2, 5, 7])
    if problem.k == 1
        u = randn(problem.n, problem.p);
    else
        u = randn(problem.n, problem.p, problem.k);
    end    
elseif ismember(problem.num, [8])
    u.S = cell(problem.k, 1);
    u.alpha = randn(problem.k, 1);
    for j = 1:problem.k
        u.S{j} = randn(problem.n, problem.n);
    end
elseif ismember(problem.num, [3,4,6])
    u.M1 = randn(problem.n1, problem.p1);
    u.M2 = randn(problem.n2, problem.p2);
end    
end    