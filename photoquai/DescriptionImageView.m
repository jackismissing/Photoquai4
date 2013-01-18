//
//  DescriptionImageView.m
//  PHQ
//
//  Created by Jean-Louis Danielo on 18/12/12.
//  Copyright (c) 2012 Jean-Louis Danielo. All rights reserved.
//

#import "DescriptionImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+RVB255.h"
#import "PhotographerVignette.h"

@implementation DescriptionImageView

- (id)initWithFrame:(CGRect)frame description:(NSString*)aDescription title:(NSString*)aTitle place:(NSString*)aPlace{
    
    self = [super initWithFrame:frame];
    if (self) {
        //self.userInteractionEnabled = YES;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, screenHeight)];
        container.backgroundColor = [UIColor whiteColor];
        container.alpha = 1;
        container.opaque = YES;
        CALayer *topBorder = [CALayer layer];
        
        UIScrollView *photographyDatas = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenHeight, screenHeight)];
        
        topBorder.frame = CGRectMake(0.0f, 0.0f, container.frame.size.width, 1.0f);
        
        topBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
        
        [container.layer addSublayer:topBorder];
        
        UILabel *titre = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 90, 42)];
        titre.font = [UIFont fontWithName:@"Parisine-Bold" size:15.0];
        titre.text = aTitle;
        [titre sizeToFit];
        //titre.adjustsFontSizeToFitWidth = YES;
        titre.backgroundColor = [UIColor clearColor];
        [photographyDatas addSubview:titre];
        
        UITextView *descripcion = [[UITextView alloc] initWithFrame:CGRectMake(18, titre.frame.size.height + 25, 260, 300)];
        
        descripcion.text = aDescription;
        descripcion.font = [UIFont fontWithName:@"Parisine-Regular" size:11.0];
        [descripcion sizeToFit];
        descripcion.editable = NO;
        //descripcion.textAlignment = 3;
        descripcion.backgroundColor = [UIColor clearColor];
        [photographyDatas addSubview:descripcion];
        
        
        UILabel *endroit = [[UILabel alloc] initWithFrame:CGRectMake(25, titre.frame.size.height + 15, 90, 15)];
        endroit.text = aPlace;
        endroit.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
        endroit.backgroundColor = [UIColor clearColor];
        //[container addSubview:endroit];
        
        float greyLineY = descripcion.frame.origin.y + descripcion.frame.size.height + 10;
        UIView *greyLine = [[UIView alloc] initWithFrame:CGRectMake(25, greyLineY, descripcion.frame.size.width, 1.0f)];
        greyLine.backgroundColor = [UIColor r:233 g:233 b:233 alpha:1];
        [container addSubview:greyLine];
        
        NSLog(@"%f", greyLine.frame.size.width);
        
        PhotographerVignette *photographerVignette = [[PhotographerVignette alloc] initWithFrame:CGRectMake(25, greyLineY + 20, greyLine.frame.size.width, 90) withId:5];
        photographerVignette.userInteractionEnabled = YES;
        [photographyDatas addSubview:photographerVignette];
        
        [photographyDatas setContentSize:CGSizeMake(200, 600 + 21)];

        photographyDatas.delegate = self;
        photographyDatas.userInteractionEnabled = YES;
        
        [container addSubview:photographyDatas];
        [self addSubview:container];
        
        [self setTitle:@"Pas de titre"];
        [self setDescription:@"Pas de description"];
        [self setDate:@"Holden Caulfield"];
        [self setPlace:@"windows8_ios"];
        
        self.frame = CGRectMake(0, screenHeight, 0, 0);
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [photographerVignette addGestureRecognizer:singleTap];
        
        
        
        //        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        //        singleTap.numberOfTapsRequired = 1;
        //        singleTap.numberOfTouchesRequired = 1;
        //        [self addGestureRecognizer: singleTap];
        //        self.userInteractionEnabled = YES;
        //        self.clipsToBounds = YES;
    }
    return self;
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"touch");
}

//Place le nom de la photo
- (void) setTitle:(NSString *)aTitle{
    
    title = aTitle;
}

- (void) setDescription:(NSString *)aDescription{
    
    description = aDescription;
}

- (void)setDate:(NSString *)aDate{

    //date = aDate;
}

-(void)setPlace:(NSString *)aPlace{
    
    place = aPlace;
}


//Getters
- (NSString *) title{

    return title;
}

- (NSString *) description{
    
    return description;
}

@end
