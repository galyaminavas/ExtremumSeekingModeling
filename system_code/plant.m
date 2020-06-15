function [dx] = plant(t,x,par)
% описание моделируемой системы, приведено к системе дифференциальных уравнений первого порядка

zeta = par.a_zeta + (par.b_zeta - par.a_zeta).*rand(1,2);
%zeta = zeros(1,2);

u = control(t, x, par);
dx = [x(2);
      0.2 * (cos(x(1)) + x(3) - x(2) - 1) / (1 + abs(x(1)) + abs(x(3)) + 0.5 * abs(x(2)) + 0.5 * abs(x(4))) + zeta(1) + u(1,1);
      x(4);
      -0.2 * atan(x(3)) - (abs(x(1))^2 + abs(x(4))^2) / (1 + abs(x(1)) + abs(x(4))) + zeta(2) + u(1,2);
    ];
end
