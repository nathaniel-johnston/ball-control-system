format long;

theta = out.theta;
v = out.v;
t = out.t;
theta_r = out.theta_r;
y = out.y;
r = out.r;

figure(1);
plot(t, theta, 'DisplayName', 'theta(t)');
hold on;
plot(t, y, 'DisplayName', 'y(t)');
plot(t, r, 'DisplayName', 'r(t)');
legend;
title('step response');
xlabel('time (s)');
ylabel('ball position');
hold off;

figure(2);
ball_beam_display(t, theta, y, r)