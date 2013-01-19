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
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor redColor];

        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];

        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, screenHeight, 320, self.frame.size.height);
        
        container.backgroundColor = [UIColor whiteColor];
        container.alpha = 1;
        container.opaque = YES;
        CALayer *topBorder = [CALayer layer];
        
        _photographyDatas = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        
        topBorder.frame = CGRectMake(0.0f, 0.0f, container.frame.size.width, 1.0f);
        
        topBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
        
        [container.layer addSublayer:topBorder];
        
        UILabel *titre = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 90, 42)];
        titre.font = [UIFont fontWithName:@"Parisine-Bold" size:15.0];
        titre.text = aTitle;
        [titre sizeToFit];
        //titre.adjustsFontSizeToFitWidth = YES;
        titre.backgroundColor = [UIColor clearColor];
        [_photographyDatas addSubview:titre];
        
        float endroitY = titre.frame.origin.y + titre.frame.size.height;
        UILabel *endroit = [[UILabel alloc] initWithFrame:CGRectMake(25, endroitY, 90, 15)];
        endroit.text = aPlace;
        endroit.font = [UIFont fontWithName:@"Parisine-Regular" size:11.0];
        [endroit sizeToFit];
        endroit.backgroundColor = [UIColor clearColor];
        [_photographyDatas addSubview:endroit];
        
        UITextView *descripcion = [[UITextView alloc] initWithFrame:CGRectMake(18, titre.frame.size.height + 35, 260, 300)];
        descripcion.text = aDescription;
        descripcion.font = [UIFont fontWithName:@"Parisine-Regular" size:11.0];
        [descripcion sizeToFit];
        descripcion.editable = NO;
        //descripcion.textAlignment = 3;
        descripcion.backgroundColor = [UIColor clearColor];
        [_photographyDatas addSubview:descripcion];
        
        
        
        float greyLineY = descripcion.frame.origin.y + descripcion.frame.size.height + 10;
        UIView *greyLine = [[UIView alloc] initWithFrame:CGRectMake(25, greyLineY, descripcion.frame.size.width, 1.0f)];
        greyLine.backgroundColor = [UIColor r:233 g:233 b:233 alpha:1];
        [_photographyDatas addSubview:greyLine];
        

        PhotographerVignette *photographerVignette = [[PhotographerVignette alloc] initWithFrame:CGRectMake(25, greyLineY + 20, greyLine.frame.size.width, 90) withId:5];
        photographerVignette.userInteractionEnabled = YES;
        [_photographyDatas addSubview:photographerVignette];
        
        float phographyDatasContentSize = photographerVignette.frame.size.height + photographerVignette.frame.origin.y + descripcion.frame.size.height + descripcion.frame.origin.y + endroit.frame.size.height + endroit.frame.origin.y + titre.frame.size.height + titre.frame.origin.y - 30;
        
        [_photographyDatas setContentSize:CGSizeMake(self.frame.size.width, phographyDatasContentSize)];

        _photographyDatas.delegate = self;
        _photographyDatas.userInteractionEnabled = YES;
        
        [container addSubview:_photographyDatas];
        [self addSubview:container];
        
        
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPhotographer:)];
        [photographerVignette addGestureRecognizer:singleTap];

    }
    return self;
}

- (void)accessPhotographer:(UIGestureRecognizer *)gesture{
    
    //On définit la méthode à appeler dans la vue l'appelant
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showArtistPage" object:[NSNumber numberWithInt:5]];
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
