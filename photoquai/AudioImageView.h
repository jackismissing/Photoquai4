//
//  AudioImageView.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 18/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RVB255.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioImageView : UIView{
    UIImageView *playPauseButton;
    BOOL playPauseToggle;
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)aTitle;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end
