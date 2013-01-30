//
//  FavorisPageViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToolBarFavorites.h"
#import "CustomAlertView.h"
#import "ArtistFavoriteElement.h"
#import "FakeActionSheet.h"
#import "PhotographyViewController.h"
#import "AppDelegate.h"
#import "NavigationViewController.h" //Menu
#import "FavoriteElement.h"

@interface FavorisPageViewController : UIViewController{
    NSMutableArray *favoritesPictures;
    NSMutableArray *favoritesPhotographers;
    NSMutableArray *favoritesToRemove;
    
    BOOL removeEnabled;
    int tabEnabled; //0 pour photos, 1 pour photographes
    
    UITapGestureRecognizer *selectFavorites2Remove;
    UITapGestureRecognizer *accessPicture;
    UITapGestureRecognizer *accessPhotographer;
    
    FakeActionSheet *fakeActionSheet;
    ArtistFavoriteElement *artistFavoriteElement;
    ToolBarFavorites *toolbarFavorites;
    
    UIScrollView *myScrollView;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end
