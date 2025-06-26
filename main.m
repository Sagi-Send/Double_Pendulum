clc;  close all;

%% ----- Initialize -------------------------------------------------------
[m1, m2, l1, l2, g, F]  = Init.define_paramters();  % paramters
[h, Tf, tspan, opts]    = Init.discritize_time();   % time discretization
y0                      = Init.init_conditions();   % initial conditions

%% ----- Solve ------------------------------------------------------------
[To, Yo] = Solver.solve_ODE(tspan,y0,opts,m1,m2,l1,l2,F,g);

%% ----- Plot -------------------------------------------------------------
Plotter.plot(Yo, To, l1, l2)