//
//  ToolBarFavorites.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ToolBarFavorites.h"

@implementation ToolBarFavorites

@synthesize photosFavoritesLabel;
@synthesize photographersFavoritesLabel;

@synthesize photographersFavoritesImage;
@synthesize photosFavoritesImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        
        [self drawRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth, 100)];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //self.backgroundImage = [UIImage imageNamed:@"toolBarFavorites"];
    self.clipsToBounds = YES;
    UIImage *image = [UIImage imageNamed: @"toolBarFavorites"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    int viewWidth = 138;
    int marginTop = 0;
    UIFont *formatLabels = [UIFont fontWithName:@"Parisine-Regular" size:11.0f];
    
    CGRect labelFrame = CGRectMake(0, 25, 55, 15);
    
#pragma mark - Photographies tab
    UIView *photosFavoritesView = [[UIView alloc] initWithFrame:CGRectMake(11, marginTop, viewWidth, 72)];
    photosFavoritesView.tag = 0;
    photosFavoritesView.clipsToBounds = YES;
    photosFavoritesView.backgroundColor = [UIColor clearColor];
    
    photosFavoritesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favoris-photos-on"]];
    photosFavoritesImage.frame = CGRectMake((photosFavoritesView.frame.size.width - 29) / 2, 10, 29, 15);
    photosFavoritesImage.contentMode = UIViewContentModeScaleAspectFill;
    
    //NSString *myText = @"Informations";
    
    
    float photosFavoritesLabelY = photosFavoritesImage.frame.origin.y + photosFavoritesImage.frame.size.height + 10;
    photosFavoritesLabel = [[UILabel alloc] initWithFrame:labelFrame];
    photosFavoritesLabel.text = @"Photographies";
    photosFavoritesLabel.font = formatLabels;
    photosFavoritesLabel.textColor = [UIColor whiteColor];
    photosFavoritesLabel.shadowColor = [UIColor blackColor];
    photosFavoritesLabel.shadowOffset = CGSizeMake(0, -1);
    photosFavoritesLabel.backgroundColor = [UIColor clearColor];
    photosFavoritesLabel.frame = CGRectMake((photosFavoritesView.frame.size.width - photosFavoritesLabel.frame.size.width) / 2, photosFavoritesLabelY, 55, 15);
    [photosFavoritesLabel sizeToFit];
    
    UITapGestureRecognizer *favoritesPhotographiesPage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFavoriteType:)];
    [photosFavoritesView addGestureRecognizer:favoritesPhotographiesPage];
    
    [photosFavoritesView sizeToFit];
    
    [photosFavoritesView addSubview:photosFavoritesLabel];
    [photosFavoritesView addSubview:photosFavoritesImage];

#pragma mark - Photographes tab
    //float photographersFavoritesViewX = photosFavoritesView.frame.size.width + photosFavoritesView.frame.origin.x;
    UIView *photographersFavoritesView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth - (viewWidth + 15), marginTop, viewWidth, 72)];
    photographersFavoritesView.tag = 1;
    photographersFavoritesView.clipsToBounds = YES;
    photographersFavoritesView.backgroundColor = [UIColor clearColor];
    
    photographersFavoritesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"favoris-artistes-off"]];
    photographersFavoritesImage.frame = CGRectMake((photosFavoritesView.frame.size.width - 29) / 2, 10, 29, 15);
    photographersFavoritesImage.contentMode = UIViewContentModeScaleAspectFill;
    
    //NSString *myText = @"Informations";
    float photographersFavoritesLabelY = photographersFavoritesImage.frame.origin.y + photographersFavoritesImage.frame.size.height + 10;
    photographersFavoritesLabel = [[UILabel alloc] initWithFrame:labelFrame];
    photographersFavoritesLabel.text = @"Photographies";
    photographersFavoritesLabel.font = formatLabels;
    photographersFavoritesLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    photographersFavoritesLabel.shadowColor = [UIColor blackColor];
    photographersFavoritesLabel.shadowOffset = CGSizeMake(0, -1);
    photographersFavoritesLabel.backgroundColor = [UIColor clearColor];
    photographersFavoritesLabel.frame = CGRectMake(15 - (photographersFavoritesImage.frame.size.width - photographersFavoritesLabel.frame.size.width) / 2, photographersFavoritesLabelY, 55, 15);
    [photographersFavoritesLabel sizeToFit];
    
    
    UITapGestureRecognizer *favoritesPhotographersPage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFavoriteType:)];
    [photographersFavoritesView addGestureRecognizer:favoritesPhotographersPage];
    
    [photographersFavoritesView sizeToFit];
    
    [photographersFavoritesView addSubview:photographersFavoritesLabel];
    [photographersFavoritesView addSubview:photographersFavoritesImage];
    
    [self addSubview:photosFavoritesView];
    [self addSubview:photographersFavoritesView];
}



- (void)selectFavoriteType:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    
    //NSLog(@"index : %i", index.tag);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setPageFavorites" object:[NSNumber numberWithInt:index.tag]];
}




@end
