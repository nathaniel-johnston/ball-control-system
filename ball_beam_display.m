% function ball_beam_display(t,theta,y,ref)
%
% This function is used to display the movement of the ball and beam
% apparatus.  Typically it is called after running a simulation in 
% Simulink, where the Simulink outputs are output to the workspace.
%
% Inputs:      t = time vector (uniformly spaced, seconds)
%          theta = motor gear angle (radians)
%              y = ball position on beam (meters)
%            ref = reference ball position (meters) [optional argument]
%                  (The reference ball location is shown in red.)
%
% Ver 1.1  Dan Davison  June 3 2020
%

function ball_beam_display(t,theta,y,ref)

if nargin < 3
    error('Arguments t, theta, and y are required')
end
n = length(t);
if length(theta) ~= n
    error('theta vector must have same size as t vector')
end
if length(y) ~= n
    error('y vector must have same size as t vector')
end
ref_used = 0;
if nargin==4
    ref_used = 1;
    if length(ref) ~=n
        error('ref vector must have same size as t vector');
    end
end

% make sure time vector is uniformly spaced
if min(diff(t)) / max(diff(t)) < 0.99
    error('time vector must be uniformaly spaced')
end

% convert y and r to cm since everything below assumed cm
y = y*100;
if ref_used
  ref = ref*100;
end

% geometry of the ball and beam (cm)
r = 2.54;  
l = 12;
L = 45;
R = 1.27; % radius of ball
R1 = 1.00; % radius of displayed part of ball above beam

% set up graphics
shg
clf
fps_des = 20;  % desired max refresh rate
T_des = 1/fps_des;  % desired sampling period for refreshing (seconds)
n_skip = 1;
T_actual = T_des;
if n>1
    T = t(2)-t(1);  % sampling period for raw data
    n_skip = ceil(T_des/T);
    T_actual = T*n_skip;  % final sampling period for refreshing
end

% make sure theta and y and r don't go outside physical bounds
for i = 1:n
    if theta(i) > pi/4
        theta(i) = pi/4;
    elseif theta(i) < -pi/4
        theta(i) = -pi/4;
    end
    if y(i) < 2.0
        y(i) = 2.0;
    elseif y(i) > L-2.0;
        y(i) = L-2.0;
    end
    if ref_used
        if ref(i) < 2.0
            ref(i) = 2.0;
        elseif ref(i) > L-2.0
            ref(i) = L-2.0;
        end
    end
end


% draw non-moving parts

h=plot([-3 3],[-18.35 -18.35],'k'); set(h,'linewidth',2);   % box at left
hold on
axis([-20 68 -50 38])
axis('square')
h = gca; set(h,'Xtick',[]); set(h,'Ytick',[]);
h=plot([-3 3],[-12 -12],'k'); set(h,'linewidth',2);  
h=plot([-3 -3],[-12 -18.35],'k'); set(h,'linewidth',2);  
h=plot([3 3],[-12 -18.35],'k'); set(h,'linewidth',2);  

h=plot([-0.5 -0.5],[-12 -0.8],'k'); set(h,'linewidth',2);   % support at left
h=plot([0.5 0.5],[-12 -0.8],'k'); set(h,'linewidth',2);  
circle(0,0,1,'k');

h=plot([36.11 48.81],[-18.35 -18.35],'k'); set(h,'linewidth',2');  % motor box
h=plot([36.11 48.81],[-5.65 -5.65],'k'); set(h,'linewidth',2');
h=plot([36.11 36.11],[-18.35 -5.65],'k'); set(h,'linewidth',2');
h=plot([48.81 48.81],[-18.35 -5.65],'k'); set(h,'linewidth',2');
rr = 1.0; rrr = 4.5; % ticks
ang = 0; x1=42.46+rrr*cos(ang); x2=42.46+(rrr+rr)*cos(ang); y1=-12+rrr*sin(ang); y2=-12+(rrr+rr)*sin(ang); plot([x1 x2],[y1 y2],'k'); 
ang = pi/4; x1=42.46+rrr*cos(ang); x2=42.46+(rrr+rr)*cos(ang); y1=-12+rrr*sin(ang); y2=-12+(rrr+rr)*sin(ang); plot([x1 x2],[y1 y2],'k'); 
ang = -pi/4; x1=42.46+rrr*cos(ang); x2=42.46+(rrr+rr)*cos(ang); y1=-12+rrr*sin(ang); y2=-12+(rrr+rr)*sin(ang); plot([x1 x2],[y1 y2],'k'); 
circle(42.46,-12,46.5-42.46,'k');
circle(42.46,-12,43.5-42.46,'k');

h=text(24,20,'Ball and Beam Simulation'); set(h,'HorizontalAlignment','center');
h=text(24,15,'Press SPACE to start'); set(h,'HorizontalAlignment','center');



% loop through moving parts

for i = 1:n_skip:n
    
  tic
  if i>1
    delete(h1)
    delete(h2)
    delete(h3)
    delete(h4)
    delete(h5)
    delete(h6)
    delete(h7)
    delete(h8)
    delete(h9)
    delete(h99)
  end
    
  th = theta(i);
  phi = th*0.06;
   
  % lever arm
  x1 = 42.46 + r*cos(th);
  y1 = -12 + r*sin(th);
  x2 = L*cos(phi);
  y2 = L*sin(phi);
  h1 = circle(x1, y1, 0.75, 'k');
  h2 = circle(x2, y2, 0.75, 'k');
  h3 = plot([x1-0.25 x2-0.25],[y1+0.6 y2-0.6],'k'); 
  h4 = plot([x1+0.25 x2+0.25],[y1+0.6 y2-0.6],'k'); 
  rr = 3; rrr = 1; % line on motor wheel
  x3=42.46+rrr*cos(th); x4=42.46+(rrr+rr)*cos(th); y3=-12+rrr*sin(th); y4=-12+(rrr+rr)*sin(th); h7=plot([x3 x4],[y3 y4],'k'); 
  
  % beam
  h5 = plot([0+0.9 x2-0.6],[0+0.25 y2+0.25],'k');
  h6 = plot([0+0.9 x2-0.6],[0-0.25 y2-0.25],'k');

  % ref ball
  if ref_used
    beta = atan(R1/ref(i));
    s = sqrt(ref(i)^2+R1^2);
    h8 = circle(s*cos(phi+beta),s*sin(phi+beta),R,'r');
  else
    h8 = h7;
  end
  
  % ball
  beta = atan(R1/y(i));
  s = sqrt(y(i)^2+R1^2);
  h9 = circle(s*cos(phi+beta),s*sin(phi+beta),R,'k');
    
  % text
  h99 = text(0,-40,sprintf('Time = %3.2f s',t(i)));
    
  drawnow  
  pause(T_actual - toc);
  if i==1
      pause  % wait for space bar
      delete(h)
  end
end
hold off
end


function h = circle(x,y,r,circle_style)
    th = 0:pi/30:2*pi;
    h = plot(r*cos(th)+x, r*sin(th)+y, circle_style);
    set(h,'linewidth',1.5);
    
end 