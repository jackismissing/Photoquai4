//
//  DescriptionImageView.m
//  PHQ
//
//  Created by Jean-Louis Danielo on 18/12/12.
//  Copyright (c) 2012 Jean-Louis Danielo. All rights reserved.
//

#import "DescriptionImageView.h"
//#import "PhotographerVignette.h"

@implementation DescriptionImageView

- (id)initWithFrame:(CGRect)frame description:(NSString*)aDescription title:(NSString*)aTitle date:(NSDate*)aDate place:(NSString*)aPlace{
    
    self = [super initWithFrame:frame];
    if (self) {
        //self.userInteractionEnabled = YES;
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, screenHeight)];
        container.backgroundColor = [UIColor purpleColor];
        container.alpha = .9;
        container.opaque = YES;
        
        UILabel *titre = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 90, 42)];
        //titre.font = [UIFont fontWithName:@"Helvetica Neue" size:31.0];
        titre.text = aTitle;
        titre.adjustsFontSizeToFitWidth = YES;
        titre.backgroundColor = [UIColor clearColor];
        [container addSubview:titre];
        
        UITextView *descripcion = [[UITextView alloc] initWithFrame:CGRectMake(20, titre.frame.size.height + 30, 300, 300)];
        descripcion.text = aDescription;
        //Permet de fitter l'UITextView au contenu
        CGRect frame = descripcion.frame;
        frame.size.height = descripcion.contentSize.height;
        frame.size.width = 300;
//        frame.origin.x = 25;
//        frame.origin.y = titre.frame.size.height;
        //WithFrame:CGRectMake(25, titre.frame.size.height + 30, 300, 300)
        //Permet de fitter l'UITextView au contenu
        titre.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
        descripcion.frame = frame;
        descripcion.editable = NO;
        descripcion.textAlignment = 3;
        descripcion.backgroundColor = [UIColor clearColor];
        [container addSubview:descripcion];
        
        NSString *theDate = @"string";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        theDate = [dateFormatter stringFromDate:aDate];
        
        UILabel *jour = [[UILabel alloc] initWithFrame:CGRectMake(25, titre.frame.size.height + 15, 90, 15)];
        jour.text = theDate;
        jour.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
        jour.backgroundColor = [UIColor clearColor];
        [container addSubview:jour];
        
        UILabel *endroit = [[UILabel alloc] initWithFrame:CGRectMake(25, titre.frame.size.height + 15, 90, 15)];
        endroit.text = aPlace;
        endroit.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
        endroit.backgroundColor = [UIColor clearColor];
        //[container addSubview:endroit];
        
        PhotographerVignette *test = [[PhotographerVignette alloc] initWithFrame:CGRectMake(0, 0, 250, 50) withId:4];
        
        [container addSubview:test];
        
        [self addSubview:container];
        
        [self setTitle:@"Pas de titre"];
        [self setDescription:@"Pas de description"];
        [self setDate:@"Holden Caulfield"];
        [self setPlace:@"windows8_ios"];
        
        //        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        //        singleTap.numberOfTapsRequired = 1;
        //        singleTap.numberOfTouchesRequired = 1;
        //        [self addGestureRecognizer: singleTap];
        //        self.userInteractionEnabled = YES;
        //        self.clipsToBounds = YES;
    }
    return self;
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
