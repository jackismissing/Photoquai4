//
//  ImageWall.m
//  ImageWall
//
//  Created by Jean-Louis Danielo on 16/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ImageWall.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>


@implementation ImageWall

- (id)initWithFrame:(CGRect)frame imageURL: (NSString*)aImageURL colonne:(NSNumber*)colonne{

    self = [super initWithFrame:frame];
    if (self) {
        
        NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:aImageURL]];
        UIImage *normalImage = [UIImage imageWithData:imageData];
        int normalImageOriginalHeight = normalImage.size.height;
        int normalImageOriginalWidth = normalImage.size.width;
        
        float ratio = (frame.size.width * 100) / normalImageOriginalWidth;
        normalImageNewHeight = (int) ((normalImageOriginalHeight * ratio) / 100);
        
        UIImageView *photograhyView = [[UIImageView alloc] init];
        [photograhyView setImageWithURL:[NSURL URLWithString:aImageURL] placeholderImage:[UIImage imageNamed:@"etoilejaune"]];
        photograhyView.alpha = 1;
        photograhyView.opaque = YES;
        photograhyView.frame = CGRectMake(0, 0, self.frame.size.width, normalImageNewHeight);
        
        idColonne = [colonne integerValue];
        self.userInteractionEnabled = YES;
        
        [self addSubview:photograhyView];
    }
    return self;
}


- (NSNumber *)idColonne{
    
    return [NSNumber numberWithInt:idColonne];
}

- (int) height {
    
    height = normalImageNewHeight;
    return height;
}

- (int) width {
    
    width = self.frame.size.width;
    return width;
}

- (int) y {
    
    y = self.frame.origin.y;
    return y;
}

- (int) x {
    
    x = self.frame.origin.x;
    return x;
}




@end
