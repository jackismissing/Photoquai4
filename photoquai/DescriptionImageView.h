//
//  DescriptionImageView.h
//  PHQ
//
//  Created by Jean-Louis Danielo on 18/12/12.
//  Copyright (c) 2012 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionImageView : UIView{
    
    NSString *title;
    NSString *description;
    NSDate   *date;
    NSString *place;
    
    CGFloat start;
    BOOL directionUp;
}

//Constructeur
- (id)initWithFrame:(CGRect)frame description:(NSString*)description title:(NSString*)title date:(NSDate*)date place:(NSString*)place;

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
