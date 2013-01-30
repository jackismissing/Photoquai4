//
//  PartenairesViewController.m
//  photoquai
//
//  Created by Nicolas on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "PartenairesViewController.h"

@interface PartenairesViewController ()

@end

@implementation PartenairesViewController

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
    
    //  /////////////////////////////////////////////////////////////////////////////////// Init des boutons /////////////////
    
    self.navigationItem.title = @"Partenaires";
    
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    UIImageView *creditsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"partenaires.jpg"]];
    
    scrollView.contentSize = CGSizeMake(creditsImage.frame.size.width, creditsImage.frame.size.height + self.navigationController.navigationBar.frame.size.height);
    
    
    [scrollView addSubview:creditsImage];
    
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
