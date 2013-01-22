//
//  AppDelegate.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h" //Permet de savoir si on est connecté ou non à Internet
#import "PhotographyViewController.h"
#import "FavoriteIndicator.h"
#import "CustomAlertView.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>{
    UITabBarController *tabBarController;
   
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, assign) float volume;


- (NSDictionary*) getElementsFromJSON:(NSString*)anURL;
- (void)showTabBar:(UITabBarController *) tabbarcontroller;
- (void)hideTabBar:(UITabBarController *) tabbarcontroller;

@end
