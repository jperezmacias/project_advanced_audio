%% Saves the files in Matlab format to operate in Windows later on
% Jose Maria Perez-Macias
% Advanced Audio Processing. Tampere University of Technology

%% Saves the video files

name = '../data/';
extension = '*.mov';
listing = 	dir([name extension])

for i = 1 : length(listing)
    filename = [listing(i).folder,filesep,listing(i).name];
    disp(filename)
    [y, fs] = audioread(filename);
    videoReader = VideoReader(filename);
    save([filename,'.mat'], 'y', 'fs', 'videoReader')

end


%% Save the Audio Files
name = '../data/';
extension = '*.m4a';
listing = 	dir([name extension])

for i = 1 : length(listing)
    filename = [listing(i).folder,filesep,listing(i).name];
    disp(filename)
    [y, fs] = audioread(filename);
    save([filename,'.mat'], 'y', 'fs')
    % soundsc(y(:,1),fs)
end