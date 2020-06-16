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

end
