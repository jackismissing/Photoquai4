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
    // 2 - Create sector label
	sectorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
	sectorLabel.textAlignment = UITextAlignmentCenter;
	[self.view addSubview:sectorLabel];
    // 3 - Set up rotary wheel
    rotaryWheel *wheel = [[rotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 240, 320)
                                                andDelegate:self
                                               withSections:6];
    wheel.center = CGPointMake(160, 120);
    wheel.backgroundColor = [UIColor grayColor];
    // 4 - Add wheel to view
    [self.view addSubview:wheel];
    
    // Add cancel button
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 250, 150, 20)];
    [cancelBtn addTarget:self action:@selector(dismissPage) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"Annuler" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:cancelBtn];
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
    
    if(selectedSection == 2) {
        
        //NSLog(@"2");
        
        
        
        InfoViewController *infoView = [[InfoViewController alloc] init];
        
        //UINavigationController *agendaNavigationController = [[UINavigationController alloc] initWithRootViewController:agendaView];
        
        //[agendaNavigationController setNavigationBarHidden:YES];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        
        
        [self.navigationController pushViewController:infoView animated:YES];
    }
    
    if(selectedSection == 3) {
        
        MapPhqViewController *mapView = [[MapPhqViewController alloc] init];
        
        //UINavigationController *agendaNavigationController = [[UINavigationController alloc] initWithRootViewController:agendaView];
        
        //[agendaNavigationController setNavigationBarHidden:YES];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        
        
        [self.navigationController pushViewController:mapView animated:YES];
    }
    
    if (selectedSection == 4) {
        //FavoritesPicturesViewController *favoritesPictures = [[FavoritesPicturesViewController alloc] init];
        //[self.navigationController pushViewController:favoritesPictures animated:YES];
        
        //ArtistsLisViewController *artistsView = [[ArtistsLisViewController alloc] init];
        //[self.navigationController pushViewController:artistsView animated:YES];
        

    FavoritePhotographerViewController  *favoritePhotograhers = [[FavoritePhotographerViewController alloc] init];
      [self.navigationController pushViewController:favoritePhotograhers animated:YES];

        
       // FavoritePhotographerViewController  *favoritePhotograhers = [[FavoritePhotographerViewController alloc] init];
        //[self.navigationController pushViewController:favoritePhotograhers animated:YES];

    }
     
     


}

- (void)dismissPage
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
