//
//  ToolBarFavorites.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RVB255.h"

@interface ToolBarFavorites : UITabBar

@property (nonatomic, strong) UIImageView *photosFavoritesImage;
@property (nonatomic, strong) UIImageView *photographersFavoritesImage;


@property (nonatomic, strong) UILabel *photographersFavoritesLabel;
@property (nonatomic, strong) UILabel *photosFavoritesLabel;


@end
