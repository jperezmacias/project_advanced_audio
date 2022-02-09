% Demo tests
% Jose Maria Perez-Macias Martin 2018

close all, clear all

addpath srplems

%% Settings
mic_loc = get_uma8_settings(15);

%%
if(strcmp(computer,'MACI64'))
elseif(strcmp(computer,'PCWIN64'))
    disp('audioread with uma8 is not working properly on windows 7 using the video')
    Filename = 'D:\Dropbox\TUT2018\AdvancedAudioProcessing\project_audio\video3i.mov'
elseif(isunix)
    Filename = '/media/jose/DATA/Dropbox/TUT2018/AdvancedAudioProcessing/project_audio/video2i.mov'
else
    disp('The script might not work in this computer')
end

%% Search space
usb=[30 30 5]; lsb=[1 1 1];

% Settings for SR-PHAT
ngrid = 30;%  1810                 % Number of TDoA to consider
win = 2048;                      % window size (for the spectrogram)
sp_resolution= 1;
window_to_analyze = 0.2;


%%
% Reads audio
[y, fs] = audioread(Filename);
y=y(:,1:7);

% Reads video
videoReader = VideoReader(Filename);
videoPlayer = vision.VideoPlayer;
fps = get(videoReader, 'FrameRate');

% Normalization
y = y/32768; % Normalization (not sure if this is necesary)
y=y(:,1:7); % I select the first channles. I am not sure what is the first channel.

disp('Frames per second of the video')
disp(fps); % the fps is correct: it's the same declared in the video file properties



h=figure
% currAxes = axes;

f_counter = 1;
loops = 5000;
F(loops) = struct('cdata',[],'colormap',[]);

while hasFrame(videoReader)
    
    vidFrame = readFrame(videoReader);
    subplot(511)
    image(vidFrame);
%     currAxes.Visible = 'off';
    
    subplot(512)
    [S] = spectrogram(y(videoReader.CurrentTime*fs:videoReader.CurrentTime*fs+fs*0.3,1),2048,512,win,fs);
    imagesc(log10(abs(S)))
    disp(videoReader.CurrentTime)
    title('Spectrogram')
    
    % Take a frame
    y_win = y(videoReader.CurrentTime*fs:videoReader.CurrentTime*fs+fs*window_to_analyze,:);
    
    % Estimate the SR-PHAT
    [finalpos,finalsrp, R]=srpphat_jose1(y_win, mic_loc, fs, lsb, usb,ngrid, win, sp_resolution );
    
    
    subplot(513)
    imagesc(R');axis xy;
    title('R')
    
    % Display the source location, just xy coord to simplify
    room = zeros(usb(1),usb(2));
    for k=1:numel(finalsrp'),
        
        room(round(finalpos(k,1)),round(finalpos(k,2)))=max(room(round(finalpos(k,1)),round(finalpos(k,2))),finalsrp(k));
        
    end
    
    subplot(514)
    imagesc(room');axis xy;
    title('Room position')
    
    
    
    subplot(515)
    
    [finalpos,finalsrp,finalfe,yintpt]= srplems(y_win,mic_loc,fs,usb,lsb);
    imagesc(yintpt'),axis xy;
    title('Silverman method')
    
    % Setting some sizes
x0=10;
y0=10;
width=400;
height=810;
set(gcf,'units','points','position',[x0,y0,width,height])


drawnow
    
    % save to F make movie
    F(f_counter) = getframe(h);
    f_counter = f_counter+1;
end

d = datestr(now,30);
outfile = ['test_',d,'_','.avi'];
save_movie(F,outfile);

%%

