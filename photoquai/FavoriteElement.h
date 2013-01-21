//
//  FavoriteElement.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 20/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ImageWall.h"
#import "UIColor+RVB255.h"

@interface FavoriteElement : UIView{
    int idColonne;
}

- (id)initWithFrame:(CGRect)frame imageURL: (NSString*)anImageURL colonne:(NSNumber*)colonne;

@property (nonatomic, strong) ImageWall *imageWallElement;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) float heightText;

- (NSNumber *)idColonne;

@end
