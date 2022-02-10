[//]: # (Title: Sound Localization using an UMA-8 Microphone Array
)
[//]: # (Author: Jose Maria Perez-Macias)
[//]: # (Tags: #sourcelocalization #spatialaudio #soundsourcelocalization #3Daudio)
[//]: # (Date: June 18, 2015)

# project_audio
Sound source Localization using an eigthicrophone Array


## Functions

>test_positions.m \
`needs data/test_positions_mic_check_[0-2].m4a (or its matlab version).
plots the positions of the microphone and the test file.`
`The right positioning was found to be in test_positions_mic_check_2.m4a`


!['Microphone positions test','title'](doc/img/microphone_positions.png)
> 
> 

---
Methods used in this project are stored in /methods. They stem from /ext but they are modified. srphat has been
modified to improve the performance significantly.
- /method_1: modified file is src/methods/method_1_classical/srpphat_jose_modified_1.m
- /method_2 uses a stochastic method

Main Scripts are
- method_1_2_estimate.m which creates the output for both methods.
- method_1_preliminarytest.m is testing the implementation of method_1 with my own audio sources and 
micrphone structure.

---
Utils/ store some auxiliary functions, such as specific functions for the UMA-8. 
- Get microphone positons: they are obtained from the datasheet.
- Play the movie,
- and save the movie output. 
 - Also it has the export script to export from .m4a to .mat which has been done in Mac, 
   but it should "maybe" work in Linux as well. I do not know. Data was recorded using a Mac
   because recording is seamless and driverless using a Mac.


## External Libraries used in this project.
(These has been modified)

- srplems: from a Silverman article https://se.mathworks.com/matlabcentral/fileexchange/24352-acoustic-source-localization-using-srp-phat?focused=5125898&tab=function
- srphat_jose: modified from  https://github.com/carabiasjulio/SourceLocalization

## Data description
described in /src/data/data_description.txt

## Video results
https://homepages.tuni.fi/jose.perez-macias/sound_localization.html

- car_macwebcam_video_3: recorded with MPP Retina 2015 and UMA8 @ 11khz
- car_macwebcam_video_2. recorded with a MBP2010 13inch and UMA8 @ 11khz

http://www.cs.tut.fi/~perezmac/video3i.avi
http://www.cs.tut.fi/~perezmac/video2i.avi
