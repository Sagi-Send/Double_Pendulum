classdef Plotter
%% ----- Animation + GIF writer ------------------------------------------
    methods(Static)
        function plot(Yo, To, l1, l2)
            fig = figure(1); clf(fig);
            L = l1 + l2;
            ax = axes('XLim',[-L L],'YLim',[-L L],'DataAspectRatio',...
                [1 1 1]);
            grid(ax,'off');  hold(ax,'on')
            title(ax,'Double Pendulum Animation with $m_2$ Trajectory', ...
                  'Interpreter','latex');  xlabel(ax,'x [m]');
            ylabel(ax,'y [m]');
            
            % graphics objects
            rod1 = plot(ax,[0 0],[0 0],'LineWidth',2,'Color',...
                [0.1 0.3 0.8]);
            rod2 = plot(ax,[0 0],[0 0],'LineWidth',2,'Color',...
                [0.9 0.2 0.2]);
            bob1 = plot(ax,0,0,'o','MarkerSize',8,'MarkerFaceColor',...
                [0.1 0.3 0.8], 'MarkerEdgeColor','none');
            bob2 = plot(ax,0,0,'o','MarkerSize',8,'MarkerFaceColor',...
                [0.9 0.2 0.2], 'MarkerEdgeColor','none');
            traj = animatedline('Color',[0.4 0.4 0.4],'LineStyle','--');
            
            % coordinates
            x1 =  l1*sin(Yo(:,1));              y1 = -l1*cos(Yo(:,1));
            x2 =  x1 + l2*sin(Yo(:,3));         y2 =  y1 - l2*cos(Yo(:,3));
            
            % GIF settings
            [gifName, frameDelay, skip] = ...
                Plotter.define_gif('double_pendulum.gif', 0.02, 1);

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
                Plotter.write_to_gif(gifName, frameDelay, skip, k, fig);
            end
        end

        function [gifName, frameDelay, skip] = define_gif(gifName_str,...
                frameDelay_val, skip_val)
            folder = 'figs';
            if ~exist(folder, 'dir')
                mkdir(folder);    % create figs/ if it doesn't exist
            end
            % save as figs/filename.gif
            gifName = fullfile(folder, gifName_str);
            frameDelay = frameDelay_val;
            skip = skip_val;
        end

        function write_to_gif(gifName, frameDelay, skip, k, fig)
            if ~isvalid(fig) % terminate if animation is closed
                return
            end
            frame = getframe(gcf);              % capture axes
            [img,cm] = rgb2ind(frame.cdata,256);% indexed colour for GIF
            if k == skip
                imwrite(img,cm,gifName,'gif','Loopcount',inf,...
                    'DelayTime',frameDelay);
            else
                imwrite(img,cm,gifName,'gif','WriteMode','append',...
                    'DelayTime',frameDelay);
            end
        end
    end
end