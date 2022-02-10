% Project Advanced Audio Processing

close all,clear all

Filename = 'positions2.m4a'
Filename = 'moving.m4a'
Filename = 'moving2.m4a'
Filename = 'video2.mov'
Filename = 'test.mov'
Filename = 'moving2.m4a'
Filename = 'video2.mov'

Filename = 'data\car_macwebcam_video_3.mov.mat'
load(Filename)
Filename = 'data\car_macwebcam_video_3.mov'
videoReader = VideoReader(Filename);

% videoReader = VideoReader(Filename);
videoPlayer = vision.VideoPlayer;
fps = get(videoReader, 'FrameRate');
% [y, fs] = audioread(Filename);
y = y/32768;
y=y(:,1:7);

disp(fps); % the fps is correct: it's the same declared in the video file properties
currAxes = axes;

loc = [ 0    0.0422    0.0211   -0.0211   -0.0422   -0.0211    0.0211;
    0         0   -0.0366   -0.0366   -0.0000    0.0366    0.0366;
    0         0         0         0         0         0         0]';

loc(:,1)=-loc(:,1)+25;
loc(:,2)=-loc(:,2);
usb=[20 20 5];
lsb=[0 0 0];

figure

while hasFrame(videoReader)
    vidFrame = readFrame(videoReader);
    subplot(311)
    image(vidFrame);
    currAxes.Visible = 'off';
    pause(1/videoReader.FrameRate);
    subplot(312)
    spectrogram(y(videoReader.CurrentTime*fs:videoReader.CurrentTime*fs+fs*0.3,1),hamming(1024),512,4096,fs)
    
    subplot(313)
    
    
    addpath srplems
    %%
    y_win = y(videoReader.CurrentTime*fs:videoReader.CurrentTime*fs+fs*0.3,:);
    
    [finalpos,finalsrp,finalfe,yintpt]= srplems(y_win,loc,fs,usb,lsb);
    imagesc(yintpt'),axis xy;
end
%%

y = y/32768;

% % Normalization
% for i = 1 : 7
%     y(:,i)= y(:,i)./max(y(:,i));
% end

figure,

for i = 1 : 7
    subplot(7,1,i)
    plot(y(:,i));
end
y=y(:,1:7);

%%

% for i = 1
%
% Number_of_frames=240; %Number of frames
% window_length=round(fs/Number_of_frames);%size of the frame
% Frame_No=zeros(Number_of_frames);%The frame number
% Frame_No(1)=1;
%
% for i=1:Number_of_frames-1
%     Frame_No(i+1)=Frame_No(i)+window_length;%Construct an array for the start number of each frame
% end
% j=input('Enter the frame number: ');
% N=Frame_No(j);%specify which frame
% plot((N:N+window_length-1),s(N:N+window_length-1));%plot the frame
% title(['Frame Number ',num2str(j)]);xlabel('Time');ylabel('Amplitude');
% figure,
% plot(s);title('input signal');xlabel('Time');ylabel('Amplitude');


addpath srplems
%%
loc = [ 0    0.0422    0.0211   -0.0211   -0.0422   -0.0211    0.0211;
    0         0   -0.0366   -0.0366   -0.0000    0.0366    0.0366;
    0         0         0         0         0         0         0]';

loc(:,1)=-loc(:,1)+25;
loc(:,2)=-loc(:,2);

figure,plot(loc(:,1),loc(:,2),'.')
hold on
circle(loc(1,1),loc(1,2),0.0422)
axis equal

for j = 1 : 7
    text(loc(j,1),loc(j,2),num2str(j-1))
end
%%
frame_cnt = 0;

window_length = 2048  % Window length in samples
nfft = 2048;

nb_frames = floor(size(y,1)/window_length);
win_len = nfft;
hop_len = win_len / 2;
srp_vec_total= zeros(nb_frames,36);
h= figure,
usb=[50 50 5];
lsb=[0 0 0];
%
% usb=[2 0 1]
% lsb=[-2 -2 0]
finalpos_total = [],

y=y(Fs*6:end,:);  % We start a bit later.

for i = 1:nb_frames
    
    y_win = y(i * hop_len: (i * hop_len + win_len -1),:);%.* window
    
    %calculate energy spectral density
    %fft_en = np.abs(fft(y_win)[:1 + nfft / 2]) ** 2
    
    % calculate mel band energy
    %mbe[frame_cnt, :] = np.dot(_fft_en, fft_mel_bands)
    
    [finalpos,finalsrp,finalfe,yintpt]= srplems(y_win,loc,Fs,usb,lsb);
    figure(h),imagesc(yintpt'),axis xy;
    finalpos_total = [finalpos_total;finalpos];
    
    
    % [tau_est,R,lags] = gccphat(y_win(:,2:end),y_win(:,1),Fs);
    %
    % figure
    % plot(1000*lags,real(R(:,1)))
    % xlabel('Lag Times (ms)')
    % ylabel('Cross-correlation')
    % axis([-5,5,-.4,1.1])
    % hold on
    % plot(1000*lags,real(R(:,2)))
    % plot(1000*lags,real(R(:,3)))
    % hold off
    
    frame_cnt = frame_cnt + 1
end


