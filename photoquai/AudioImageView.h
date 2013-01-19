//
//  AudioImageView.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 18/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>

#import "UIColor+RVB255.h"
#import "DrawCircle.h"
#import "AppDelegate.h"

@interface AudioImageView : UIView <AVAudioPlayerDelegate>{
    DrawCircle *playPauseButton;
    UIImageView *playPauseButtonImage;
    NSTimer* playbackTimer;
    BOOL soundIsPlayed;
    
    UISlider *volumeSlider;
    MPMusicPlayerController *musicPlayer;
    UILabel *currentTime;
    UILabel *totalTime;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)aTitle;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) UILabel *truc;
@end
