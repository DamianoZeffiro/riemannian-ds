function main(first, last, N)
% algorithm 1: zeroth order
% algorithm 2: direct search
% algorithm 3: line search extrapolation
% first coordinate is instance number, second is algorithm
problemvec = [];
dimvec = [];
resultcell = cell((last - first + 1) * 8, 3);
pvec = 1:8;
a = xlsinstancecreator(first, last, pvec);
filename = strcat('testresultshs164', num2str(first), num2str(last));
save(filename, 'problemvec', 'resultcell', 'dimvec');
numproblems = size(a, 1);
% see "An introduction to optimization on smooth manifolds" for detailed
% definitions of the problems, except for problem 1 in the notes.
% every problem requires the random seed generator in input
% Problem 1: Procustes. (see notes). size(A) = [l, n], size(X) = [n, p].
% parameters: (l, n, p)
% Problem 2: maximum eigenvalue. size(A) = [n, n]. parameters: (n)
% Problem 3: top singular value. size(A) = [n1, n2]. parameters: (n1, n2)
% Problem 4: dictionary learning. size(D) = [d, n], size(C) = [n, k],
% lambda = reg. coefficient. density = probability of non zero component in
% the solution, epsilon  = regularization coefficient
% parameters (d, n, k, lambda, density, epsilon)
% Problem 5: size(Ri) = [n, n], number of matrices p is fixed for now,
% noisec = noise coefficient for the solution
% parameters: (n, noisec)
% Problem 6: top r singular vectors. size(U) = [m, r], size(V) = [n, r]
% parameters: (m, r, n)
% Problem 7: low rank matrix completion. size(X) = [n, m], density =
% probability of a non zero component in the solution. r = rank 
% parameters: (n, m, r)
% Problem 8: Gaussian mixture, 2 components. d = number of datapoints, n =
% dimension, alpha = coefficient for the first component
% parameters: (d, n, alpha)
for i = 1:numproblems
   load(filename, 'problemvec', 'resultcell', 'dimvec');
   pcur = a{i};
   rngs = pcur(end);
if pcur(1) == 1    
   problem.num = pcur(1);
   problem.l = pcur(2);
   problem.n = pcur(3);
   problem.p = pcur(4);
   name = strcat("p", num2str(problem.num), "_l", num2str(problem.l), "_n", num2str(problem.n) , "_p", num2str(problem.p), "_rng", num2str(rngs)); 
elseif pcur(1) == 2
    problem.num = pcur(1);
    problem.n = pcur(2);
    name = strcat("p", num2str(problem.num), "_n", num2str(problem.n) , "_rng", num2str(rngs)); 
elseif pcur(1) == 3
    problem.num = pcur(1);
    problem.n1 = pcur(2);
    problem.n2 = pcur(3);
    name = strcat("p", num2str(problem.num), "_n1", num2str(problem.n1), "_n2", num2str(problem.n2), "_rng", num2str(rngs)); 
elseif pcur(1) == 4
    problem.num = pcur(1);
    problem.d = pcur(2);
    problem.n = pcur(3);
    problem.k = pcur(4);
    problem.lambda = pcur(5);
    problem.density = pcur(6);
    problem.epsilon = pcur(7);
    name = strcat("p", num2str(problem.num), "_d", num2str(problem.d) , "_n", num2str(problem.n), "_k", num2str(problem.k), "_lambda", num2str(problem.lambda), "_density", num2str(problem.density), "_epsilon", num2str(problem.epsilon), "_rng", num2str(rngs)); 
elseif pcur(1) == 5   
    problem.num = pcur(1);
    problem.n = pcur(2);
    problem.noisec = pcur(3);
    name = strcat("p", num2str(problem.num), "_n", num2str(problem.n) , "_noisec", num2str(problem.noisec), "_rng", num2str(rngs)); 
elseif pcur(1) == 6
    problem.num = pcur(1);
    problem.m = pcur(2);
    problem.r = pcur(3);
    problem.n = pcur(4);
    name = strcat("p", num2str(problem.num), "_m", num2str(problem.m) , "_r", num2str(problem.r), "_n", num2str(problem.n), "_rng", num2str(rngs)); 
elseif pcur(1) == 7
    problem.num = pcur(1);
    problem.n = pcur(2);
    problem.m = pcur(3);
    problem.density = pcur(4);
    problem.r = pcur(5);
    name = strcat("p", num2str(problem.num), "_n", num2str(problem.n) , "_m", num2str(problem.m), "_density", num2str(problem.density), "_r", num2str(problem.r), "_rng", num2str(rngs)); 
elseif pcur(1) == 8
    problem.num = pcur(1);
    problem.d = pcur(2);
    problem.n = pcur(3);
    problem.alpha = pcur(4);
    name = strcat("p", num2str(problem.num), "_d", num2str(problem.d) , "_n", num2str(problem.n), "_alpha", num2str(problem.alpha), "_rng", num2str(rngs)); 
end
% output: final point and function evaluation vector 
% input: problem, function evaluations as multiple of problem dimension,
% random seed
[Xz, fvalzo, Xd, fvald, Xls, fvalr, pdim] = mainsolver(problem, N, rngs);
problemvec = [problemvec, name]; 
dimvec = [dimvec, pdim];
i1 = length(problemvec);
resultcell{i1, 1} = fvalzo;
resultcell{i1, 2} = fvald;
resultcell{i1, 3} = fvalr;
save(filename, 'problemvec', 'resultcell', 'dimvec');
% if ismember(problem.num, [1, 2, 3, 4, 5, 6, 7])
% figure;
% semilogy(fvalr, 'g-.x'); hold on
% semilogy(fvalzo, 'y-.x');
% semilogy(fvald, 'r-.x');
% title('function value');
% elseif ismember(problem.num, [8])
%     figure;
%     plot(fvalr, 'g-.x'); hold on
%     plot(fvalzo, 'y-.x');
%     plot(fvald, 'r-.x');
%     title('function value');    
% end
clear problem;
end
end

