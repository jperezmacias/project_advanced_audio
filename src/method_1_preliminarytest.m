% Modified Jose Maria Perez-Macias
close all, clear all

lsb = [1,1,1];          % Minimum room x,y,x dimensions
usb = [14,22,5];        % Maximum room x,y,x dimensions

% Mics location (xyz, 1 mic per row)
mic_loc = [7,20,2; ...
    7,16,2;  ...
    3,15,2;  ...
    11,15,2; ...
    7,9,2];

mic_loc = [ 0    0.0422    0.0211   -0.0211   -0.0422   -0.0211    0.0211;
    0         0   -0.0366   -0.0366   -0.0000    0.0366    0.0366;
    0         0         0         0         0         0         0]';

mic_loc(:,1)=-mic_loc(:,1);
mic_loc(:,2)=-mic_loc(:,2);

Filename = 'data\voice_moving.m4a.mat'
disp(Filename)
load(Filename)

% Code for Linux or Mac
% [y, fs] = audioread(Filename);

% Select the data
pos_ini = 1;
% pos_fin = pos_ini + 10*fs; % 20 seconds from pos_ini
pos_fin = size(y,1);

y=y(pos_ini:pos_fin,1:7);

% load('./data/Examples/bassoon_5mics.mat','y','fs');    % Ground-Truth (4,18,2)
% load('./data/Examples/clarinet_5mics.mat','y','fs');   % Ground-Truth (10,18,2)
%load('./data/Examples/saxphone_5mics.mat','y','fs');   % Ground-Truth (4,13,2)
%load('./data/Examples/violin_5mics.mat','y','fs');     % Ground-Truth (10,13,2)

% Take a chuck from the signal (fast computation for demo)
% pos_ini = fs;
% pos_fin = pos_ini + 3*fs; % 2 seconds from pos_ini
lsb=[1 1 1];
usb =[20 20 20];

frame_cnt = 0;

win_len =  0.3*fs; %nfft;
nb_frames = floor(size(y,1)/win_len);
hop_len = win_len / 2;
srp_vec_total= zeros(nb_frames,36);

h= figure,

finalpos_total = [];
% y=y(fs*2:end,:);

for i = 1:nb_frames
    y_win = y(i * hop_len: (i * hop_len + win_len -1),:);%.* window
    
    %calculate energy spectral density
    %fft_en = np.abs(fft(y_win)[:1 + nfft / 2]) ** 2
    
    % calculate mel band energy
    %mbe[frame_cnt, :] = np.dot(_fft_en, fft_mel_bands)
    
    [finalpos,finalsrp]=srpphat(y_win, mic_loc, fs, lsb, usb);
    
    % Display the source location, just xy coord to simplify
    room = zeros(usb(1),usb(2));
    for k=1:numel(finalsrp)
        room(round(finalpos(k,1)),round(finalpos(k,2)))=max(room(round(finalpos(k,1)),round(finalpos(k,2))),(finalsrp(k)));
    end
    figure;  imagesc(room');
    axis xy;
    
    frame_cnt = frame_cnt + 1
end

