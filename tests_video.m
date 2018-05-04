%% Import video file

Filename = 'test.mov'
%videoFReader = vision.VideoFileReader(Filename)
[y, Fs] = audioread(Filename);


y = y/32768;

% Normalization
for i = 1 : 7
    y(:,i)= y(:,i)./max(y(:,i));
end

soundsc(y(10*Fs:20*Fs,3))


