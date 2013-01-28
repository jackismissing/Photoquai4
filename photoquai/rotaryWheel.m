//
//  rotaryWheel.m
//  photoquai
//
//  Created by Nicolas on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "rotaryWheel.h"


@interface rotaryWheel()
- (void)drawWheel;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildSectorsEven;
- (void) buildSectorsOdd;
- (UIImageView *) getSectorByValue:(int)value;
@end

static float deltaAngle;

@implementation rotaryWheel

static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@synthesize delegate, container, numberOfSections;
@synthesize startTransform;
@synthesize sectors;
@synthesize currentSector;


- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    // 1 - Call super init
    if ((self = [super initWithFrame:frame])) {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        // 3 - Draw wheel
        self.currentSector = 0;
        [self drawWheel];
        // 4 - auto rotate wheel
        /*
         [NSTimer scheduledTimerWithTimeInterval:2.0
         target:self
         selector:@selector(rotate)
         userInfo:nil
         repeats:YES];
         */
	}
    return self;
}

- (void) drawWheel {
    
    // 1
    
    container = [[UIView alloc] initWithFrame:self.frame];
    
    // 2
    
    CGFloat angleSize = 2*M_PI/numberOfSections;
    
    // 3 - Create the sectors
    
	for (int i = 0; i < numberOfSections; i++) {
        
        // 4 - Create image view
        
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wheel_bottom.png"]];
        
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        
                                        container.bounds.size.height/2.0-container.frame.origin.y);
        
        im.transform = CGAffineTransformMakeRotation(angleSize*i + M_PI/2);
        
        im.alpha = minAlphavalue;
        
        im.tag = i;
        
        if (i == 0) {
            
            im.alpha = maxAlphavalue;
            
        }
		// 5 - Set sector image
        
        UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 43, 23, 23)];
        
        sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        

        
        [im addSubview:sectorImage];
        
        // 6 - Add image view to container
        
        [container addSubview:im];
        
	}
    // 7
    
    container.userInteractionEnabled = NO;
    
    //container.backgroundColor = [UIColor redColor];
    
    [self addSubview:container];
    
    // 7.1 - Add background image
	UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
	bg.image = [UIImage imageNamed:@"bg.png"];
	//[self addSubview:bg];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    mask.image =[UIImage imageNamed:@"centerButton.png"] ;
    mask.center = self.center;
    mask.center = CGPointMake(mask.center.x, mask.center.y+3);
   // [self addSubview:mask];
    
    // 8 - Initialize sectors
    sectors = [NSMutableArray arrayWithCapacity:numberOfSections];
    if (numberOfSections % 2 != 0) {
        [self buildSectorsEven];
    } else {
        [self buildSectorsOdd];
    }
    
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]:
     self.currentSector];
    
}



- (void) rotate {
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -0.78);
    container.transform = t;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1 - Get touch position
    
    CGPoint touchPoint = [touch locationInView:self];
    
    // 1.1 - Get the distance from the center
    
    float dist = [self calculateDistanceFromCenter:touchPoint];
    
    // 1.2 - Filter out touches too close to the center
    
    if (dist < 50 || dist > 120)
    {
        // forcing a tap to be on the ferrule
        //NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    
    // 2 - Calculate distance from center
    float dx = touchPoint.x - container.center.x;
    float dy = touchPoint.y - container.center.y;
    // 3 - Calculate arctangent value
    deltaAngle = atan2(dy,dx);
    // 4 - Save current transform
    startTransform = container.transform;
    // 5 - Set current sector's alpha value to the minimum value
	UIImageView *im = [self getSectorByValue:currentSector];
	im.alpha = minAlphavalue;
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    //NSLog(@"rad is %f", radians);
    
    CGPoint pt = [touch locationInView:self];
    
    // 1.1 - Get the distance from the center
    
    float dist = [self calculateDistanceFromCenter:pt];
    
    // 1.2 - Filter out touches too close to the center
    
    if (dist < 40 || dist > 175)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", pt.x, pt.y);
        // 1 - Get current container rotation in radians
        CGFloat radians = atan2f(container.transform.b, container.transform.a);
        // 2 - Initialize new value
        CGFloat newVal = 0.0;
        // 3 - Iterate through all the sectors
        for (wheelSector *s in sectors) {
            // 4 - See if the current sector contains the radian value
            if (radians > s.minValue && radians < s.maxValue) {
                // 5 - Set new value
                newVal = radians - s.midValue;
                // 6 - Get sector number
                currentSector = s.sector;
                break;
            }
        }
        // 7 - Set up animation for final rotation
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
        container.transform = t;
        [UIView commitAnimations];
        
        [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]:
         self.currentSector];
        
        // 10 - Highlight selected sector
        UIImageView *im = [self getSectorByValue:currentSector];
        im.alpha = maxAlphavalue;
        
        return NO;
    }
    
    
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    return YES;
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (void) buildSectorsOdd {
	// 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
	// 2 - Set initial midpoint
    CGFloat mid = 0;
	// 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        wheelSector *sector = [[wheelSector alloc] init];
		// 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        mid -= fanWidth;
        if (sector.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
		// 5 - Add sector to array
        [sectors addObject:sector];
		NSLog(@"cl is %@", sector);
    }
}

- (void) buildSectorsEven {
    // 1 - Define sector length
    CGFloat fanWidth = M_PI*2/numberOfSections;
    // 2 - Set initial midpoint
    CGFloat mid = 0;
    // 3 - Iterate through all sectors
    for (int i = 0; i < numberOfSections; i++) {
        wheelSector *sector = [[wheelSector alloc] init];
        // 4 - Set sector values
        sector.midValue = mid;
        sector.minValue = mid - (fanWidth/2);
        sector.maxValue = mid + (fanWidth/2);
        sector.sector = i;
        if (sector.maxValue-fanWidth < - M_PI) {
            mid = M_PI;
            sector.midValue = mid;
            sector.minValue = fabsf(sector.maxValue);
            
        }
        mid -= fanWidth;
        NSLog(@"cl is %@", sector);
        // 5 - Add sector to array
        [sectors addObject:sector];
    }
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    // 1 - Get current container rotation in radians
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    // 2 - Initialize new value
    CGFloat newVal = 0.0;
    // 3 - Iterate through all the sectors
    for (wheelSector *s in sectors) {
        // 4 - See if the current sector contains the radian value
        if (radians > s.minValue && radians < s.maxValue) {
            // 5 - Set new value
            newVal = radians - s.midValue;
            // 6 - Get sector number
            currentSector = s.sector;
			break;
        }
    }
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    [UIView commitAnimations];
    
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"value is %i", self.currentSector]:
     self.currentSector];
    
    // 10 - Highlight selected sector
	UIImageView *im = [self getSectorByValue:currentSector];
	im.alpha = maxAlphavalue;
    
}

- (UIImageView *) getSectorByValue:(int)value {
    UIImageView *res;
    NSArray *views = [container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
}

@end
