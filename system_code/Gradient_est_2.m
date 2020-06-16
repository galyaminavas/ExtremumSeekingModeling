function u = Gradient_est_2(t, x, par)
% функция u_t в статье

if par.dim == 2
    %R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
    R = par.mu * par.D * (norm([x(1), x(3)]) / par.alpha + 1) * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
    % /(par.alpha + 1)  - расходится сильнее

    u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
else
    %R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
    R = par.mu * par.D * (norm([x(1)]) / par.alpha + 1) * norm([x(2)]) + par.c0 + par.c1 * norm([x(1)]) + par.c2 * norm([x(2)]);
    % /(par.alpha + 1)  - расходится сильнее

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
% % Измененная оценка
if par.dim == 2
    xi_matrix = 12 * eye(2);
    xi = rand(2,1);
    for ii = 1:length(xi)
        if xi(ii) < .5
            xi(ii) = -0.5;
        else
            xi(ii) = 0.5;
        end
    end
    %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
    loss_plus = loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)], par);
    loss_minus = loss(t, [x(1) - par.alpha * xi(1), x(2) - par.alpha * xi(2)], par);
    grad_est = 1/(2 * par.alpha) * xi_matrix * xi * (loss_plus - loss_minus);
    grad_est = transpose(grad_est);
else
    xi_matrix = 12;
    xi = rand(1,1);
    for ii = 1:length(xi)
        if xi(ii) < .5
            xi(ii) = -0.5;
        else
            xi(ii) = 0.5;
        end
    end
    loss_plus = loss(t, [x(1) + par.alpha * xi(1)], par);
    loss_minus = loss(t, [x(1) - par.alpha * xi(1)], par);
    grad_est = 1/(2 * par.alpha) * xi_matrix * xi * (loss_plus - loss_minus);
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
