//
//  PhotographerVignette.m
//  PHQ
//
//  Created by Jean-Louis Danielo on 09/01/13.
//  Copyright (c) 2013 Jean-Louis Danielo. All rights reserved.
//

#import "PhotographerVignette.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+RVB255.h"
#import <QuartzCore/QuartzCore.h>


@implementation PhotographerVignette

- (id)initWithFrame:(CGRect)frame withId:(int)anId
{
    self = [super initWithFrame:frame];
    if (self) {
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        //self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        
        [self drawRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        
        //Données du photographe
        NSString *appendLink = @"http://phq.cdnl.me/api/fr/photographers/";
        appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", anId]];
        appendLink = [appendLink stringByAppendingString:@".json"];
        
        
        NSString *imgPhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.cover.link_thumbnail9784"];
    
        
        NSString *firstnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.firstname"];
        NSString *lastnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.lastname"];
        NSString *patronymPhotographer = [[NSString alloc] initWithString:firstnamePhotographer];
        patronymPhotographer = [patronymPhotographer stringByAppendingString:@" "];
        patronymPhotographer = [patronymPhotographer stringByAppendingString:lastnamePhotographer];
        
        self.tag = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.id"] intValue];
        imageView = [[UIImageView alloc] init];
        
        NSLog(@"%@", [appdelegate getElementsFromJSON:appendLink]);
        
        imageView.opaque = YES;
        imageView.clipsToBounds = YES;

        imageView.contentMode = UIViewContentModeRedraw;
        imageView.frame = CGRectMake(10, 10, 75, 75);
        imageView.backgroundColor = [UIColor cyanColor];
        [imageView setImageWithURL:[NSURL URLWithString:imgPhotographer] placeholderImage:[UIImage imageNamed:@"navigationBar"]];
        imageView.layer.shadowColor = [UIColor purpleColor].CGColor;
        imageView.layer.shadowOffset = CGSizeMake(0, 1);
        imageView.layer.shadowOpacity = 1;
        imageView.layer.shadowRadius = 1.0;
        imageView.clipsToBounds = NO;
            
        UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 75, 75)];
        [aPath closePath];
        [self setClippingPath:aPath clippingPath:imageView];
        
        [self addSubview:imageView];
        
        float photographerPatronymX = imageView.frame.origin.x + imageView.frame.size.width + 13;
        UILabel *photographerPatronym = [[UILabel alloc] initWithFrame:CGRectMake(photographerPatronymX, 25, 25, 15)];
        photographerPatronym.text = patronymPhotographer;
        photographerPatronym.font = [UIFont fontWithName:@"Parisine-Bold" size:12.0];
        [photographerPatronym sizeToFit];
        //titre.adjustsFontSizeToFitWidth = YES;
        photographerPatronym.backgroundColor = [UIColor clearColor];
        [self addSubview:photographerPatronym];
        
        float photographerCountryY = photographerPatronym.frame.size.height + photographerPatronym.frame.origin.y + 9;
        UILabel *photographerCountry = [[UILabel alloc] initWithFrame:CGRectMake(photographerPatronymX, photographerCountryY, 25, 15)];
        photographerCountry.text = @"Groland";
        photographerCountry.font = [UIFont fontWithName:@"Parisine-Regular" size:12.0];
        [photographerCountry sizeToFit];
        //titre.adjustsFontSizeToFitWidth = YES;
        photographerCountry.backgroundColor = [UIColor clearColor];
        [self addSubview:photographerCountry];
        
        UIImage *imageArrow = [UIImage imageNamed:@"arrowArtistVignette"];
        float imageArrowWidth = imageArrow.size.width;
        float imageArrowHeight = imageArrow.size.height;
        
        float arrowPhotographerDataAccessX = photographerPatronymX + photographerPatronym.frame.size.width + 40;
        UIImageView *arrowPhotographerDataAccess = [[UIImageView alloc] init];
        arrowPhotographerDataAccess.frame = CGRectMake(arrowPhotographerDataAccessX, ((self.frame.size.height - imageArrowHeight) / 2), imageArrowWidth, imageArrowHeight);
        [arrowPhotographerDataAccess setImage:[UIImage imageNamed:@"arrowArtistVignette"]];
        [self addSubview:arrowPhotographerDataAccess];
        
        
//        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeAndHoldFrom:)];
//        longPressRecognizer.delegate = self;
//        longPressRecognizer.cancelsTouchesInView = NO;
//        [longPressRecognizer setMinimumPressDuration:0.5];
//        [self addGestureRecognizer:longPressRecognizer];
        
        //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        //[self addGestureRecognizer:singleTap];
        
    }
    return self;
}


- (void) setClippingPath:(UIBezierPath *)clippingPath clippingPath:(UIImageView *)imgView{
    
    if (![[imgView layer] mask])
        [[imgView layer] setMask:[CAShapeLayer layer]];
    
    [(CAShapeLayer*) [[imgView layer] mask] setPath:[clippingPath CGPath]];
}

- (NSString*) lastname{
    return lastname;
}

- (NSString*) firstname{
    return firstname;
}

- (int) idPhotographer{
    return idPhotographer;
}

- (void) setLastname:(NSString*)aLastname{
    lastname = aLastname;
}

- (void) setFirstname:(NSString*)aFirstname{
    firstname = aFirstname;
}

- (void) setIdPhotographer:(int)anIdPhotographer{
    idPhotographer = anIdPhotographer;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(25, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
}


@end
