//
//  FavoriteIndicator.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 21/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIColor+RVB255.h"

@interface FavoriteIndicator : UIView{
    //UILabel *message;
    UIView *content;
}

- (void) show;
- (void) hide;

- (void) setText:(NSString*)text;


@property (nonatomic, strong) UILabel *message;

@end
