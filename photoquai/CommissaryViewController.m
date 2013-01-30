//
//  CommissaryViewController.m
//  photoquai
//
//  Created by Nicolas on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "CommissaryViewController.h"

@interface CommissaryViewController ()

@end

@implementation CommissaryViewController
@synthesize commissaryScrollView;
@synthesize commissaryCheatButton;
@synthesize infos;
@synthesize otherComissaries;
@synthesize isDisplayed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isDisplayed = NO;
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar-photographie.png"] forBarMetrics:UIBarMetricsDefault];
        
        self.title = @"Commissaires";
        
        UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:buttonImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = customBarItem;

        
        commissaryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        commissaryCheatButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
        
        [commissaryCheatButton setImage:[UIImage imageNamed:@"comissaryCheat.png"] forState:UIControlStateNormal];
        
        [commissaryCheatButton addTarget:self action:@selector(displayInfos) forControlEvents:UIControlEventTouchUpInside];
        
        [commissaryScrollView addSubview:commissaryCheatButton];
        
        infos = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comissaryInfos.png"]];
        
        infos.center = CGPointMake(self.view.frame.size.width / 2, commissaryCheatButton.frame.size.height + infos.frame.size.height / 2);
        
        [commissaryScrollView addSubview:infos];
        
        infos.transform = CGAffineTransformMakeScale(1, 0);
        
        otherComissaries = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"otherComissaries.png"]];
        
        otherComissaries.center = CGPointMake(self.view.frame.size.width / 2, commissaryCheatButton.frame.size.height + infos.frame.size.height + otherComissaries.frame.size.height / 2);
        
        [commissaryScrollView addSubview:otherComissaries];
        
        commissaryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, commissaryCheatButton.frame.size.height + infos.frame.size.height + otherComissaries.frame.size.height + 43);
        
        [self.view addSubview:commissaryScrollView];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayInfos
{
 
    if(isDisplayed == NO){
        
        infos.alpha = 0;
        infos.transform = CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{

                             otherComissaries.center = CGPointMake(self.view.frame.size.width / 2, commissaryCheatButton.frame.size.height + infos.frame.size.height + otherComissaries.frame.size.height / 2);
                             infos.alpha = 1;

                         }
                         completion:^(BOOL finished){}];

                isDisplayed = YES;
        
    } else {
        
        infos.alpha = 0;
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             
                             
                             infos.transform = CGAffineTransformMakeScale(1, 0);
                             
                             otherComissaries.center = CGPointMake(self.view.frame.size.width / 2, commissaryCheatButton.frame.size.height + infos.frame.size.height + otherComissaries.frame.size.height / 2);
                             
                             

                             
                         }
                         completion:^(BOOL finished){}];
        isDisplayed = NO;
        
    }
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    

    
}

@end
