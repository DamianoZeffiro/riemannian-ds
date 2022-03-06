function Mres = supermulti(X, alpha1, Mt1, problem)
if ismember(problem.num, [1])
    Mres = alpha1 * Mt1;
elseif ismember(problem.num, [2])
    Mres = problem.M.lincomb(X, alpha1, Mt1);
end
end