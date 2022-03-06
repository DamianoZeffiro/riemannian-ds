function [Xd, fvald] = directsearchnstrick(problem, N)
    [Xd, fvald, M] = directsearchext(problem, N);
    problem.xstart = Xd;
    [Xd, fvald] = directsearchns(problem, N, fvald, M);
end