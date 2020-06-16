[t,x,par] = smcExample();
% script for running algorithms without application

%plot(t,x);

table = [x(:,1), x(:,3)];
y = 5/8 * (table(:,1) - 1).^2 + 0.5*(table(:,2) + 0.5).^2;

table_dot = [x(:,2), x(:,4)];

n = length(t);
xi_matrix = 12 * eye(2);
grad_est = zeros(n,2);
matrix_times_xi = zeros(n,2);
for i = 1:n
    xi = par.a_xi + (par.b_xi-par.a_xi).*rand(2,1);
    matrix_times_xi(i,:) = xi_matrix * xi;
    grad_est(i,:) = 1/par.alpha * (5/8 * (table(i,1) + par.alpha * xi(1,1) - 1)^2 + 13*(table(i,2) + par.alpha * xi(2,1) + 0.5)^2) * matrix_times_xi(i,:);
    %g_est(i,:) = 1/par.alpha * xi_matrix * xi * (5/8 * (table(1,1) - 1).^2 + 13*(table(1,2) + 0.5).^2);
    %grad_est(i,:) = transpose(g_est);
end;

real_grad = zeros(n,2);
for i = 1:n
    real_grad(i,1) = 5/4*(table(i,1) - 1);
    real_grad(i,2) = 26 * (table(i,2)+0.5);
end;

plot(t,table(:,1));
xlabel('t');
ylabel('x_1');
figure();

plot(t,table(:,2));
xlabel('t');
ylabel('x_2');
figure();

plot(table(:,1),table(:,2));
xlabel('x_1');
ylabel('x_2');
hold on;
plot(1,-0.5,'ro');
figure();

plot(t, table_dot(:,1));
xlabel('t');
ylabel('x_1_dot');
figure();

plot(t, table_dot(:,2));
xlabel('t');
ylabel('x_2_dot');
figure();

plot(t,grad_est(:,1));
hold on;
plot(t,grad_est(:,2));
ylabel('gradient estimate');
figure();

plot(t,real_grad(:,1));
hold on;
plot(t,real_grad(:,2));
ylabel('real gradient');

u = zeros(n,2);
for i = 1:n
    u(i,:) = control(t(i), x(i,:), par);
end
figure();
plot(t, u(:,1));
