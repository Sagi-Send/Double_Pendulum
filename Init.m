classdef Init
    methods(Static)
        %% ----- parameters -----------------------------------------------
        function [m1, m2, l1, l2, g, F] = define_paramters()
            m1 = 1;  m2 = 1;              % [kg]
            l1 = 1;  l2 = 1;              % [m]
            g  = 10;                      % [m s^{-2}]
            F  = 5;                       % [N]
        end
        %% ----- time discretization --------------------------------------
        function [h, Tf, tspan, opts] = discritize_time()
            h   = 0.01;                    % time step
            Tf  = 500;                    % final time
            tspan = 0:h:Tf;               % time vector
            opts  = odeset('RelTol',1e-9,'AbsTol',1e-9);
        end
        %% ----- initial conditions ---------------------------------------
        function y0 = init_conditions()
            y0 = [1.5  0   2.50  0];     % [θ₁, θ̇₁, θ₂, θ̇₂]
        end
    end
end




