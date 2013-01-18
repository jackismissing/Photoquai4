//
//  MapPhqViewController.m
//  navigationWheel
//
//  Created by Nicolas on 16/01/13.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import "MapPhqViewController.h"


@interface MapPhqViewController ()
{
    MKPinAnnotationView *pinView;
    SMCalloutView *calloutView;
}

@end

@implementation MapPhqViewController

@synthesize mapView;
@synthesize pins;
@synthesize map;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Navigation bar
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"Plan";
    
    // Map image init
    
    
    map = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MAP_ok.png"]];
    
    map.userInteractionEnabled = YES;
    [map addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marsTapped)]];
    
    // Sroll view init
    
    mapView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mapView.minimumZoomScale=0.4;
    self.mapView.maximumZoomScale=6.0;
    self.mapView.contentSize=CGSizeMake(2070, 1508);
    self.mapView.clipsToBounds = YES;
    self.mapView.delegate=self;
    
    [mapView scrollRectToVisible:CGRectMake(1035, 754, self.view.frame.size.width, self.view.frame.size.height) animated:NO];
    
    [mapView addSubview:map];
    
    /* MapViewWrapper : usefull to add UIViews over the map (so it doesn't rescale)
     
     UIView *mapViewWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2070, 1508)];
     
     [mapViewWrapper addSubview:mapView];
     */
    
    [self.view addSubview:mapView];
    
    //self.mapView.zoomScale = 0.6;
    
    // Init Pins
    
    
    [self displayPins];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    //Réinstancie la navigation bar, une fois le menu disparu
    //self.navigationController.navigationBar.tintColor = [UIColor r:219 g:25 b:23 alpha:1];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage* image = [UIImage imageNamed:@"menu.png"];
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton *menuButton = [[UIButton alloc] initWithFrame:frame];
    [menuButton setBackgroundImage:image forState:UIControlStateNormal];
    //[menuButton setShowsTouchWhenHighlighted:YES];
    
    [menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* menuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    [self.navigationItem setLeftBarButtonItem:menuBarButtonItem];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayPins
{
    pins = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 10; i++)
    {
        /*
        UIImageView *pinImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin.png"]];
        UIView *pinView = [[UIView alloc] initWithFrame:CGRectMake(50 + 100*i, 100 + 100*i, 25, 35)];
         */
        
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@""];
        pinView.center = CGPointMake(50 + 100*i, 100 + 100*i);
        
        
        // Add frame
        
       // pinView.frame = CGRectMake(50 + 100*i, 100 + 100*i, 32, 39);
        
        NSLog(@"%@", NSStringFromCGRect(pinView.frame));
        
        [pinView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topPinTapped)]];
        [map addSubview:pinView];
        
        /*
        
        [pinView addSubview:pinImage];
        [pins insertObject:pinView atIndex:i];
        */
        
        UIButton *topDisclosure = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [topDisclosure addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disclosureTapped)]];
        
        calloutView = [SMCalloutView new];
        calloutView.delegate = self;
        calloutView.title = @"Artist";
        calloutView.rightAccessoryView = topDisclosure;
        calloutView.calloutOffset = pinView.calloutOffset;
    }
    
    
    for(id pin in pins)
    {
        
        NSLog(@"%@", pin);
        
        
    }
    
    

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    [self displayPins];
    return self.map;
    
}

- (void)topPinTapped {
    // show our callout if it's not already shown!
    // now in this example we're going to introduce an artificial delay in order to make our popup feel identical to MKMapView.
    // MKMapView has a delay after tapping so that it can intercept a double-tap for zooming. We don't need that delay but we'll
    // add it just so things feel the same.
    if (!calloutView.window)
        [self performSelector:@selector(popupCalloutView) withObject:nil afterDelay:1.0/3.0];
}

- (void)popupCalloutView {
    
    // This does all the magic.
    
    NSLog(@"%@", NSStringFromCGRect(pinView.frame));
    
    [calloutView presentCalloutFromRect:pinView.frame
                                 inView:map
                      constrainedToView:mapView
               permittedArrowDirections:SMCalloutArrowDirectionDown
                               animated:YES];
     
    
    // Here's an alternate method that adds the callout *inside* the pin view. This may seem strange, but it's how MKMapView
    // does it. It brings the selected pin to the front, then pops up the callout inside the pin's view. This way, the callout
    // is "anchored" to the pin itself. Visually, there's no difference; the callout still looks like it's floating outside the pin.
    
    // Note that this technique will require overriding -hitTest:withEvent inside the view containing the callout view, in order
    // to send touches to any accessory views of the callout. See this thread for more discussion: https://github.com/nfarina/calloutview/issues/9
    
    // You'll notice this example won't let you click on the blue disclosure button because we're not overriding -hitTest.
    
    //    [calloutView presentCalloutFromRect:topPin.bounds
    //                                 inView:topPin
    //                      constrainedToView:scrollView
    //               permittedArrowDirections:SMCalloutArrowDirectionDown
    //                               animated:YES];
}

- (NSTimeInterval)calloutView:(SMCalloutView *)theCalloutView delayForRepositionWithSize:(CGSize)offset {
    
    // Uncomment this to cancel the popup
    // [calloutView dismissCalloutAnimated:NO];
    
    [mapView setContentOffset:CGPointMake(mapView.contentOffset.x-offset.width, mapView.contentOffset.y-offset.height) animated:YES];
    
    return kSMCalloutViewRepositionDelayForUIScrollView;
}

- (void)disclosureTapped {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tap!" message:@"You tapped the disclosure button."
                                                   delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Whatevs",nil];
    [alert show];
}

- (void)marsTapped {
    // again, we'll introduce an artifical delay to feel more like MKMapView for this demonstration.
    [self performSelector:@selector(dismissCallout) withObject:nil afterDelay:1.0/3.0];
}

- (void)dismissCallout {
    [calloutView dismissCalloutAnimated:NO];
}

- (void)showMenu
{
    
    NavigationViewController *mainMenu = [[NavigationViewController alloc] init];
    mainMenu.delegate = self;
    
    // This is where you wrap the view up nicely in a navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainMenu];
    
    [navigationController setNavigationBarHidden:YES animated:NO];
    
    // You can even set the style of stuff before you show it
    //navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // And now you want to present the view in a modal fashion all nice and animated
    [self presentModalViewController:navigationController animated:YES];
    
    
    // [self presentModalViewController:mainMenu animated:YES];
    
}

@end
