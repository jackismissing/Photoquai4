//
//  FavoritesPicturesViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 20/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FavoriteElement.h"
#import "AppDelegate.h"
#import "NavigationViewController.h"
#import "PhotographyViewController.h"

@interface FavoritesPicturesViewController : UIViewController <UIScrollViewDelegate>{
    NSArray *favoritesPictures;
}

@end
