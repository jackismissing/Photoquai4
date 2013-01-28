//
//  ArtistFavoriteElement.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 23/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIColor+RVB255.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"

@interface ArtistFavoriteElement : UIView{
    int idColonne;

}

- (id)initWithFrame:(CGRect)frame withId:(int)anId;

- (int) idColonne;


- (void) setIdColonne:(int) anIdColonne;


@end
