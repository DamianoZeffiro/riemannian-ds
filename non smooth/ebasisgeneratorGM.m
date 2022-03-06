function Es = ebasisgeneratorGM(problem)
n = problem.n;
k = problem.k;
tspacedim = problem.n * problem.n * problem.k + problem.k;
Es = cell(tspacedim, 1);
h = 1;
basecell = cell(k, 1);
for j = 1:k
    basecell{j} = zeros(n);
end
for i = 1:n
    for j = 1:n
        for l = 1:k
            a.S = basecell;
            a.S{k}(i, j) = 1;
            a.alpha = zeros(k, 1);
            Es{h} = a;
            h = h + 1;
        end
    end
end
for i = 1:k
    a.alpha = zeros(k, 1);
    a.alpha(i) = 1;
    Es{h} = a;
    h = h + 1;
end