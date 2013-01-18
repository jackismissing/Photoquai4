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
#import "ToolBarPhotography.h"
#import "AudioImageView.h"

@interface PhotographyViewController : UIViewController <UIScrollViewDelegate>{
    DescriptionImageView *descriptionPhotography;
    AudioImageView *audioDescription;
    
    ImageZoomable *picture;
    ToolBarPhotography *toolBar;
    BOOL elementsNavigationAreHidden;
    
}

@property (nonatomic, assign) int idPicture;

- (void)addToFavorite;

@end
