function sign_eps = sign_eps(x, par)
sign_eps = zeros(1,length(x));

for ii = 1:length(x)    % loop through all elements of the vector
    if x(ii) >= par.epsilon
        sign_eps(ii) = 1;
    elseif x(ii) <= -par.epsilon
        sign_eps(ii) = -1;
    else
        sign_eps(ii) = x(ii) / par.epsilon;
    end
 end
end