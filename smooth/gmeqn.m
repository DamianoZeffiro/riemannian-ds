function q = gmeqn(S, alpha, Y)
    n = size(Y, 1);
    k = size(S);
    k = k(1);
    detSvec = zeros(k, 1);
    for i = 1:k
        detSvec(i) = det(S{i});
    end
    q = 0;
    for i = 1:n
        p = 0;
        for j = 1:k
            p = p + alpha(j) * exp(- 0.5 * Y(:, i)' * S{j} * Y(:, i)) * detSvec(j)^0.5;
        end
        p = log(p);
        q = q + p;
    end
    q = - q;
end