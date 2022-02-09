function loc = get_uma8_settings(rel_pos)
% Get mic locations from UMA-8

% Jose Maria Perez-Macias Martin 2018

loc = [ 0    0.0422    0.0211   -0.0211   -0.0422   -0.0211    0.0211;
    0         0   -0.0366   -0.0366   -0.0000    0.0366    0.0366;
    0         0         0         0         0         0         0]';

loc(:,1)=-loc(:,1)+rel_pos;
loc(:,2)=-loc(:,2);