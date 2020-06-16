[t,x,par] = smcExample();
plot(t,x);

% table = [x(:,1), x(:,3)];
% y = 5/8 * (table(:,1) - 1).^2 + 13*(table(:,2) + 0.5).^2;
% 
% table_dot = [x(:,2), x(:,4)];
% 
% n = length(t);
% xi_matrix = 12 * eye(2);
% grad_est = zeros(n,2);
% matrix_times_xi = zeros(n,2);
% for i = 1:n
%     xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
%     matrix_times_xi(i,:) = xi_matrix * xi;
%     grad_est(i,:) = 1/par.alpha * (5/8 * (table(i,1) + par.alpha * xi(1,1) - 1)^2 + 13*(table(i,2) + par.alpha * xi(2,1) + 0.5)^2) * matrix_times_xi(i,:);
%     %g_est(i,:) = 1/par.alpha * xi_matrix * xi * (5/8 * (table(1,1) - 1).^2 + 13*(table(1,2) + 0.5).^2);
%     %grad_est(i,:) = transpose(g_est);
% end;
% 
% real_grad = zeros(n,2);
% for i = 1:n
%     real_grad(i,1) = 5/4*(table(i,1) - 1);
%     real_grad(i,2) = 26 * (table(i,2)+0.5);
% end;
% 
% plot(t,table(:,1));
% xlabel('t');
% ylabel('x_1');
% figure();
% 
% plot(t,table(:,2));
% xlabel('t');
% ylabel('x_2');
% figure();
% 
% plot(table(:,1),table(:,2));
% xlabel('x_1');
% ylabel('x_2');
% hold on;
% plot(1,-0.5,'ro');
% figure();
% 
% plot(t, table_dot(:,1));
% xlabel('t');
% ylabel('x_1_dot');
% figure();
% 
% plot(t, table_dot(:,2));
% xlabel('t');
% ylabel('x_2_dot');
% figure();
% 
% plot(t,grad_est(:,1));
% hold on;
% plot(t,grad_est(:,2));
% ylabel('gradient estimate');
% figure();
% 
% plot(t,real_grad(:,1));
% hold on;
% plot(t,real_grad(:,2));
% ylabel('real gradient');
% 
% u = zeros(n,2);
% for i = 1:n
%     u(i,:) = control(t(i), x(i,:), par);
% end
% figure();
% plot(t, u(:,1));
% 
% %g = zeros(n,2);
% % for i = 1:n
% %     g(i) = norm([0.2 * (cos(x(i,1)) + x(i,3) - x(i,2) - 1) / (1 + abs(x(i,1)) + abs(x(i,3)) + 0.5 * abs(x(i,2)) + 0.5 * abs(x(i,4)));
% %                 -0.2 * atan(x(i,3)) - (abs(x(i,1))^2 + abs(x(i,4))^2) / (1 + abs(x(i,1)) + abs(x(i,4)));]);
% % end;
% % upp = zeros(n,1);
% % for i = 1:n
% %     upp(i) = par.c0 + par.c1 * norm([x(i,1); x(i,3)]) + par.c2 * norm([x(i,2); x(i,4)]);
% % end;
% %figure();
% %plot(t,g);
% %ylabel('g');
% %figure();
% %plot(t,upp-g);
% %ylabel('upp - g');
% 
% % plot(t,real_grad(:,2));
% % figure();
% % plot(t,grad_est(:,2));
% 
% % lent = length(t);
% % s = zeros(lent,1);
% % 
% % x1s = linspace(min(x(:,1))-1, max(x(:,1)), 1001)';
% % sM = [x1s, -par.k*x1s];
% % for i = 1:lent
% %     [~,s(i)] = slidingModeSystemEoM(t(i),x(i,:)',par);
% % end
% % 
% % 
% % figure(1),clf
% % line(x(:,1),x(:,2),'LineWidth', 2)
% % line(sM(:,1), sM(:,2), 'LineStyle', '-.', 'Color', 'red', 'LineWidth', 1)
% % xlabel('x_1')
% % ylabel('x_2')
% % legend('Phase plot','Sliding Manifold','Location','Best')
% % 
% % figure(2), clf
% % plot(t, s)
% % xlabel('time [sec]')
% % ylabel('s')