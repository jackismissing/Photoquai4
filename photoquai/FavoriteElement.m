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

        
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.opaque = YES;
        self.layer.borderColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        self.layer.borderWidth = 1.5;
        
        _imageWallElement = [[ImageWall alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 500)
                                               imageURL:anImageURL
                                               colonne:colonne];
        _imageWallElement.clipsToBounds = YES;
        
        //self.idColonne = [colonne integerValue];
        [self setIdColonne:[colonne integerValue]];
        
        
        CALayer *bottomBorderImageWallElement = [CALayer layer];
        bottomBorderImageWallElement.frame = CGRectMake(0.0f, _imageWallElement.height, _imageWallElement.frame.size.width, 1.0f);
        bottomBorderImageWallElement.backgroundColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        [_imageWallElement.layer addSublayer:bottomBorderImageWallElement];
        
        int height = [self.imageWallElement height];
        //int width = [self.imageWallElement width];
        
        [self addSubview:_imageWallElement];
        
        
        
        UILabel *titleImageFavorite = [[UILabel alloc] init];
        titleImageFavorite.frame = CGRectMake(10, _imageWallElement.height + _imageWallElement.y + 5, self.frame.size.width, 20);
        titleImageFavorite.font = [UIFont fontWithName:@"Parisine-Bold" size:15];
        titleImageFavorite.text = @"Titre";
        titleImageFavorite.textColor = [UIColor blackColor];
        titleImageFavorite.backgroundColor = [UIColor clearColor];
        [titleImageFavorite sizeToFit];
        [self addSubview:titleImageFavorite];
        
        _heightText = titleImageFavorite.frame.size.height;
        
        
        float selfHeight = _imageWallElement.height + titleImageFavorite.frame.size.height;
        //self.frame = CGRectMake(frame.origin.x, frame.origin.y, screenWidth * .4, 10);
        
        [self drawRect:CGRectMake(frame.origin.x, selfHeight, frame.size.width, height)];
        
        [self addSubview:titleImageFavorite];
    }
    return self;
}

- (int)idColonne{
    
    return idColonne;
}

- (void) setIdColonne:(int)anIdColonne{
    idColonne = anIdColonne;
}




- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor whiteColor];
}

@end
