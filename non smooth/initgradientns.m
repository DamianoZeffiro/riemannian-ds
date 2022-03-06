function gx = initgradientns(X, problem)
if ismember(problem.num, [1])
    gx = zeros(problem.n, problem.p);
elseif ismember(problem.num, [2])
    gx = problem.M.proj(X, zeros(problem.n, problem.p));
end
end
