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
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Parisine-Bold" size:0.0],
      UITextAttributeFont,
      nil]];
    
    
    //UIImage *backButtonImage = [[UIImage imageNamed:@"backButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(, 13, 0, 6)];
    //[[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
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

@end
