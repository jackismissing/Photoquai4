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

#import "UIColor+RVB255.h"
#import "DrawCircle.h"

@interface AudioImageView : UIView <AVAudioPlayerDelegate>{
    DrawCircle *playPauseButton;
    UIImageView *playPauseButtonImage;
    NSTimer* playbackTimer;
    BOOL soundIsPlayed;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)aTitle;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end
