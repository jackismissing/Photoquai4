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
#import "SliderImage.h"
#import "FavoritePhotographerViewController.h"
#import "SliderViewController.h"

#import <MapKit/MapKit.h>
#import "PinLocation.h"

#define METERS_PER_MILE 1069.344


@interface PhotographerViewController : UIViewController <MFMailComposeViewControllerDelegate, UIScrollViewDelegate>{
    UIButton *favouriteButton;
    BOOL shareIsHidden;
    
    NSNumber *idPhotographer;
    
    NSUserDefaults *preferencesUser;
    NSMutableArray *favoritesPhotographers;
    NSArray *oldFavorites;
    
    NSString *patronymPhotographer;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    CustomPopOver *popOver; //Share options
    UIScrollView *myScrollView;
    
    BOOL photographerLocationIsVisible;
    UIView *contentUnderPhotographerPicture;
    MKMapView *photographerLocationMap;
    float myScrollViewHeight;
    UIButton *photographerLocalisationButton;
    UITextView *descriptionPhotographer;
    UIButton *displayFullDescriptionButton;
    UIView *sliderContent;
    SliderImage *sliderImages;
    
    CGRect frame; //Réelle hauteur de la textView
    
    BOOL descriptionIsFull;
    
    NSArray *photographerPicturesIds;
    NSArray *photographerPictures;
}

@property (nonatomic, assign) int idPhotographer;

@end
