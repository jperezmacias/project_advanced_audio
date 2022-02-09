function play_movie(F)
% F variable obtained with getframe, it is an structure of the shape
% F.cdata and F.colormap
% output_filename = 'string with .avi ending'
% Example of use: save_movie(F);


% Advanced Audio Processing
% Jose Maria Perez-Macias 2018

figure
axes('Position',[0 0 1 1])
movie(F,5)



