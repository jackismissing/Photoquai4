//
//  ArtistFavoriteElement.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 23/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ArtistFavoriteElement.h"

@implementation ArtistFavoriteElement

- (id)initWithFrame:(CGRect)frame withId:(int)anId
{
    self = [super initWithFrame:frame];
    if (self) {

        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //récupération de données
        NSString *appendLink = @"http://phq.cdnl.me/api/fr/photographers/";
        appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", anId]];
        appendLink = [appendLink stringByAppendingString:@".json"];
        
        NSString *imgPhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.cover.link_thumbnail9784"];
        NSArray *imgsPhotographerArray = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.pictures"]; //Array des images du photographes
        
        int randomImgPhotographer = arc4random() % [imgsPhotographerArray count];
        
        
        NSString *imgsPhotographer = [[imgsPhotographerArray objectAtIndex:randomImgPhotographer] valueForKeyPath:@"link_iphone"];
        
        NSString *firstnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.firstname"];
        NSString *lastnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.lastname"];
        NSString *patronymPhotographer = [[NSString alloc] initWithString:firstnamePhotographer];
        patronymPhotographer = [patronymPhotographer stringByAppendingString:@" "];
        patronymPhotographer = [patronymPhotographer stringByAppendingString:lastnamePhotographer];
        

        self.tag = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.id"] integerValue];
        //[self setIdGlobal:anId];
        
        UIImageView *photographerFirstPhotography = [[UIImageView alloc] init];
        [photographerFirstPhotography setImageWithURL:[NSURL URLWithString:imgsPhotographer] placeholderImage:[UIImage imageNamed:@"etoilejaune"]];
        photographerFirstPhotography.frame = CGRectMake(0, 0, 150, 115);
        photographerFirstPhotography.opaque = YES;
        photographerFirstPhotography.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:photographerFirstPhotography];
        
        CALayer *bottomBorderImageWallElement = [CALayer layer];
        bottomBorderImageWallElement.frame = CGRectMake(0.0f, photographerFirstPhotography.frame.size.height, photographerFirstPhotography.frame.size.width, 2.0f);
        bottomBorderImageWallElement.backgroundColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        [photographerFirstPhotography.layer addSublayer:bottomBorderImageWallElement];
        
        UIImageView *artistPhotography = [[UIImageView alloc] init];
        [artistPhotography setImageWithURL:[NSURL URLWithString:imgPhotographer] placeholderImage:[UIImage imageNamed:@"etoilejaune"]];
        artistPhotography.opaque = YES;
        artistPhotography.contentMode = UIViewContentModeRedraw;
        artistPhotography.frame = CGRectMake(37.5, photographerFirstPhotography.frame.size.height - 47.5, 90, 90);
        
        
        UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 70, 70)];
        //apply path to shapelayer
        CAShapeLayer *borderPath = [CAShapeLayer layer];
        borderPath.path = aPath.CGPath;
        [borderPath setFillColor:[UIColor clearColor].CGColor];
        [borderPath setStrokeColor:[UIColor whiteColor].CGColor];
        borderPath.lineWidth = 3;
        borderPath.frame = CGRectMake(37.5, photographerFirstPhotography.frame.size.height - 47.5, 70, 70);
        
        //add shape layer to view's layer
        [[self layer] addSublayer:borderPath];
        [aPath closePath];
        [self setClippingPath:aPath clippingPath:artistPhotography];
    
        [photographerFirstPhotography addSubview:artistPhotography];
        
        
        UILabel *titleImageFavorite = [[UILabel alloc] init];
        titleImageFavorite.frame = CGRectMake(15, photographerFirstPhotography.frame.size.height + photographerFirstPhotography.frame.origin.y + 25, self.frame.size.width, 20);
        titleImageFavorite.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
        titleImageFavorite.numberOfLines = 2;
        //titleImageFavorite.lineBreakMode = NSLineBreakByCharWrapping;
        titleImageFavorite.text = patronymPhotographer;
        titleImageFavorite.clipsToBounds = YES;
        titleImageFavorite.textColor = [UIColor blackColor];
        titleImageFavorite.backgroundColor = [UIColor clearColor];
        
        [titleImageFavorite sizeToFit];
        [self addSubview:titleImageFavorite];
        
        float selfHeight = photographerFirstPhotography.frame.size.height + photographerFirstPhotography.frame.origin.y + titleImageFavorite.frame.size.height + titleImageFavorite.frame.origin.y;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, selfHeight - 90);
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor r:233 g:233 b:233 alpha:1].CGColor;
        self.layer.borderWidth = 2;
        
        UITapGestureRecognizer *accessPhotographer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPhotographer:)];
        [self addGestureRecognizer:accessPhotographer];
        
    }
    return self;
}

- (void)accessPhotographer:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accessPhotographer" object:[NSNumber numberWithInt:index.tag]];
}

- (void) setClippingPath:(UIBezierPath *)clippingPath clippingPath:(UIImageView *)imgView{
    
    if (![[imgView layer] mask])
        [[imgView layer] setMask:[CAShapeLayer layer]];
    
    [(CAShapeLayer*) [[imgView layer] mask] setPath:[clippingPath CGPath]];
}

- (void) setIdColonne:(int) anIdColonne{
    idColonne = anIdColonne;
}

- (int) idColonne{
    return idColonne;
}

- (void) setIdGlobal:(int) anIdGlobal{
    idGlobal = anIdGlobal;
}

- (int) idGlobal{
    return idGlobal;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}
 */


@end
