function u = Gradient(t, x, par)
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
grad_est = [5/4*(x(1) - 1), (x(2)+0.5)]; 
end

function y = loss( t, x )
y = 5/8 * (x(1) - 1)^2 + 0.5*(x(2) + 0.5)^2;
end

