//
//  SliderViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 28/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SliderImage.h"

@interface SliderViewController : UIViewController{
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@property (nonatomic, strong) NSArray *arrayImages;
@property (nonatomic, strong) NSArray *arrayIndexes;

@end
