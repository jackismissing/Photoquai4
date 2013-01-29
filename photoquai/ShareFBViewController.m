//
//  ShareFBViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 29/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ShareFBViewController.h"

@interface ShareFBViewController ()

@end

@implementation ShareFBViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar-photographie"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"Partagez sur facebook";
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [cancelBtn addTarget:self action:@selector(dismissPage) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"closeMap"] forState:UIControlStateNormal];
    
    UIView *rightNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightNavigationButtons addSubview:cancelBtn];
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButtons];
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;
    
    
    self.postParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                       @"https://developers.facebook.com/ios", @"link",
                       @"http://phq.cdnl.me/data/images/cover-commissioner.jpg", @"picture",
                       @"facbook plz why you does not work properly", @"name",
                       @"Oui bonjour", @"caption",
                       @"rgege", @"description",
                       nil];
}

- (void)dismissPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
