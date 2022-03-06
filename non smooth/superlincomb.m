function Mres = superlincomb(X, alpha1, Mt1, alpha2, Mt2, problem)
if ismember(problem.num, [1])
    Mres = alpha1 * Mt1 + alpha2 * Mt2;
elseif ismember(problem.num, [2])
    Mres = problem.M.lincomb(X, alpha1, Mt1, alpha2, Mt2);
end
end