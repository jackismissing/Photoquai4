//
//  SliderViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 28/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()

@end

@implementation SliderViewController

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar-photographie.png"] forBarMetrics:UIBarMetricsDefault];

    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, 150, 20)];
    [cancelBtn addTarget:self action:@selector(dismissPage) forControlEvents:UIControlEventTouchUpInside];
    //[cancelBtn setTitle:@"Annuler" forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"closeMap"] forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    SliderImage *sliderImage = [[SliderImage alloc] initWithImages:self.arrayImages withIndexes:self.arrayIndexes atPosition:CGRectMake(15, 42, screenWidth * .8, screenHeight - 100)];
    
    [self.view setOpaque:YES];
    [self.view setAlpha:.8];
    [self.view addSubview:sliderImage];
}

- (void)dismissPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
