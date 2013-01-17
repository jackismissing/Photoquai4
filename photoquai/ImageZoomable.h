//
//  ImageZoomable.h
//  PHQ
//
//  Created by Jean-Louis Danielo on 25/12/12.
//  Copyright (c) 2012 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageZoomable : UIScrollView <UIScrollViewDelegate, UIGestureRecognizerDelegate>{
    
    UIImageView *imageBig;
    BOOL    isZoomed;
    BOOL    navBarIsHide;
}

@property(nonatomic, readonly) UINavigationController *navigationController;

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
- (id)initWithImageView:(UIImage*)anImageURL;

@end
