function u = Gradient(t, x, par)
% функция u_t в статье
if par.dim == 2
    R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);

    u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
else 
    R = par.mu * par.D * norm([x(2)]) + par.c0 + par.c1 * norm([x(1)]) + par.c2 * norm([x(2)]);

    u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
end

end

function sigma_est = sigma_est( t, x, par )
if par.dim == 2
    sigma_est = par.mu * grad_est(t, [x(1), x(3)], par) + [x(2), x(4)];
else
    sigma_est = par.mu * grad_est(t, [x(1)], par) + [x(2)];
end

end

function grad_est = grad_est( t, x, par )
if par.dim == 2
    grad_est = [5/4*(x(1) - 1), (x(2)+0.5)]; 
else
    grad_est = [5/4*(x(1) - 1)]; 
end

end

function y = loss( t, x )
if par.dim == 2
    y = 5/8 * (x(1) - 1)^2 + 0.5*(x(2) + 0.5)^2;
else
    y = 5/8 * (x(1) - 1)^2;
end

end

