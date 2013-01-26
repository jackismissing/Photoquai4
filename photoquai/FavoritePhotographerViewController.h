//
//  FavoritePhotographerViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 23/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtistFavoriteElement.h"
#import "FakeActionSheet.h"

@class ArtistFavoriteElement; 

@interface FavoritePhotographerViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, UITabBarControllerDelegate>{
    BOOL removeEnabled;
    NSMutableArray *favoritesPhotographers;
    NSMutableArray *favoritesToRemove;
    ArtistFavoriteElement *artistFavoriteElement;
    UIScrollView *myScrollView;
    
    UITapGestureRecognizer *selectFavorites2Remove;
    UITapGestureRecognizer *accessPhotographer;
    FakeActionSheet *fakeActionSheet;
  
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end
