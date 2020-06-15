function u = control(t, x, par)
% функция u_t 
% в статье

if par.algorithm == 1
    u = Gradient(t, x, par);
elseif par.algorithm == 2
    u = Gradient_with_noise(t,x,par);
elseif par.algorithm == 3
    u = Gradient_est_1(t,x,par);
elseif par.algorithm == 4
    u = Gradient_est_2(t,x,par);
end

% R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
% %R = par.mu * par.D * (norm([x(1), x(3)]) / 100 + 1) * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
% % /(par.alpha + 1)  - расходится сильнее
% 
% u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
end

% function sigma_est = sigma_est( t, x, par )
% sigma_est = par.mu * grad_est(t, [x(1), x(3)], par) + [x(2), x(4)];
% end
% 
% function grad_est = grad_est( t, x, par )
% % xi_small = rand(2,1);
% % for ii = 1:length(xi_small)
% %     if xi_small(ii) < .5
% %         xi_small(ii) = -0.5;
% %     else
% %         xi_small(ii) = 0.5;
% %     end
% % end
% % grad_est = [5/4*(x(1) - 1) + par.alpha*xi_small(1), (x(2)+0.5) + par.alpha*xi_small(2)]; 
% grad_est = [5/4*(x(1) - 1), (x(2)+0.5)]; 
% 
% %xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
% % grad_est = [5/4*(x(1) - 1) + par.alpha*xi_small(1), 26 * (x(2)+0.5) + par.alpha*xi_small(2) ];
% 
% 
% % % Позняк
% % xi_matrix = 12 * eye(2);
% % xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1); %1 столбец, 2 строки, всё правильно
% % %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
% % grad_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)]);
% % grad_est = transpose(grad_est);
% 
% % xi_big = 1/12 * eye(2);
% % xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
% % x_1 = x(1) + par.alpha * xi_small(1);
% % x_2 = x(2) + par.alpha * xi_small(2);
% % grad_est = inv(xi_big) * par.alpha ^ (-1) * xi_small * loss(t, [x_1, x_2]);
% % grad_est = transpose(grad_est);
% 
% % % Измененная оценка
% % xi_matrix = 12 * eye(2);
% % %xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1); %1 столбец, 2 строки, всё правильно
% % xi = rand(2,1);
% % for ii = 1:length(xi)
% %     if xi(ii) < .5
% %         xi(ii) = -0.5;
% %     else
% %         xi(ii) = 0.5;
% %     end
% % end
% % %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
% % loss_plus = loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)]);
% % loss_minus = loss(t, [x(1) - par.alpha * xi(1), x(2) - par.alpha * xi(2)]);
% % grad_est = 1/par.alpha * xi_matrix * xi * (loss_plus - loss_minus);
% % grad_est = transpose(grad_est);
% end
% 
% function y = loss( t, x )
% y = 5/8 * (x(1) - 1)^2 + 0.5*(x(2) + 0.5)^2;
% end
% 
% 
% % function u = control(t, x, par)
% % % функция u_t в статье
% % 
% % R = par.mu * par.D * norm([x(2), x(4)]) + par.c0 + par.c1 * norm([x(1), x(3)]) + par.c2 * norm([x(2), x(4)]);
% % 
% % u = -par.k * R * sign_eps(sigma_est(t, x, par), par);
% % end
% % 
% % function sign_eps = sign_eps(x, par)
% % sign_eps = zeros(1,2);
% % %в par
% % %epsilon = 0.01;
% % for ii = 1:length(x)    % loop through all elements of the vector
% %     if x(ii) >= par.epsilon
% %         sign_eps(ii) = 1;
% %     elseif x(ii) <= -par.epsilon
% %         sign_eps(ii) = -1;
% %     else
% %         sign_eps(ii) = x(ii) / par.epsilon;
% %     end
% %  end
% % end
% % 
% % function sigma_est = sigma_est( t, x, par )
% % sigma_est = par.mu * grad_est(t, [x(1), x(3)], par) + [x(2), x(4)];
% % end
% % 
% % function grad_est = grad_est( t, x, par )
% % %grad_est = [5/4*(x(1) - 1), 26 * (x(2)+0.5) ]; 
% % 
% % % % Позняк
% % % xi_matrix = 12 * eye(2);
% % % xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1); %1 столбец, 2 строки, всё правильно
% % % %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
% % % grad_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)]);
% % % grad_est = transpose(grad_est);
% % 
% % xi_big = 1/12 * eye(2);
% % xi_small = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
% % x_1 = x(1) + par.alpha * xi_small(1);
% % x_2 = x(2) + par.alpha * xi_small(2);
% % grad_est = inv(xi_big) * par.alpha ^ (-1) * xi_small * loss(t, [x_1, x_2]);
% % grad_est = transpose(grad_est);
% % 
% % % % Измененная оценка
% % % xi_matrix = 12 * eye(2);
% % % xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1); %1 столбец, 2 строки, всё правильно
% % % %g_est = 1/par.alpha * xi_matrix * xi * loss(t, [x(1) + par.alpha * xi, x(2) + par.alpha * xi]);
% % % loss_plus = loss(t, [x(1) + par.alpha * xi(1), x(2) + par.alpha * xi(2)]);
% % % loss_minus = loss(t, [x(1) - par.alpha * xi(1), x(2) - par.alpha * xi(2)]);
% % % 
% % % grad_est = 1/par.alpha * xi_matrix * xi * (loss_plus - loss_minus);
% % % grad_est = transpose(grad_est);
% % 
% % % возможно, сделать 1,2, при перемножении поменять матрицу и вектор местами
% % % и убрать транспонирование???
% %   %          1/par.alpha * xi_matrix * xi * loss(t, x(2) + par.alpha * xi)];
% % end
