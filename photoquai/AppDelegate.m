//
//  AppDelegate.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "UIColor+RVB255.h"
#import "CustomAlertView.h"
#import "FavoritesPicturesViewController.h"
#import "FavoritePhotographerViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:self.viewController];
    //navigationController.navigationBar.tintColor = [UIColor r:219 g:25 b:23 alpha:1];

    //navigationController.navigationBarHidden = NO;
    
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    //Permet d'éditer le style du texte du navigation controller
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Parisine-Bold" size:0.0],
      UITextAttributeFont,
      nil]];
    
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(volumeChanged:)
        name:@"AVSystemController_SystemVolumeDidChangeNotification"
        object:nil];
    
    tabBarController = [[UITabBarController alloc] init];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        CustomAlertView *alert = [[CustomAlertView alloc]
                              initWithTitle:nil
                              message:@"Votre appareil n'est pas connecté à Internet. Pour profiter pleinement de l'expérience PHQ4, veuillez vous connecter à Internet."
                              delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        
        NSLog(@"There IS internet connection");
    }  
    
    UIViewController *v1 = [[FavoritesPicturesViewController alloc] initWithNibName:@"FavoritesPicturesViewController" bundle:nil];
    v1.tabBarItem.image = [UIImage imageNamed:@"favoritesPicturesIcon"];
    v1.tabBarItem.title = @"Photographies";
    
    UIViewController *v2 = [[FavoritePhotographerViewController alloc] initWithNibName:@"FavoritePhotographerViewController" bundle:nil];
    v2.tabBarItem.image = [UIImage imageNamed:@"favoritesPhotographersIcon"];
    v2.tabBarItem.title = @"Photographes";
    
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController, v1, v2, nil];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//Informe le changement du volume par le biais des boutons
- (void)volumeChanged:(NSNotification *)notification
{
    _volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSDictionary*) getElementsFromJSON:(NSString*)anURL{
    NSError *errorData;
    
    NSError *errorJsonParsing;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:anURL]];
    NSDictionary *arrayJson = nil;
    NSData* dataJson = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&errorData];
    
    if (errorData == nil) {
        
        arrayJson = [NSJSONSerialization JSONObjectWithData:dataJson options:0 error:&errorJsonParsing];
        
        if (errorJsonParsing != nil) {
            
            NSLog(@"Error Parse Json");
            //[self popUpErrorWithString:@"Erreur du serveur. Données erronées."];
        }
        
    }else{
        NSLog(@"Error Recuperation du Json");
        //[self popUpErrorWithString:@"Impossible de se connecter au serveur"];
        
    }
    
    return arrayJson;
}


// Method implementations
- (void)hideTabBar:(UITabBarController *) tabbarcontroller
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
        }
    }
    
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
            
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
        }
    }
    
    [UIView commitAnimations];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"THE 'NO' BUTTON WAS PRESSED");
    }
    if (buttonIndex == 1) {
        NSLog(@"THE 'YES' BUTTON WAS PRESSED");
    }
}


@end
