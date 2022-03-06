function a = instancecreator()
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
a = cell(8, 1);
% small  
a{1} = [1, 5, 15, 5, 1];
a{1} = [1, 5, 15, 5, 1];
% 
a{2} = [2, 6, 1]; 
a{3} = [3, 12, 20, 1];
a{4} = [4, 5, 15, 10, 0.01, 0.1, 0.001, 1];
a{5} = [5, 15, 0.01, 1];
a{6} = [6, 15, 3, 10, 1];
a{7} = [7, 15, 10, 0.1, 1];
a{8} = [8, 1000, 7, 0.3, 1];
end
