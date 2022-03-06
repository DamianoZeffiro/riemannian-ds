function Mres = superlincomb(X, alpha1, Mt1, alpha2, Mt2, problem)
if ismember(problem.num, [1, 2, 5])
    Mres = alpha1 * Mt1 + alpha2 * Mt2;
elseif ismember(problem.num, [7])
    Mres = problem.M.lincomb(X, alpha1, Mt1, alpha2, Mt2);
elseif ismember(problem.num, [8])
    Mres.alpha = alpha1 * Mt1.alpha + alpha2 * Mt2.alpha;
    Mres.S = cell(problem.k, 1);
    for i = 1:problem.k
        Mres.S{i} = alpha1 * Mt1.S{i} + alpha2 * Mt2.S{i};
    end
else
    Mres.M1 = alpha1 * Mt1.M1 + alpha2 * Mt2.M1;
    Mres.M2 = alpha1 * Mt1.M2 + alpha2 * Mt2.M2;
end
end