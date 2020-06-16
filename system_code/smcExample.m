function [t,x,par] = smcExample()
% setting parameters without application

par.a_zeta = -0.01;
par.b_zeta = 0.01;

par.algorithm = 4;
%par.dim = 1;
par.dim = 2;
par.noise_type = 3;
par.noise_value_min = -0.00000005;
par.noise_value_max = 0.00000005;

par.k = 30;
par.mu = 0.03;
par.D = 0.5;
par.c0 = 1;
par.c1 = 1;
par.c2 = 1;

%par.alpha = 0.01; % для algorithm = 1
par.alpha = 0.0000001; % для algorithm = 2
par.a_xi = -0.5;
par.b_xi = 0.5;

par.epsilon = 0.01;

x0 = [0.9, 0, -1, 0]; % for dim = 2
% x0 = [0.9, 0]; % for dim = 1

ti = 0; 
tf = 420; 
tstep = 0.01;
% options=odeset('OutputFcn',@odeprog,'Events',@odeabort); % without progress bar
opt = odeset('AbsTol',1.0e-07,'RelTol',1.0e-07,'OutputFcn',@odeprog,'Events',@odeabort); % with progress bar
[t,x] = ode15s( @plant, [ti:tstep:tf], x0 ,opt, par );
%[t,x] = ode15s( @plantdim1, [ti:tstep:tf], x0 ,opt, par );

end