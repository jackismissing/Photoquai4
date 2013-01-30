//
//  NavigationViewController.m
//  photoquai
//
//  Created by Nicolas on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "NavigationViewController.h"
#import "rotaryWheel.h"
#import "InfoViewController.h"
#import "ViewController.h"
#import "MapPhqViewController.h"
#import "FavoritesPicturesViewController.h"
#import "ArtistsLisViewController.h"
#import "FavoritePhotographerViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

@synthesize sectorLabel;

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
    // 1 - Call super method
    [super viewDidLoad];
    
        [self setTitle:@"PHQ4"];
    
    // Pattern
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fondnoirtexture.png"]];
    
    // 2 - Create sector label
	sectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 30, 150, 30)];
	sectorLabel.textAlignment = UITextAlignmentCenter;
    
    sectorLabel.font = [UIFont fontWithName:@"Parisine" size:18];
    
    sectorLabel.textColor = [UIColor whiteColor];
    
    sectorLabel.backgroundColor = [UIColor clearColor];
    
    // Separator
    
    UIImageView *separator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"filetRougeAgenda.png"]];
    
    separator.center = CGPointMake(self.view.frame.size.width/2, sectorLabel.frame.origin.y + 65);
    
    [self.view addSubview:separator];
    
	[self.view addSubview:sectorLabel];
    // 3 - Set up rotary wheel
    rotaryWheel *wheel = [[rotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 227, 227)
                                                andDelegate:self
                                               withSections:6];
    wheel.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2 + 30);

    // 4 - Add wheel to view
    [self.view addSubview:wheel];
    
    UIImageView *contours = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contours.png"]];
    
    contours.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height/2 + 30);
    
    [self.view addSubview:contours];
    
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *buttonImage = [UIImage imageNamed:@"closeMap.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width + 20, buttonImage.size.height);
    [button addTarget:self action:@selector(dismissPage
                                            ) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = customBarItem;

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue :(int)selectedSection {
    
    
    self.sectorLabel.text = newValue;
    
    

    if(selectedSection == 1) {
        
        //NSLog(@"test");
                
        ViewController *catalogueView = [[ViewController alloc] init];
        [self.navigationController pushViewController:catalogueView animated:YES];
    }
    
    if(selectedSection == 5) {
        
        //NSLog(@"2");
        
        
        
        InfoViewController *infoView = [[InfoViewController alloc] init];
        
        //UINavigationController *agendaNavigationController = [[UINavigationController alloc] initWithRootViewController:agendaView];
        
        //[agendaNavigationController setNavigationBarHidden:YES];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        
        
        [self.navigationController pushViewController:infoView animated:YES];
    }
    
    if(selectedSection == 4) {
        
        MapPhqViewController *mapView = [[MapPhqViewController alloc] init];
        
        //UINavigationController *agendaNavigationController = [[UINavigationController alloc] initWithRootViewController:agendaView];
        
        //[agendaNavigationController setNavigationBarHidden:YES];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        
        
        [self.navigationController pushViewController:mapView animated:YES];
    }
    
    if (selectedSection == 2) {
        //FavoritesPicturesViewController *favoritesPictures = [[FavoritesPicturesViewController alloc] init];
        //[self.navigationController pushViewController:favoritesPictures animated:YES];
        
        ArtistsLisViewController *artistsView = [[ArtistsLisViewController alloc] init];
        [self.navigationController pushViewController:artistsView animated:YES];
        
//        FavoritePhotographerViewController  *favoritePhotograhers = [[FavoritePhotographerViewController alloc] init];
//        [self.navigationController pushViewController:favoritePhotograhers animated:YES];

        
       // FavoritePhotographerViewController  *favoritePhotograhers = [[FavoritePhotographerViewController alloc] init];
        //[self.navigationController pushViewController:favoritePhotograhers animated:YES];

    }
     
     


}

- (void)dismissPage
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
