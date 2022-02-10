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

> `demo.m stft_multi.m srphat.m belong to a github.code `
---
>`demo_jose adapts the code for frames.`

>save_movie `Saves the `

>play_movie **

>mic_locs = get_uma8_settings()**


## Libraries

- srplems: from a Silverman article https://se.mathworks.com/matlabcentral/fileexchange/24352-acoustic-source-localization-using-srp-phat?focused=5125898&tab=function

- srphat_jose: modified from  https://github.com/carabiasjulio/SourceLocalization

## Classes
 uma8
 methods: 
 get_audio
 get_audio_video   

## Data
described in /src/data/data_description.txt

## Video results
http://www.cs.tut.fi/~perezmac/sound_localization.html

- car_macwebcam_video_3: recorded with MPP Retina 2015 and UMA8 @ 11khz
- car_macwebcam_video_2. recorded with a MBP2010 13inch and UMA8 @ 11khz

http://www.cs.tut.fi/~perezmac/video3i.avi
http://www.cs.tut.fi/~perezmac/video2i.avi
