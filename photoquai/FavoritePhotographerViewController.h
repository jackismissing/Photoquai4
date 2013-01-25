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

@interface FavoritePhotographerViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>{
    BOOL removeEnabled;
    NSMutableArray *favoritesPhotographers;
    ArtistFavoriteElement *artistFavoriteElement;
    UIScrollView *myScrollView;
    
    UITapGestureRecognizer *selectFavorites2Remove;
    UITapGestureRecognizer *accessPhotographer;
    FakeActionSheet *fakeActionSheet;
  
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end
