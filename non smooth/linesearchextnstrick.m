function [Xls, fvalr] = linesearchextnstrick(problem, N)
    [Xls, fvalr, M] = linesearchext(problem, N);
    problem.xstart = Xls;
    [Xls, fvalr] = linesearchextns(problem, N, fvalr, M);
end