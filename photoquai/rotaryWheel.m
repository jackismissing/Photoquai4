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
        
        //im.alpha = minAlphavalue;
        
        im.tag = i;
        
        if (i == 0) {
            
           // im.alpha = maxAlphavalue;
            
            [im setImage:[UIImage imageNamed:@"selection.png"]];
            
        }
		// 5 - Set sector image
        
        UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 43, 23, 30)];
        
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
    //[self addSubview:mask];
    
    // 8 - Initialize sectors
    sectors = [NSMutableArray arrayWithCapacity:numberOfSections];
    
    //NSLog(@"%d", numberOfSections);
    
    if (numberOfSections % 2 == 0) {
        [self buildSectorsEven];
    } else {
        [self buildSectorsOdd];
    }
    
    [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Photoquai 4"]:
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
    
    //NSLog(@"%f", deltaAngle);
    // 4 - Save current transform
    startTransform = container.transform;
    // 5 - Set current sector's alpha value to the minimum value
	UIImageView *im = [self getSectorByValue:currentSector];
	//im.alpha = minAlphavalue;
    
    [im setImage:[UIImage imageNamed:@"wheel_bottom.png"]];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    
    CGPoint pt = [touch locationInView:self];
    
    // 1.1 - Get the distance from the center
    
    float dist = [self calculateDistanceFromCenter:pt];
    
    // 1.2 - Filter out touches too close to the center
    
    if (dist < 40 || dist > 175)
    {
        
        // a drag path too close to the center
        NSLog(@"drag path too close to the center (%f,%f)", pt.x, pt.y);
        
        // here you might want to implement your solution when the drag
        // is too close to the center
        // You might go back to the clove previously selected
        // or you might calculate the clove corresponding to
        // the "exit point" of the drag.
    }
    
    

    
    
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    
    
    /////////////////////    /////////////////////    /////////////////////    ///////////////////// BATARD ! CONVERTI LES RADIANS EN DEG PUIS TESTE POUR AFFICHER LES LABELS EN FONCTION DU DÉPLACEMENT !! BG !!
    
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    
    CGFloat deg = radians * 57.2957795 ;
    
    // ON REMET TOUT DANS UN SYSTEME A 360 DEGRES !!
    
    if(deg < 0 ) {
        
        deg += 360;
    }
    
    
    
    if(deg < 330 && deg >= 270) {
        
        
        
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Catalogue"]:
             self.currentSector];
            

        
    } else if(deg < 270 && deg >= 210){
        
        
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Photographes"]:
             self.currentSector];
            

        
    } else if(deg < 210 && deg >= 150){
        
       
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Favoris"]:
             self.currentSector];
            

        
    } else if(deg < 150 && deg >= 90){
        
       
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Carte"]:
             self.currentSector];
            

    } else if(deg < 90 && deg >= 30){
        
       
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Informations"]:
             self.currentSector];
            

        
    } else {
        
        [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Photoquai 4"]:
         self.currentSector];
        
    }
   

    
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
		//NSLog(@"cl is %@", sector);
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
        //NSLog(@"cl is %@", sector);
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
            
            if (s.minValue > 0 && s.maxValue < 0) { // anomalous case
                
                if (s.maxValue > radians || s.minValue < radians) {
                    
                    if (radians > 0) { // we are in the positive quadrant
                        
                        newVal = radians - M_PI;
                        
                    } else { // we are in the negative one
                        
                        newVal = M_PI + radians;
                        
                    }
                    currentSector = s.sector;
                    
                }
                
            }
            
            else if (radians > s.minValue && radians < s.maxValue) {
                
                newVal = radians - s.midValue;
                currentSector = s.sector;
                
            }

    }
    // 7 - Set up animation for final rotation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    [UIView commitAnimations];
    
    /////////////////////    /////////////////////    /////////////////////    ///////////////////// BATARD ! CONVERTI LES RADIANS EN DEG PUIS TESTE POUR AFFICHER LES LABELS EN FONCTION DU DÉPLACEMENT !! BG !!
    

    
    CGFloat deg = radians * 57.2957795 ;
    
    // ON REMET TOUT DANS UN SYSTEME A 360 DEGRES !!
    
    if(deg < 0 ) {
        
        deg += 360;
    }
    

    
    if(deg < 330 && deg >= 270) {
        
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Catalogue"]:
             self.currentSector];
            
        });
        
    } else if(deg < 270 && deg >= 210){
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Photographes"]:
             self.currentSector];
            
        });
        
    } else if(deg < 210 && deg >= 150){
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Favoris"]:
             self.currentSector];
            
        });
        
    } else if(deg < 150 && deg >= 90){
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Carte"]:
             self.currentSector];
            
        });
    } else if(deg < 90 && deg >= 30){
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Informations"]:
             self.currentSector];
            
        });
        
    } else {
        
        [self.delegate wheelDidChangeValue:[NSString stringWithFormat:@"Photoquai 4"]:
         self.currentSector];
        
    }
    
    // 10 - Highlight selected sector
	UIImageView *im = [self getSectorByValue:currentSector];
    
    [im setImage:[UIImage imageNamed:@"selection.png"]];

    
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
