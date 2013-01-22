//
//  FavoriteIndicator.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 21/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FavoriteIndicator.h"

@implementation FavoriteIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        background.backgroundColor = [UIColor r:0 g:1 b:0 alpha:.7];
        background.opaque = YES;
        background.userInteractionEnabled = NO;
        
        [self addSubview:background];
        
        content = [[UIView alloc] initWithFrame:CGRectMake(0, 7, screenWidth * .8, 130)];
        content.frame = CGRectMake((screenWidth - content.frame.size.width) / 2, 7, screenWidth * .8, 130);
        content.backgroundColor = [UIColor whiteColor];
        content.layer.cornerRadius = 3;
        content.clipsToBounds = YES;
        content.userInteractionEnabled = YES;
        
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, content.frame.size.height, content.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
        [content.layer addSublayer:bottomBorder];
        
        UIView *arrow = [[UIView alloc] initWithFrame:CGRectMake(content.frame.size.width - 20, 7, 33, 30)];
        arrow.backgroundColor = [UIColor whiteColor];
        // Rotate 90 degrees to hide it off screen
        CGAffineTransform rotationTransform = CGAffineTransformIdentity;
        rotationTransform = CGAffineTransformRotate(rotationTransform, 40);
        arrow.transform = rotationTransform;
        
        [content addSubview:arrow];
        [self addSubview:content];
        
        _message = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 200, 30)];

        _message.font = [UIFont fontWithName:@"Parisine-Bold" size:13.0f];
        _message.text = @"La photographie a été ajoutée aux favoris";
        _message.numberOfLines = 2;
        //[_message sizeToFit];
        _message.textColor = [UIColor blackColor];
        _message.backgroundColor = [UIColor clearColor];
        
        [content addSubview:_message];
        
        UITextView *subMessage = [[UITextView alloc] initWithFrame:CGRectMake(18, _message.frame.size.height + _message.frame.origin.y, content.frame.size.width * .8, 25)];
        subMessage.font = [UIFont fontWithName:@"Parisine-Regular" size: 9.0f];
        subMessage.text = @"Rendez-vous dans la catégorie “Favoris“ pour retouver votre séléction de photographies et d’artistes";
        subMessage.backgroundColor = [UIColor clearColor];
        subMessage.textColor = [UIColor blackColor];
        subMessage.editable = NO;
        
        [content addSubview:subMessage];
        
        CGRect frame = subMessage.frame;
        frame.size.height = subMessage.contentSize.height;
        frame.size.width = subMessage.contentSize.width;

        subMessage.frame = frame;
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setFrame:CGRectMake(25, subMessage.frame.size.height + subMessage.frame.origin.y + 5, content.frame.size.width * .8, 25.0)];
        [closeBtn setTitle:@"OK" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        closeBtn.userInteractionEnabled = YES;
        
        [closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        closeBtn.backgroundColor = [UIColor r:241 g:241 b:241 alpha:1];
        closeBtn.layer.borderColor = [UIColor r:0 g:0 b:236 alpha:1].CGColor;

        closeBtn.layer.borderWidth = 1.0f;
        closeBtn.layer.cornerRadius = 3.0f;
        
        [content addSubview:closeBtn];
    }
    return self;
}

- (void) setText:(NSString*)text{
    _message.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 
}
 
*/

- (void) hide{
    NSLog(@"okrefr");
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         content.transform = CGAffineTransformMakeScale(.1, .1);
                         content.alpha = 0;
                     }completion:^(BOOL finished){
                         [content removeFromSuperview];
                     }];
}

- (void) show{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         content.transform = CGAffineTransformMakeScale(1, 1);
                     }completion:^(BOOL finished){
                         content.alpha = 1;
                     }];
}


@end
