//
//  InfosPratiquesViewController.h
//  photoquai
//
//  Created by Nicolas on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PinLocation.h"

#define METERS_PER_MILE 1069.344

@interface InfosPratiquesViewController : UIViewController<UIScrollViewDelegate, MKMapViewDelegate>
{
    BOOL _doneInitialZoom;
}

@property(strong, nonatomic) UIScrollView *infoPratiqueScrollView;

@property(strong, nonatomic) UIView *menu;

@property(strong, nonatomic) UIButton *metroBtn;

@property(strong, nonatomic) UIButton *rerBtn;

@property(strong, nonatomic) UIButton *busBtn;

@property(strong, nonatomic) UIButton *velibBtn;

@property(strong, nonatomic) UIView *metroView;

@property(strong, nonatomic) UIView *rerView;

@property(strong, nonatomic) UIView *busView;

@property(strong, nonatomic) UIView *velibView;

@property(strong, nonatomic) MKMapView *mapView;

@property(strong, nonatomic) UIButton *closeBtn;



-(void)scrollToTransport : (id)sender;

-(void)viewMetro;

-(void)viewRer;

-(void)viewBus;

-(void)viewVelib;

-(void)showMap : (id)sender;

-(void)closeMap;



@end
