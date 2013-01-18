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
        UIView *sound = [[UIView alloc] initWithFrame:CGRectMake(0, soundY, screenWidth, 200)];
        CALayer *soundBottomBorder = [CALayer layer];
        soundBottomBorder.frame = CGRectMake(0.0f, sound.frame.size.height, self.frame.size.width, 1.0f);
        soundBottomBorder.backgroundColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        [self.layer addSublayer:soundBottomBorder];
        
#pragma mark - Audio Player
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"windwaker" ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        playPauseButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pause"]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
