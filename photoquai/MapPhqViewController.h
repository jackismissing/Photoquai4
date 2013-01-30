//
//  MapPhqViewController.h
//  navigationWheel
//
//  Created by Nicolas on 16/01/13.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SMCalloutView.h"
#import "NavigationViewController.h"

@interface MapPhqViewController : UIViewController <UIScrollViewDelegate, MKMapViewDelegate, MKAnnotation, SMCalloutViewDelegate>

@property (nonatomic, strong) UIScrollView *mapView;
@property (nonatomic, strong) NSMutableArray *pins;
@property (nonatomic, strong) UIImageView *map;

- (void)displayPins;

- (void)showMenu;

- (void)popUpTapped : (id)sender;

@end
