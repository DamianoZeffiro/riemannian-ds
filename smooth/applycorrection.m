function X = applycorrection(X)
    [maxval, I] = max(X.alpha);
    if maxval > 1 - 10^(-8)
        X.alpha(I) = 1 - 10^(-8);
        X.alpha(rem(I, 2) + 1) = 10^(-8);
    end  
end