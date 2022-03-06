function Es = ebasisgenerator2(problem)
tspacedim = problem.n1 * problem.p1 * problem.k1 + problem.n2 * problem.p2 * problem.k2;
k1 = problem.k1;
n1 = problem.n1;
p1 = problem.p1;
k2 = problem.k2;
n2 = problem.n2;
p2 = problem.p2;
Es = cell(tspacedim, 1);
h = 1;
if k1 == 1 && k2 == 1
    for i=1:n1
        for j = 1:p1
            eijmat = zeros(n1, p1);
            eijmat(i, j) = 1;
            curv.M1 = eijmat;
            curv.M2 = zeros(n2, p2);
            Es{h} = curv;
            h = h + 1;
        end
    end
    for i=1:n2
        for j = 1:p2
            eijmat = zeros(n2, p2);
            eijmat(i, j) = 1;
            curv.M2 = eijmat;
            curv.M1 = zeros(n1, p1);
            Es{h} = curv;
            h = h + 1;
        end
    end
else
    for i=1:n1
        for j = 1:p1
            for l = 1:k1
                eijmat = zeros(n1, p1, k1);
                eijmat(i, j, l) = 1;
                curv.M1 = eijmat;
                curv.M2 = zeros(n2, p2, k2);
                Es{h} = curv;
                h = h + 1;
            end
        end
    end
    for i=1:n2
        for j = 1:p2
            for l = 1:k2
                eijmat = zeros(n2, p2, k2);
                eijmat(i, j, l) = 1;
                curv.M1 = zeros(n1, p1, k1);
                curv.M2 = eijmat;
                Es{h} = curv;
                h = h + 1;
            end
        end
    end
end