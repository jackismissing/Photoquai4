//
//  SliderImage.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "SliderImage.h"


@implementation SliderImage

- (id)initWithImages:(NSArray*)arrayImages withIndexes:(NSArray*)arrayIndexes atPosition:(CGRect)frame
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.clipsToBounds = NO;
        
        for (int i = 0; i < [arrayImages count]; i++){
            
            CGRect dimension = CGRectMake(i * frame.size.width + 15, 0, self.frame.size.width, self.frame.size.height);
            //UIImage *theImage = [UIImage imageNamed:[arrayImages objectAtIndex:i]];
            //NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[arrayImages objectAtIndex:i]]];
            //UIImage *theImage = [UIImage imageWithData:imageData];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:dimension];
            imageView.opaque = YES;
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            NSInteger myInt = [[arrayIndexes objectAtIndex:i] intValue]; //Conversion object to NSInteger
            imageView.tag = myInt;
            
            //[imageView setImage:theImage];
            [imageView setImageWithURL:[NSURL URLWithString:[arrayImages objectAtIndex:i]]];
            imageView.userInteractionEnabled = true;
            imageView.exclusiveTouch = true;
            
            UITapGestureRecognizer *accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
            [imageView addGestureRecognizer:accessPicture];
            
            
            [self addSubview:imageView];
        }
        self.contentSize = CGSizeMake([arrayImages count]*frame.size.width, frame.size.height);
    }
    return self;
}


- (void)accessPicture:(UIGestureRecognizer *)gesture{
    UIView *index = gesture.view;
    //NSLog(@"%i", index.tag);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"accessPicture" object:[NSNumber numberWithInt:index.tag]];
}


- (int) fakeTag{
    return fakeTag;
}

- (void) setFakeTag:(int)aFakeTag{
    fakeTag = aFakeTag;
}

@end