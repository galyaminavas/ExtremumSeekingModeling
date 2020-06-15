function [t,x,par] = smcExample()

par.a_zeta = -0.01;
par.b_zeta = 0.01;

par.algorithm = 2;

par.k = 30;
par.mu = 0.03;
par.D = 0.5;
par.c0 = 1;
par.c1 = 1;
par.c2 = 1;

%par.alpha = 0.01; % для 1
par.alpha = 0.0000001; % для 2
par.a_xi = -0.5;
par.b_xi = 0.5;

par.epsilon = 0.01;

x0 = [0.9, 0, -1, 0];

ti = 0; 
tf = 420; 
tstep = 0.01;
%options=odeset('OutputFcn',@odeprog,'Events',@odeabort);
opt = odeset('AbsTol',1.0e-07,'RelTol',1.0e-07,'OutputFcn',@odeprog,'Events',@odeabort);
[t,x] = ode15s( @plant, [ti:tstep:tf], x0 ,opt, par );

end