function positions()
% Position testing.
% The microphone was tested using the order of the names in the board of
% the UMA-8.
% The recording was taken with an UMA-8, and 11khz, as I believed is
% enough.


% Recordings of the UMA-8 are taken the USB facing front, and
% and the micrphones wholes looking upwards.

% Jose Maria Perez-Macias Martin


%%

clear all, close all
relative_position = 25; % Relative position needed to find 
disp('File with the testing locations ')

% For MacOS or Linux
% audiofile = 'test_positions_mic_check_0.m4a'
% [y, Fs] = audioread(audiofile);

load  data\test_positions_mic_check_2.m4a.mat

y = y/32768;

% Plot the tracks while pushing each of the mics
h_figure = figure;
for i = 1 : 7
    y1=y(:,i)./max(y(:,i)); % some normalization for visualization
    subplot(7,2,i+(i-1))
    plot(y1);
    title(['Track no.', num2str(i)])
    
end %EOLoop

% Localizations for the UMA-8 (given by Pasi Pertila)
loc = [ 0    0.0422    0.0211   -0.0211   -0.0422   -0.0211    0.0211;
    0         0   -0.0366   -0.0366   -0.0000    0.0366    0.0366;
    0         0         0         0         0         0         0]';
% note that it is transposed

% We use a relative position
loc(:,1)=-loc(:,1)+relative_position;
loc(:,2)=-loc(:,2);

% plot the locations of the Microphone
figure(h_figure)
subplot(7,2,[6, 8])

plot(loc(:,1),loc(:,2),'.')
hold on
circle(loc(1,1),loc(1,2),0.0422);
axis equal

for j = 1 : 7
    text(loc(j,1)+0.0422*0.05,loc(j,2),num2str(j-1))
end
title('Positions of Microphones')
xlabel('[m]')
ylabel('[m]')

% Setting some sizes
x0=10;
y0=10;
width=400;
height=810;
set(gcf,'units','points','position',[x0,y0,width,height])


% 1 1
% 2 3 1
% 3 5 2
% 4 7 3
% 5 9 4

end % EOFunciton 


function h = circle(x,y,r)
% This funciton was downloaded from the internet

hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
hold off
end %EOFunction


