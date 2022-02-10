% Demo tests
% Jose Maria Perez-Macias Martin 2018

close all, clear all
addpath ext/srplems
addpath utils/

%% Settings
mic_loc = get_uma8_settings(15);

%%
if(strcmp(computer,'MACI64'))
elseif(strcmp(computer,'PCWIN64'))
    disp('audioread with uma8 is not working properly on windows 7 using the video')
    %     Filename = 'data\car_macwebcam_video_3.mov.mat'
    %         Filename = 'data\calibration_beep.mov.mat'
    Filename = 'data\car_macwebcam_video_3.mov.mat'
    load(Filename); % Loads y and fs.
    
    Filename = 'data\car_macwebcam_video_3.mov'
    videoReader = VideoReader(Filename);    
    disp(Filename)
    
elseif(isunix)
    Filename = 'data\car_macwebcam_video_3.mov'
    [y, fs] = audioread(Filename);
    videoReader = VideoReader(Filename);
    
else
    disp('The script might not work in this computer')
end


%% Search space
usb=[30 10 1]; lsb=[1 1 1];
% usb=[2 2 1]; lsb=[1 1 1];

% Settings for SR-PHAT for modified srphat_jose1.m
ngrid = 30;%  1810              % Number of TDoA to consider
win = 2048;                     % window size (for the spectrogram)
sp_resolution = 0.5;            % Resolution
window_to_analyze = 0.1;        % Length of the audioi signal to be analyzed. This is done on each frame


%%
% Reads audio
y=y(:,1:7); % I select the first 7 channels

% Reads video. Creates object
videoPlayer = vision.VideoPlayer;
fps = get(videoReader, 'FrameRate');

% Normalization
y = y / 32768; % Normalization
y=y(:,1:7); % I select the first channles. I am not sure what is the first channel.

disp('Frames per second of the video')
disp(fps); % the fps is correct: it's the same declared in the video file properties

h = figure('Renderer', 'painters', 'Position', [10 10 400 1000]);
% currAxes = axes;

%%
% Control loop
f_counter = 1;
loops = 5000;
F(loops) = struct('cdata',[],'colormap',[]);

% Parameters for the spectrogram
seconds = 0.2;
win_len = seconds * fs;
hop = floor(win_len/2);

% Spectrogram of the total signal
Stotal = [];
for i = 1: 7
    [S,f,t,p]   = spectrogram(y(:,i),hamming(win_len),hop,4096,fs);
    Stotal =[Stotal;S];
end
% figure,imagesc(t,f,log10(abs(S))) % for visualization purposes


% Main loop
while hasFrame(videoReader)
    
    vidFrame = readFrame(videoReader);
    subplot(511)
    image(vidFrame);
    currAxes.Visible = 'off';
    
    subplot(512)
    imagesc(t,f,log10(abs(S))) % for visualization purposes
    xlabel('Seconds')
    ylabel('Hz')
    title('Spectrogram')
    
    % Take a frame
    y_win = y(fix(videoReader.CurrentTime*fs):fix(videoReader.CurrentTime*fs+fs*window_to_analyze),:);
    
    % Estimate the SR-PHAT
    [finalpos,finalsrp, R]=srpphat_jose1(y_win, mic_loc, fs, lsb, usb,ngrid, win, sp_resolution );
    %[finalpos,finalsrp]=srpphat(y_win, mic_loc, fs, lsb, usb);
    
    if(1)
        
        subplot(513)        
        imagesc(R');axis xy;
        title(' Matrix R')
        
        % Display the source location, just xy coord to simplify
        room = zeros(usb(1),usb(2));
        for k=1:numel(finalsrp'),            
            room(round(finalpos(k,1)),round(finalpos(k,2)))=max(room(round(finalpos(k,1)),round(finalpos(k,2))),finalsrp(k));            
        end
        
        subplot(514)
        imagesc(room');axis xy;
        title('Room position SRP-PHAT')
        xlabel('meters')
        ylabel('meters')        
    end
    
    % Using the Stochastic Region Contraction Method
    room = zeros(usb(1),usb(2));
    [finalpos,finalsrp,finalfe,yintpt]= srplems(y_win,mic_loc,fs,lsb, usb);
    for k=1:numel(finalsrp'),        
        room(round(finalpos(k,1)),round(finalpos(k,2)))=max(room(round(finalpos(k,1)),round(finalpos(k,2))),finalsrp(k));        
    end

    
    subplot(515)
    imagesc(room');axis xy;
    title('Room position w/ SRP-PHAT stochastic region contraction')
    xlabel('meters')
    ylabel('meters')
    
    subplot(511)
    title(['Current Time ',num2str(videoReader.CurrentTime,2),' / ', num2str(videoReader.Duration,3), ' seconds'])
    
    drawnow
    
    % save to F make movie
    F(f_counter) = getframe(h);
    f_counter = f_counter+1;
end

date_string = datestr(now,30);
outfile = ['data',filesep,'restuls',filesep,'test_',datestring,'_','.avi'];
movie_save_framerate = 30;
save_movie(F,outfile, movie_save_framerate);



