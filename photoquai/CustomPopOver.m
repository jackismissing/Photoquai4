//
//  CustomPopOver.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 19/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "CustomPopOver.h"

@implementation CustomPopOver

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //float contentY = arrow.frame.size.height + arrow.frame.origin.y;
        UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 100, 50)];
        content.backgroundColor = [UIColor whiteColor];
        content.layer.cornerRadius = 3;
        
        UIView *arrow = [[UIView alloc] initWithFrame:CGRectMake(content.frame.size.width - 30, 7, 30, 30)];
        arrow.backgroundColor = [UIColor whiteColor];
        // Rotate 90 degrees to hide it off screen
        CGAffineTransform rotationTransform = CGAffineTransformIdentity;
        rotationTransform = CGAffineTransformRotate(rotationTransform, 40);
        arrow.transform = rotationTransform;
        
        [self addSubview:arrow];
        [self addSubview:content];
        
        
        UIImage *facebookImage = [UIImage imageNamed:@"facebook"];
        UIButton *facebookShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [facebookShare setImage:facebookImage forState:UIControlStateNormal];
        facebookShare.frame = CGRectMake(0, ((facebookShare.frame.size.height - self.frame.size.height) / 2) + 10, facebookImage.size.width, facebookImage.size.height);
        [facebookShare addTarget:self action:@selector(sendFBImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:facebookShare];
        
        float mailX = facebookShare.frame.size.width + facebookShare.frame.origin.x + 10;
        UIImage *mailImage = [UIImage imageNamed:@"icon_mail_50"];
        UIButton *mailShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [mailShare setImage:mailImage forState:UIControlStateNormal];
        mailShare.frame = CGRectMake(mailX, ((mailShare.frame.size.height - self.frame.size.height) / 2) + 10, mailImage.size.width, mailImage.size.height);
        [mailShare addTarget:self action:@selector(mailShare) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mailShare];
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, content.frame.size.width, 100);
        [self sizeToFit];
        self.clipsToBounds = YES;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void) mailShare{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendMailImage" object:nil];
}

- (void) sendFBImage{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendFBImage" object:nil];
}

@end

