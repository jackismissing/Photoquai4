//
//  AudioImageView.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 18/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "AudioImageView.h"



@implementation AudioImageView

- (id)initWithFrame:(CGRect)frame title:(NSString*)aTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, screenWidth, frame.size.height);
        
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 1.0f);
        topBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
        [self.layer addSublayer:topBorder];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 90, 42)];
        title.font = [UIFont fontWithName:@"Parisine-Bold" size:15.0];
        title.text = aTitle;
        [title sizeToFit];
        title.backgroundColor = [UIColor clearColor];
        [self addSubview:title];
        
        float soundY = title.frame.size.height + title.frame.origin.y + 15;
        UIView *sound = [[UIView alloc] initWithFrame:CGRectMake(0, soundY, screenWidth, 150)];
        sound.userInteractionEnabled = YES;
        sound.clipsToBounds = YES;
        sound.backgroundColor = [UIColor clearColor];
        CALayer *soundBottomBorder = [CALayer layer];
        soundBottomBorder.frame = CGRectMake(0.0f, sound.frame.size.height, self.frame.size.width, 1.0f);
        soundBottomBorder.backgroundColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        [self.layer addSublayer:soundBottomBorder];
        
        //Progression rouge du son
        progressSound = [[DrawRect alloc] initWithFrame:CGRectMake(0, 4, screenWidth-2, 66)];
        progressSound.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1];
        
        //Background color noir des ondes sonores
        DrawRect *blackBackgroundSound = [[DrawRect alloc] initWithFrame:CGRectMake(0, 4, screenWidth, 66)];
        blackBackgroundSound.backgroundColor = [UIColor blackColor];
        [sound addSubview:blackBackgroundSound];
        
        
        UIImageView *soundWaves = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ondesSonores"]];
        soundWaves.frame = CGRectMake(0, 0, screenWidth, 75);
        soundWaves.contentMode = UIViewContentModeScaleAspectFit;
        soundWaves.backgroundColor = [UIColor clearColor];
        soundWaves.userInteractionEnabled = YES;
        
        //        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        //        longPressRecognizer.minimumPressDuration = 1.5;
        //        longPressRecognizer.numberOfTouchesRequired = 1;
        //        [soundWaves addGestureRecognizer:longPressRecognizer];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(directionPan:)];
        [soundWaves addGestureRecognizer:panRecognizer];
        
        [sound addSubview:progressSound]; //Le background rouge de progression est derrière le .png
        [sound addSubview:soundWaves];
        
        
        [self addSubview:sound];
        
#pragma mark - Audio Player
        AudioSessionInitialize (NULL, NULL, NULL, (__bridge void *)self);
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
        
        NSData *soundFileData;
        soundFileData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"windwaker.mp3" ofType:NULL]]];
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:soundFileData error:NULL];
        _audioPlayer.delegate = self;
        
        playPauseButtonY = sound.frame.size.height + 15;
        
        //Cercle du bouton
        playPauseButton = [[DrawCircle alloc] initWithFrame:CGRectMake(20, playPauseButtonY, 50, 50)];
        playPauseButton.userInteractionEnabled = YES;
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPausePlayer)];
        [playPauseButton addGestureRecognizer:oneTap];
        [self addSubview:playPauseButton];
        
        //Image Play/pause
        playPauseButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playrouge"]];
        playPauseButtonImage.frame = CGRectMake(35, playPauseButtonY + 13, 25, 25);
        playPauseButtonImage.userInteractionEnabled = YES;
        //playPauseButtonImage.backgroundColor = [UIColor redColor];
        playPauseButtonImage.contentMode = UIViewContentModeScaleAspectFit;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPausePlayer)];
        [playPauseButtonImage addGestureRecognizer:singleTap];
        
        [self addSubview:playPauseButtonImage];
        
        playbackTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLeft:) userInfo:nil repeats:YES];
        
        volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(playPauseButton.frame.size.width + 55, playPauseButtonY + 13, 180, 10)];
        [volumeSlider addTarget:self action:@selector(soundLevel:) forControlEvents:UIControlEventValueChanged];
        volumeSlider.maximumTrackTintColor = [UIColor purpleColor];
        volumeSlider.thumbTintColor = [UIColor grayColor];
        volumeSlider.continuous = NO;
        volumeSlider.minimumValue = 0.0;
        volumeSlider.maximumValue = 1;
        
        //On change le bouton du slider
        UIImage *sliderThumb = [UIImage imageNamed:@"sliderButton"];
        [volumeSlider setThumbImage:sliderThumb forState:UIControlStateNormal];
        [volumeSlider setThumbImage:sliderThumb forState:UIControlStateHighlighted];
        
        //On change de background
        UIImage *sliderMinimum = [[UIImage imageNamed:@"sliderBackground"] stretchableImageWithLeftCapWidth:4 topCapHeight:0];
        [volumeSlider setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal];
        UIImage *sliderMaximum = [[UIImage imageNamed:@"sliderBackground"] stretchableImageWithLeftCapWidth:4 topCapHeight:0];
        [volumeSlider setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal];
        
        [self addSubview:volumeSlider];
        
        UIImageView *hautParleurs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hautparleurs"]];
        hautParleurs.frame = CGRectMake(volumeSlider.frame.origin.x - 20, playPauseButtonY + 15, 15, 15);
        hautParleurs.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:hautParleurs];
        
        UIImageView *hautParleursForts = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hautparleursforts"]];
        hautParleursForts.frame = CGRectMake(volumeSlider.frame.origin.x + volumeSlider.frame.size.width + 10, playPauseButtonY + 15, 15, 15);
        hautParleursForts.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:hautParleursForts];
        
        //AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
        //musicPlayer.volume = appdelegate.volume;
        //volumeSlider.value = musicPlayer.volume;
        
        currentTime = [[UILabel alloc] initWithFrame:CGRectMake(15, sound.frame.size.height - sound.frame.origin.y - 20, 120, 30)];
        currentTime.font = [UIFont fontWithName:@"Parisine-Regular" size:15];
        currentTime.textColor =  [UIColor r:214 g:41 b:48 alpha:1];
        currentTime.backgroundColor = [UIColor clearColor];
        [sound addSubview:currentTime];
        
        
        totalTime = [[UILabel alloc] initWithFrame:CGRectMake(265, sound.frame.size.height - sound.frame.origin.y - 20, 120, 30)];
        totalTime.font = [UIFont fontWithName:@"Parisine-Regular" size:15];
        totalTime.textColor = [UIColor r:102 g:102 b:102 alpha:1];
        totalTime.backgroundColor = [UIColor clearColor];
        [sound addSubview:totalTime];
        
        
        soundIsPlayed = NO; //L'audio n'est pas joué par défaut;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    }
    return self;
}

//Gestion du seek personnalisé
- (void)directionPan:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self];        
    progressSound.frame = CGRectMake(0, 4, point.x, progressSound.frame.size.height);
    _audioPlayer.currentTime = (point.x * _audioPlayer.duration) / 318;
    
    NSTimeInterval timeLeft = self.audioPlayer.currentTime;
    float min = (int) timeLeft/60;
    float sec = (int) timeLeft % 60;
    
    currentTime.text = [NSString stringWithFormat:@"%02.0f:%02.0f", min, sec];
}

- (void) moveRight{
    NSLog(@"pk");
}

-  (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
//    else if (sender.state == UIGestureRecognizerStateBegan){
//        NSLog(@"UIGestureRecognizerStateBegan.");
//        //Do Whatever You want on Began of Gesture
//    }
}

//Met à jour en temps réel le temps restant
- (void)updateTimeLeft:(NSTimer*)timer
{
    NSTimeInterval timeLeft = self.audioPlayer.currentTime;
    NSTimeInterval totalTimeSound = self.audioPlayer.duration;
    float min = (int) timeLeft/60;
    float sec = (int) timeLeft % 60;
    
    int minTotal = (int) totalTimeSound/60;
    int secTotal = (int) totalTimeSound % 60;
    
    // update your UI with timeLeft
    currentTime.text = [NSString stringWithFormat:@"%02.0f:%02.0f", min, sec];
    totalTime.text = [NSString stringWithFormat:@"%02d:%d", minTotal, secTotal];
    [currentTime sizeToFit];
    [totalTime sizeToFit];
    
    float progressSoundWidth = (320 * _audioPlayer.currentTime) / _audioPlayer.duration;
    
    progressSound.frame = CGRectMake(0, 4, progressSoundWidth, progressSound.frame.size.height);
}


- (void)soundLevel:(UIControlEvents *)gesture{
    
    [musicPlayer setVolume: volumeSlider.value];
}

- (void)volumeChanged:(NSNotification *)notification
{
    float volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];

    [volumeSlider setValue: volume];
}


- (void) playPausePlayer {
    
    if(soundIsPlayed == YES){
        soundIsPlayed = NO;
        [_audioPlayer pause];
        playPauseButtonImage.image = [UIImage imageNamed:@"playrouge"];
        playPauseButtonImage.frame = CGRectMake(35, playPauseButtonY + 13, 25, 25);
    }else{
        soundIsPlayed = YES;
        [_audioPlayer play];
        playPauseButtonImage.image = [UIImage imageNamed:@"pauserouge"];
        playPauseButtonImage.frame = CGRectMake(33, playPauseButtonY + 13, 25, 25);
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    soundIsPlayed = NO;
    playPauseButtonImage.image = [UIImage imageNamed:@"playrouge"];
}

@end
