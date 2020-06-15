function [dx] = plantdim1(t,x,par)
% описание моделируемой системы, приведено к системе диффуров первого порядка

%zeta = par.a_zeta + (par.b_zeta - par.a_zeta).*rand(1,2);
zeta = zeros(1,1);

u = control(t, x, par);
dx = [x(2);
      0.2 * (cos(x(1)) - x(2) - 1) / (1 + abs(x(1)) + 0.5 * abs(x(2))) + zeta(1) + u(1,1);
    ];
end
