format long;
s = tf('s');
c_inner = (2*s+160)/(s+32);
p_inner = 1.7/(0.016*s^2+s);
p_overall = (c_inner*p_inner)/(1+c_inner*p_inner)*0.05644*5.6884/s^2
T = 0.01;
c_outer = 2000*(s+1.8)*(s+14.5)/(s+40)^2;
rlocus(p_overall);
figure;
rlocus(p_overall*c_outer);
[~,~,~,wcg]=margin(p_overall*c_outer)
d_outer = c2d(c_outer,T, 'tustin')
[num, den] = tfdata(d_outer, 'v')

