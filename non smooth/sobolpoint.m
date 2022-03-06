function p = sobolpoint(problem, j)
    if problem.num == 1
        p = sobolset(problem.n, 'leap', j);
    elseif problem.num == 2
        p = sobolset(problem.n * problem.m, 'leap', j);
     end
end