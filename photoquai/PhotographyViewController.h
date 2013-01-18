//
//  PhotographyViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ViewController.h"
#import "DescriptionImageView.h"
#import "ImageZoomable.h"
#import "AppDelegate.h"
#import "UIColor+RVB255.h"

@interface PhotographyViewController : UIViewController <UIScrollViewDelegate>{
    DescriptionImageView *descriptionPhotography;
    ImageZoomable *picture;
}

@property (nonatomic, assign) int idPicture;


@end
