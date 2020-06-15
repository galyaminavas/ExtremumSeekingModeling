function [dx] = plant2(t,x,par)
% описание моделируемой системы, приведено системе диффуров первого порядка

u = control(t, x, par);
dx = [x(2);
      sin(t) + x(2) + x(1) / (1 + x(1)) + u;
    ];
end

function u = control(t, x, par)
% функция u_t в статье

R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);

u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
end

function sign_eps = sign_eps(x, par)
sign_eps = zeros(1,2);
%в par
%epsilon = 0.01;
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

function sigma_est = sigma_est( t, x, par )
sigma_est = par.mu * grad_est(t, [x(1), x(3)], par) + [x(2), x(4)];
end

function grad_est = grad_est( t, x, par )
%grad_est = [5/4*(x(1) - 1), 26 * (x(2)+0.5) ]; 

% % Позняк
% xi_matrix = 12 * eye(2);
% xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1); %1 столбец, 2 строки, всё правильно
% %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
% grad_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)]);
% grad_est = transpose(grad_est);

xi_big = 1/12 * eye(2);
xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
x_1 = x(1) + par.alpha * xi_small(1);
x_2 = x(2) + par.alpha * xi_small(2);
grad_est = inv(xi_big) * par.alpha ^ (-1) * xi_small * loss(t, [x_1, x_2]);
grad_est = transpose(grad_est);

% % Измененная оценка
% xi_matrix = 12 * eye(2);
% xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1); %1 столбец, 2 строки, всё правильно
% %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
% loss_plus = loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)]);
% loss_minus = loss(t, [x(1) - par.alpha * xi(1), x(2) - par.alpha * xi(2)]);
% 
% grad_est = 1/par.alpha * xi_matrix * xi * (loss_plus - loss_minus);
% grad_est = transpose(grad_est);

% возможно, сделать 1,2, при перемножении поменять матрицу и вектор местами
% и убрать транспонирование???
  %          1/par.alpha * xi_matrix * xi * loss(t, x(2) + par.alpha * xi)];
end

function [dx] = sec_order_fil(t, x, par)
[dx] = 
end

function D = dither_estimation(t, x, par)
zeta_t = sin(par.w0 * t);
D = 1 / par.alpha * zeta_t * loss(t, x + par.alpha * zeta_t);
end

function y = loss( t, x )
y = cosh(1/5 * (x - 15));
end
