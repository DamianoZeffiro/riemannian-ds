function mainns(first, last, N)
% problem 1: sparsest vector in a subspace. size(Q) = [l, n]
% problem 2: nonsmooth low-rank matrix completion. size(X) = [m, n], rank =
% r, solution denisty = density
% resultcell(i, j) = result on instance i for algorithm j
% list of problem names
problemvec = [];
dimvec = [];
numprob = 2;
resultcell = cell((last - first + 1) * numprob, 2);
pvec = 1:numprob;
a = xlsinstancecreatorns(first, last, pvec);
filename = strcat('testresultsns', num2str(first), num2str(last));
save(filename, 'problemvec', 'resultcell', 'dimvec');
numproblems = size(a, 1);
for i = 1:numproblems
    load(filename, 'problemvec', 'resultcell', 'dimvec');
    pcur = a{i};
    rngs = pcur(end);
    problem.alpha_epsilon_ls = 0.0001;
    problem.alpha_epsilon = 0.0001;
    if pcur(1) == 1 
        problem.num = pcur(1);
        problem.l = pcur(2);
        problem.n = pcur(3);
        name = strcat("pns", num2str(problem.num), "_l", num2str(problem.l), "_n", num2str(problem.n), "_rng", num2str(rngs));
    elseif pcur(1) == 2 
        problem.num = pcur(1);
        problem.n = pcur(2);
        problem.m = pcur(3);
        problem.density = pcur(4);
        problem.r = pcur(5);
        name = strcat("pns", num2str(problem.num), "_n", num2str(problem.n) , "_m", num2str(problem.m), "_density", num2str(problem.density), "_r", num2str(problem.r), "_rng", num2str(rngs));
    end
    % output: final point and function evaluation vector
    % input: problem, function evaluations limit as multiple of problem dimension,
    % random seed
    [Xz, fvalz, Xd, fvald, Xls, fvalr, pdim] = mainsolverns(problem, N, rngs);
    problemvec = [problemvec, name];
    dimvec = [dimvec, pdim];
    i1 = length(problemvec);
    resultcell{i1, 1} = fvalz;
    resultcell{i1, 2} = fvald;
    resultcell{i1, 3} = fvalr;
    save(filename, 'problemvec', 'resultcell', 'dimvec');
    clear problem;
end
end
