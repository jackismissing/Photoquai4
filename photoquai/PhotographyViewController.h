//
//  PhotographyViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "ViewController.h"
#import "DescriptionImageView.h"
#import "ImageZoomable.h"
#import "AppDelegate.h"
#import "UIColor+RVB255.h"
#import "ToolBarPhotography.h"
#import "AudioImageView.h"
#import "CustomPopOver.h" //conteneur des boutons share
#import "FavoriteIndicator.h"
#import "FavoritesPicturesViewController.h"
#import "PhotographerViewController.h"
#import "ImageLocation.h"
#import "ShareFBViewController.h"
#import "FacebookPopOver.h"

@class AudioImageView;

@interface PhotographyViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate>{
    DescriptionImageView *descriptionPhotography;
    AudioImageView *audioDescription;

    ImageZoomable *picture;
    ToolBarPhotography *toolBar;
    BOOL elementsNavigationAreHidden;
    
    NSUserDefaults *preferencesUser;
    NSMutableArray *favoritesImages;
    NSArray *oldFavorites;
    
    UIButton *favouriteButton;
    NSNumber *idPicture;
    
    CustomPopOver *popOver;
    BOOL shareIsHidden;
    
    NSString *linkImg; //Lien de l'image;
    ImageLocation *imageLocation;
    
    
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    NSString *titleTextPhotography;
    
    NSInteger truc;
}

@property (nonatomic, assign) int idPicture;

- (void)addToFavorite;


@end
