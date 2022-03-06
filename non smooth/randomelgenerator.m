function fr = randomelgenerator(problem, x, psobol, j)
    if problem.num == 1
        fr = psobol(j,:)' ;
        fr = fr/norm(fr);
        fr = problem.M.proj(x, fr);
        fr = fr/norm(fr);
    elseif problem.num == 2
        fr = psobol(j, :);
        fr = reshape(fr, problem.n, problem.m);
        fr = fr/norm(fr, 'fro');
        fr = problem.M.proj(x, fr);
        frambient = problem.M.tangent2ambient(x, fr);
        frR = frambient.U * frambient.S * frambient.V';
        fr = problem.M.lincomb(x, 1/norm(frR, 'fro'), fr);
    end
end