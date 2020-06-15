function u = Gradient_with_noise(t, x, par)
% функция u_t в статье

R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
%R = par.mu * par.D * (norm([x(1), x(3)]) / 100 + 1) * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
% /(par.alpha + 1)  - расходится сильнее

u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
end

function sigma_est = sigma_est( t, x, par )
sigma_est = par.mu * grad_est(t, [x(1), x(3)], par) + [x(2), x(4)];
end

function grad_est = grad_est( t, x, par )
xi_small = rand(2,1);
for ii = 1:length(xi_small)
    if xi_small(ii) < .5
        xi_small(ii) = par.noise_value_min;
    else
        xi_small(ii) = par.noise_value_max;
    end
end
grad_est = [5/4*(x(1) - 1) + xi_small(1), (x(2)+0.5) + xi_small(2)]; 
%grad_est = [5/4*(x(1) - 1), (x(2)+0.5)]; 

%xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
% grad_est = [5/4*(x(1) - 1) + par.alpha*xi_small(1), 26 * (x(2)+0.5) + par.alpha*xi_small(2) ];

end

function y = loss( t, x )
y = 5/8 * (x(1) - 1)^2 + 0.5*(x(2) + 0.5)^2;
end
