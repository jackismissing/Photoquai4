//
//  FakeActionSheet.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FakeActionSheet.h"

@implementation FakeActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        self.frame = CGRectMake(frame.origin.x, screenHeight - 150, screenWidth, 100);
        self.backgroundColor = [UIColor r:35 g:35 b:35 alpha:1];
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, 0.0f, screenWidth, 2.0f);
        bottomBorder.backgroundColor = [UIColor r:46 g:46 b:46 alpha:1].CGColor;
        [self.layer addSublayer:bottomBorder];
        
        UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        removeButton.frame = CGRectMake(34, 17.0, screenWidth * .8, 53);
        //removeButton.titleLabel.text = @"Supprimer";
        [removeButton setTitle:@"Supprimer" forState:UIControlStateNormal];
        removeButton.titleLabel.font = [UIFont fontWithName:@"Parisine-Regular" size:17];
        [removeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; 
        removeButton.backgroundColor = [UIColor whiteColor];
        removeButton.layer.cornerRadius = 3.0f;
        [self addSubview:removeButton];
    }
    return self;
}

- (void) show{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    //[super.superview addSubview:self];
    [UIView animateWithDuration:0.42
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.frame = CGRectMake(0, screenHeight - 150, screenWidth, 100);
                     }
                     completion:^(BOOL finished){
                         [self addSubview:self];
                     }];
}

- (void) hide{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [UIView animateWithDuration:0.42
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.frame = CGRectMake(0, screenHeight, screenWidth, 100);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

@end
