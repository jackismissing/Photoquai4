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
    
	// Place le contour
	CGContextSetRGBStrokeColor(contextRef, 204.0/255.0, 204.0/255.0, 204.0/255.0, 1.0);
    
	// Fill the circle with the fill color
	CGContextFillEllipseInRect(contextRef, rect);
	
	// Draw the circle border
	CGContextStrokeEllipseInRect(contextRef, rect);
}


@end
