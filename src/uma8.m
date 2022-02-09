classdef uma8
    
    properties
        
        loc = [ 0    0.0422    0.0211   -0.0211   -0.0422   -0.0211    0.0211;
            0         0   -0.0366   -0.0366   -0.0000    0.0366    0.0366;
            0         0         0         0         0         0         0]';
        
        
    end
    
    methods
        function obj = uma8()
            obj.loc(:,1)=-loc(:,1)+obj.;
            obj.loc(:,2)=-loc(:,2);
        end
        
        function [y, fs] = readAudio(obj)
            [y, fs] = audioread(Filename);
            y = y/32768; % Normalization (not sure if this is necesary)
            y=y(:,1:7);
            
        end
        function r = read_audio_video(obj,n)
            [y, fs] = audioread(Filename);
            videoReader = VideoReader(Filename);
            videoPlayer = vision.VideoPlayer;
            fps = get(videoReader, 'FrameRate');
            
        end
        
        
    end
end