clc;  close all;

%% ----- parameters ------------------------------------------------------
m1 = 1;  m2 = 1;              % [kg]
l1 = 1;  l2 = 1;              % [m]
g  = 10;                      % [m s^{-2}]
F  = 5;                       % [N]

%% ----- time discretization --------------------------------------------
h   = 0.01;                    % time step
Tf  = 500;                    % final time
tspan = 0:h:Tf;               % time vector
opts  = odeset('RelTol',1e-9,'AbsTol',1e-9);

%% ----- initial conditions ---------------------------------------------
y0 = [1.5  0   2.50  0];     % [θ₁, θ̇₁, θ₂, θ̇₂]

%% ----- integration -----------------------------------------------------
[To,Yo] = ode45(@Double_Pendulum,tspan,y0,opts,m1,m2,l1,l2,F,g);

%  ODE right-hand side
function dy = Double_Pendulum(~,y,m1,m2,l1,l2,F,g)
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

%% ----- Animation + GIF writer ----------------------------------------
figure(2); clf
L = l1 + l2;
ax = axes('XLim',[-L L],'YLim',[-L L],'DataAspectRatio',[1 1 1]);
grid(ax,'off');  hold(ax,'on')
title(ax,'Double Pendulum Animation with $m_2$ Trajectory', ...
      'Interpreter','latex');  xlabel(ax,'x [m]');  ylabel(ax,'y [m]');

% graphics objects
rod1 = plot(ax,[0 0],[0 0],'LineWidth',2,'Color',[0.1 0.3 0.8]);
rod2 = plot(ax,[0 0],[0 0],'LineWidth',2,'Color',[0.9 0.2 0.2]);
bob1 = plot(ax,0,0,'o','MarkerSize',8,'MarkerFaceColor',[0.1 0.3 0.8], ...
                 'MarkerEdgeColor','none');
bob2 = plot(ax,0,0,'o','MarkerSize',8,'MarkerFaceColor',[0.9 0.2 0.2], ...
                 'MarkerEdgeColor','none');
traj = animatedline('Color',[0.4 0.4 0.4],'LineStyle','--');

% coordinates
x1 =  l1*sin(Yo(:,1));              y1 = -l1*cos(Yo(:,1));
x2 =  x1 + l2*sin(Yo(:,3));         y2 =  y1 - l2*cos(Yo(:,3));

% GIF settings
gifName    = 'double_pendulum.gif';
frameDelay = 0.02;     % s between frames in the GIF
skip       = 1;        % =1 → write every step; raise to decimate GIF size

for k = 1:skip:numel(To)

    if ~isvalid(rod1);  break; end           % tidy exit

    % update geometry
    rod1.XData = [0     x1(k)];   rod1.YData = [0     y1(k)];
    rod2.XData = [x1(k) x2(k)];   rod2.YData = [y1(k) y2(k)];
    bob1.XData =  x1(k);          bob1.YData =  y1(k);
    bob2.XData =  x2(k);          bob2.YData =  y2(k);
    addpoints(traj,x2(k),y2(k))

    drawnow

    % write frame to GIF
    frame = getframe(gcf);                 % capture axes
    [img,cm] = rgb2ind(frame.cdata,256);  % indexed colour for GIF
    if k == 1
        imwrite(img,cm,gifName,'gif','Loopcount',inf,'DelayTime',frameDelay);
    else
        imwrite(img,cm,gifName,'gif','WriteMode','append','DelayTime',frameDelay);
    end
end