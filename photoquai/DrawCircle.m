//
//  DrawCircle.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 19/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "DrawCircle.h"

@implementation DrawCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

	/* Draw a circle */
	// Get the contextRef
	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	
	// Set the border width
	CGContextSetLineWidth(contextRef, .5);
	
	// Remplit le cercle
	CGContextSetRGBFillColor(contextRef, 255.0, 255.0, 255.0, 1.0);
    
    CGGradientRef myGradient;
    
    CGColorSpaceRef myColorspace = NULL;
    
    size_t num_locations = 2;
    
    CGFloat locations[2] = { 0.0, 1.0 };
    
    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,  // Start color
        
        0.8, 0.8, 0.3, 1.0 }; // End color
    
    //myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      
                                                      locations, num_locations);
    
	CGContextDrawRadialGradient(contextRef, myGradient, CGPointMake(0, 5), 3.0, CGPointMake(4, 4), 2.0, kCGGradientDrawsAfterEndLocation);
	// Place le contour
	CGContextSetRGBStrokeColor(contextRef, 204.0/255.0, 204.0/255.0, 204.0/255.0, 1.0);
    
    //CGContextSetShadow(contextRef, CGSizeMake(1, 1), 3);
    //CGContextSetShadowWithColor(contextRef, CGSizeMake(1, 0), 1, [UIColor blackColor].CGColor);
	
	// Fill the circle with the fill color
	CGContextFillEllipseInRect(contextRef, rect);
	
	// Draw the circle border
	CGContextStrokeEllipseInRect(contextRef, rect);
}


@end
