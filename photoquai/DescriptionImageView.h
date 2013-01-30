//
//  DescriptionImageView.h
//  PHQ
//
//  Created by Jean-Louis Danielo on 18/12/12.
//  Copyright (c) 2012 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotographerVignette.h"

@interface DescriptionImageView : UIView <UIScrollViewDelegate>{
    
    NSString *title;
    NSString *description;

    NSString *place;
    
    CGFloat start;
    BOOL directionUp;
}

@property (nonatomic, strong) UIScrollView *photographyDatas;
@property (nonatomic, strong) PhotographerVignette *photographerVignette;


//Constructeur
- (id)initWithFrame:(CGRect)frame description:(NSString*)aDescription title:(NSString*)aTitle place:(NSString*)aPlace withId:(int)anId;

//Getters
- (NSString *) title;
- (NSString *) description;
//- (NSString *) place;
//- (NSDate *)   date;

//Setters (Méthodes)
- (void) setTitle:(NSString*) aTitle;
- (void) setDescription:(NSString*) aDescription;
- (void) setPlace:(NSString*) aPlace;
- (void) setDate:(NSString*) aDate;

@end
