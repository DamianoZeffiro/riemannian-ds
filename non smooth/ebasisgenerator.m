function Es = ebasisgenerator(problem) 
tspacedim = problem.n * problem.p * problem.k;
k = problem.k;
n = problem.n;
p = problem.p;
Es = cell(tspacedim, 1);
h = 1;
if k == 1
    for i=1:n
        for j = 1:p
            eijmat = zeros(n, p);
            eijmat(i, j) = 1;
            Es{h} = eijmat;
            h = h + 1;
        end
    end
else
    for i=1:n
        for j = 1:p
            for q = 1:k
                eijmat = zeros(n, p, k);
                eijmat(i, j, q) = 1;
                Es{h} = eijmat;
                h = h + 1;
            end
        end
    end
end
end