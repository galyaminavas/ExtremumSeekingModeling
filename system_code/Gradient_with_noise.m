function u = Gradient_with_noise(t, x, par)
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
    xi_small = rand(2,1);

    if par.noise_type == 1 % Uniform
        xi_small = par.noise_value_min + (par.noise_value_max - par.noise_value_min).*xi_small;
    elseif par.noise_type == 2 % Gauss
        xi_small = normrnd(0, par.noise_value_max, [2,1]);
    elseif par.noise_type == 3 % Discrete
        for ii = 1:length(xi_small)
            if xi_small(ii) < .5
                xi_small(ii) = par.noise_value_min;
            else
                xi_small(ii) = par.noise_value_max;
            end
        end
    end

    grad_est = [5/4*(x(1) - 1) + xi_small(1), (x(2)+0.5) + xi_small(2)];
else
    xi_small = rand(1,1);

    if par.noise_type == 1 % Uniform
        xi_small = par.noise_value_min + (par.noise_value_max - par.noise_value_min).*xi_small;
    elseif par.noise_type == 2 % Gauss
        xi_small = normrnd(0, par.noise_value_max);
    elseif par.noise_type == 3 % Discrete
        for ii = 1:length(xi_small)
            if xi_small(ii) < .5
                xi_small(ii) = par.noise_value_min;
            else
                xi_small(ii) = par.noise_value_max;
            end
        end
    end

    grad_est = [5/4*(x(1) - 1) + xi_small(1)];
end 

end

function y = loss( t, x )
if par.dim == 2
    y = 5/8 * (x(1) - 1)^2 + 0.5*(x(2) + 0.5)^2;
else
    y = 5/8 * (x(1) - 1)^2;
end

end
