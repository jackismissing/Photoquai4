//
//  ImageLocation.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 27/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ImageLocation.h"

@implementation ImageLocation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, frame.origin.y, screenWidth, screenHeight);
        self.clipsToBounds = YES;
        [self sizeToFit];
        
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 1.0f);
        topBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
        [self.layer addSublayer:topBorder];
        
        
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
