//
//  PhotographerViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIColor+RVB255.h"
#import "CustomPopOver.h" //conteneur des boutons share
#import "AppDelegate.h"
#import "CustomPopOver.h"
#import "FavoritePhotographerViewController.h"

@interface PhotographerViewController : UIViewController<MFMailComposeViewControllerDelegate>{
    UIButton *favouriteButton;
    BOOL shareIsHidden;
    
    NSNumber *idPhotographer;
    
    NSUserDefaults *preferencesUser;
    NSMutableArray *favoritesPhotographers;
    NSArray *oldFavorites;
    
    NSString *patronymPhotographer;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    CustomPopOver *popOver;
}

@property (nonatomic, assign) int idPhotographer;

@end
