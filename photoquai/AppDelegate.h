//
//  AppDelegate.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "Reachability.h" //Permet de savoir si on est connecté ou non à Internet
#import "PhotographyViewController.h"
#import "FavoriteIndicator.h"
#import "CustomAlertView.h"

@class ViewController;
@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>{

}

extern NSString *const FBSessionStateChangedNotification;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, assign) float volume;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (NSDictionary*) getElementsFromJSON:(NSString*)anURL;


@end
