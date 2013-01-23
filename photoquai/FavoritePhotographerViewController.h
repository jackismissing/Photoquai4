//
//  FavoritePhotographerViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 23/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtistFavoriteElement.h"

@interface FavoritePhotographerViewController : UIViewController <UIScrollViewDelegate>{
    BOOL removeEnabled;
    NSArray *favoritesPhotographers;
}

@end
