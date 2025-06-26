classdef Solver
%% ----- integration ------------------------------------------------------
    methods(Static)
        function [To, Yo] = solve_ODE(tspan,y0,opts,m1,m2,l1,l2,F,g)
            [To,Yo] = ode45(@Solver.pendulum_solver,tspan,y0,opts,m1,m2...
                ,l1,l2,F,g);
        end
        
        %  ODE right-hand side
        function dy = pendulum_solver(~,y,m1,m2,l1,l2,F,g)
            % state vector  y = [theta1, theta1d, theta2, theta2d]ᵀ
            theta1  = y(1);   theta1d = y(2);
            theta2  = y(3);   theta2d = y(4);
            
            % mass matrix
            M = [ (m1+m2)*l1,           m2*l2*cos(theta2-theta1);
                  l1*cos(theta2-theta1),               l2         ];
            
            % right-hand side
            R = [ m2*l2*theta2d^2*sin(theta2-theta1) - (m1+m2)*g*sin(theta1);
                 -l1*theta1d^2*sin(theta2-theta1)    - g*sin(theta2) - F*sin(theta2) ];
            
            thetadd = M\R;
            
            dy = [theta1d;
                  thetadd(1);
                  theta2d;
                  thetadd(2)];
            end
    end
end