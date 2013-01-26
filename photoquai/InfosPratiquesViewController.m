//
//  InfosPratiquesViewController.m
//  photoquai
//
//  Created by Nicolas on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "InfosPratiquesViewController.h"

@interface InfosPratiquesViewController ()

@end

@implementation InfosPratiquesViewController
{
    CGFloat width;
}

@synthesize infoPratiqueScrollView;
@synthesize menu;
@synthesize metroBtn;
@synthesize rerBtn;
@synthesize busBtn;
@synthesize velibBtn;

@synthesize metroView;
@synthesize rerView;
@synthesize busView;
@synthesize velibView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        width = self.view.frame.size.width;
        
        //  ////////////////////////////////////////////////////////////////////////////////// Init la scroll view //////////////////
        
        infoPratiqueScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 102, width, 1500)];
        infoPratiqueScrollView.contentSize = CGSizeMake(4 * width, 1500);
        infoPratiqueScrollView.scrollEnabled = NO;
        infoPratiqueScrollView.contentOffset = CGPointMake(0,0);
        
        [self.view addSubview:infoPratiqueScrollView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue metro /////////////////
        
        metroView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1500)];
        
        UILabel *donald = [[UILabel alloc] initWithFrame:CGRectMake(width/2, 200, width, 30)];
        donald.text = @"Donald";
        [metroView addSubview:donald];
        
        [infoPratiqueScrollView addSubview:metroView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue rer /////////////////
        
        rerView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, 1500)];
        
        UILabel *riri = [[UILabel alloc] initWithFrame:CGRectMake(width/2, 200, width, 30)];
        riri.text = @"Riri";
        [rerView addSubview:riri];
        
        [infoPratiqueScrollView addSubview:rerView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue bus /////////////////
        
        busView = [[UIView alloc] initWithFrame:CGRectMake(2*width, 0, width, 1500)];
        
        UILabel *fifi = [[UILabel alloc] initWithFrame:CGRectMake(width/2, 200, width, 30)];
        fifi.text = @"Fifi";
        [busView addSubview:fifi];
        
        [infoPratiqueScrollView addSubview:busView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue velib /////////////////
        
        velibView = [[UIView alloc] initWithFrame:CGRectMake(3*width, 0, width, 1500)];
        
        UILabel *connard = [[UILabel alloc] initWithFrame:CGRectMake(width/2, 200, width, 30)];
        connard.text = @"Connasse";
        [velibView addSubview:connard];
        
        [infoPratiqueScrollView addSubview:velibView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init du menu /////////////////
        
        menu = [[UIView alloc] initWithFrame:CGRectMake(15, 82, 290, 35)];
        
        UIImageView *fondMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blocnoirinfospratiques.png"]];
        
        [menu addSubview:fondMenu];
        
        [self.view addSubview:menu];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init des boutons /////////////////
        
        self.navigationItem.title = @"Infos pratiques";
        
        self.navigationItem.hidesBackButton = YES;
        
        metroBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72.5, 35)];
        
        [metroBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        metroBtn.tag = 1;
        
        [self.menu addSubview:metroBtn];
        
        rerBtn = [[UIButton alloc] initWithFrame:CGRectMake(metroBtn.frame.size.width, 0, 72.5, 35)];
        
        [rerBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        rerBtn.tag = 2;
        
        [self.menu addSubview:rerBtn];
        
        busBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*metroBtn.frame.size.width, 0, 72.5, 35)];
        
        [busBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        busBtn.tag = 3;
        
        [self.menu addSubview:busBtn];
        
        velibBtn = [[UIButton alloc] initWithFrame:CGRectMake(3*metroBtn.frame.size.width, 0, 72.5, 35)];
        
        [velibBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        velibBtn.tag = 4;
    
        [self.menu addSubview:velibBtn];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Nav Bar /////////////////
        
        self.navigationItem.title = @"Infos pratiques";
        
        self.navigationItem.hidesBackButton = YES;

        

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //Réinstancie la navigation bar, une fois le menu disparu

    [super viewWillAppear:animated];
    
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = customBarItem;

    
    [self.infoPratiqueScrollView setShowsHorizontalScrollIndicator:NO];
    
    metroView.backgroundColor = [UIColor whiteColor];
    
    rerView.backgroundColor = [UIColor whiteColor];
    
    busView.backgroundColor = [UIColor whiteColor];
    
    velibView.backgroundColor = [UIColor whiteColor];

    
    [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
    
    [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
    
    [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];
    
    [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
    
    // Image on select
    
    [metroBtn setImage:[UIImage imageNamed:@"metro"] forState:UIControlStateHighlighted];
    
    [rerBtn setImage:[UIImage imageNamed:@"rerselect"] forState:UIControlStateHighlighted];
    
    [busBtn setImage:[UIImage imageNamed:@"busselect"] forState:UIControlStateHighlighted];
    
    [velibBtn setImage:[UIImage imageNamed:@"velibselect"] forState:UIControlStateHighlighted];

    
}

- (void)scrollToTransport:(id)sender
{
    NSInteger btnId = ((UIControl *) sender).tag;
    
    if(btnId == 1)
    {
        [metroBtn setImage:[UIImage imageNamed:@"metro"] forState:UIControlStateNormal];
        
        [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
        
        [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];
        
        [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
        
        [infoPratiqueScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if(btnId == 2)
    {
        [rerBtn setImage:[UIImage imageNamed:@"rerselect"] forState:UIControlStateNormal];

        [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
        
        [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];
        
        [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
        
        [infoPratiqueScrollView setContentOffset:CGPointMake(width, 0) animated:YES];

    }
    
    if(btnId == 3)
    {
        [busBtn setImage:[UIImage imageNamed:@"busselect"] forState:UIControlStateNormal];
        
        [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
        
        [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
        
        [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
        
        [infoPratiqueScrollView setContentOffset:CGPointMake(2*width, 0) animated:YES];

    }
    
    if(btnId == 4)
    {
        [velibBtn setImage:[UIImage imageNamed:@"velibselect"] forState:UIControlStateNormal];
        
        [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
        
        [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
        
        [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];

        [infoPratiqueScrollView setContentOffset:CGPointMake(3*width, 0) animated:YES];
        

    }
    
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
