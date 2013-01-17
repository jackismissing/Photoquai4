//
//  ImageZoomable.m
//  PHQ
//
//  Created by Jean-Louis Danielo on 25/12/12.
//  Copyright (c) 2012 Jean-Louis Danielo. All rights reserved.
//

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 3

#import "ImageZoomable.h"
#import "UIImageView+AFNetworking.h"

@implementation ImageZoomable

- (id)initWithImageView:(NSURL*)anImageURL
{
    self = [super init];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        //UIImage *PortraitImage = [[UIImage alloc] initWithCGImage: anImage.CGImage scale: 1.0 orientation: UIImageOrientationUp];
        
        imageBig = [[UIImageView alloc] init];
        [imageBig setImageWithURL:anImageURL placeholderImage:[UIImage imageNamed:@"stewie"]];
        imageBig.frame = CGRectMake(0, 0, screenWidth, screenHeight); //-43
        
        imageBig.contentMode = UIViewContentModeScaleAspectFit;

        imageBig.opaque = YES; //Performance
        
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        [self addSubview:imageBig];
        //self.minimumZoomScale = 1;
        self.maximumZoomScale = 3.0;
        
       // self.contentSize = CGSizeMake(anImage.size.width, anImage.size.width);
        self.delegate = self;
        
        [self setUserInteractionEnabled:YES];
        
        [self setMultipleTouchEnabled:YES];
        
        // add gesture recognizers to the image view
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        
        [doubleTap setNumberOfTapsRequired:2];
        [singleTap requireGestureRecognizerToFail:doubleTap]; //Fait échouer le single tap si on double tap
        
        [self addGestureRecognizer:singleTap];
        [self addGestureRecognizer:doubleTap];
        
        // calculate minimum scale to perfectly fit image width, and begin at that scale
        float minimumScale = [self frame].size.width  / [self frame].size.width;
        [self setMinimumZoomScale:minimumScale];
        [self setZoomScale:minimumScale];
        
        isZoomed = NO;
        navBarIsHide = NO;
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return imageBig;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [self setZoomScale:scale+0.01 animated:NO];
    [self setZoomScale:scale animated:NO];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    //NSLog(@"touch");
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    float newScale;
    
    if (isZoomed == NO) { //On zoome
        newScale = [self zoomScale] * ZOOM_STEP;
        isZoomed = YES;
    }else{ //On dézoome
        newScale = [self zoomScale] / ZOOM_STEP;
        isZoomed = NO;
    }
    
    CGRect zoomRect = [super.self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [self zoomToRect:zoomRect animated:YES];
}



#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width  = [self frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"rotate");
}


@end
