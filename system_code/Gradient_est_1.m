function u = Gradient_est_1(t, x, par)
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
% % Позняк
if par.dim == 2
    xi_big = 1/12 * eye(2);
    xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
    x_1 = x(1) + par.alpha * xi_small(1);
    x_2 = x(2) + par.alpha * xi_small(2);
    grad_est = inv(xi_big) * par.alpha ^ (-1) * xi_small * loss(t, [x_1, x_2], par);
    grad_est = transpose(grad_est);
else
    xi_big = 1/12;
    xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(1,1);
    x_1 = x(1) + par.alpha * xi_small(1);
    grad_est = xi_big ^ (-1) * par.alpha ^ (-1) * xi_small * loss(t, [x_1], par);
    grad_est = transpose(grad_est);
end

end

function y = loss( t, x, par )
if par.dim == 2
    y = 5/8 * (x(1) - 1)^2 + 0.5*(x(2) + 0.5)^2;
else
    y = 5/8 * (x(1) - 1)^2;
end

end
