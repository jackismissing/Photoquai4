//
//  FavoriteElement.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 19/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FavoriteElement.h"

@implementation FavoriteElement

- (id)initWithFrame:(CGRect)frame imageURL: (NSString*)anImageURL colonne:(NSNumber*)colonne
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.opaque = YES;
        self.layer.borderColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        self.layer.borderWidth = 2;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, screenWidth * .4, screenHeight);
        
        ImageWall *imageWallElement = [[ImageWall alloc] initWithFrame:self.frame imageURL:anImageURL colonne:colonne];
        CALayer *bottomBorderImageWallElement = [CALayer layer];
        bottomBorderImageWallElement.frame = CGRectMake(0.0f, 43.0f, imageWallElement.frame.size.width, 1.0f);
        bottomBorderImageWallElement.backgroundColor = [UIColor blackColor].CGColor;
        [imageWallElement.layer addSublayer:bottomBorderImageWallElement];
        
        [self addSubview:imageWallElement];
        
        UILabel *titleImageFavorite = [[UILabel alloc] init];
        titleImageFavorite.frame = CGRectMake(5, imageWallElement.height + imageWallElement.y + 5, self.frame.size.width, 20);
        titleImageFavorite.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
        
        [self addSubview:titleImageFavorite];
    }
    return self;
}

@end
