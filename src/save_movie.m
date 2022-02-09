function save_movie(F, output_filename)
% F variable obtained with getframe, it is an structure of the shape
% F.cdata and F.colormap
% output_filename = 'string with .avi ending'
% Example of use: save_movie(F,'test_movie1.avi');
% Other saving formats is possible but it depends on the platform (e.g.
% mp4)

% Advanced Audio Processing
% Jose Maria Perez-Macias 2018

if(nargin < 2)
    output_filename = 'out.avi';
end

% this is an alternative way of playing the movie
% figure
% axes('Position',[0 0 1 1]) % This is necesary otherwise it does not paly
% well
% movie(F,5)

%% Set up the movie.
writerObj = VideoWriter(output_filename);

writerObj.FrameRate = 60; % How many frames per second.
open(writerObj);

fId= figure;
axes('Position',[0 0 1 1])

for i=1:size(F,2)
    
    figure(fId); % Makes sure you use your desired frame.
    
    % if mod(i,4)==0, % Uncomment to take 1 out of every 4 frames.
    imagesc(F(i).cdata);
    frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
    writeVideo(writerObj, frame);
    %end
    
end

hold off
close(writerObj); % closes object and saves the movie.

end

