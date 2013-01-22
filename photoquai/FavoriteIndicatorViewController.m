//
//  FavoriteIndicatorViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 22/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FavoriteIndicatorViewController.h"

@interface FavoriteIndicatorViewController ()

@end

@implementation FavoriteIndicatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    background.backgroundColor = [UIColor r:0 g:1 b:0 alpha:.7];
    background.opaque = YES;
    background.userInteractionEnabled = NO;
    
    [self.view addSubview:background];
    
    content = [[UIView alloc] initWithFrame:CGRectMake(0, 9, screenWidth * .8, 130)];
    content.frame = CGRectMake((screenWidth - content.frame.size.width) / 2, 7, screenWidth * .8, 130);
    content.backgroundColor = [UIColor whiteColor];
    content.layer.cornerRadius = 3;
    //content.clipsToBounds = YES;
    content.userInteractionEnabled = YES;
    content.alpha = 0;
    
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, content.frame.size.height, content.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
    [content.layer addSublayer:bottomBorder];
    
    arrow = [[UIView alloc] initWithFrame:CGRectMake(content.frame.size.width - 53, 0, 33, 30)];
    arrow.backgroundColor = [UIColor whiteColor];
    // Rotate 90 degrees to hide it off screen
    CGAffineTransform rotationTransform = CGAffineTransformIdentity;
    rotationTransform = CGAffineTransformRotate(rotationTransform, 40);
    arrow.transform = rotationTransform;
    arrow.alpha = 0;
    
    [content addSubview:arrow];
    
    
    _message = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 200, 30)];
    
    _message.font = [UIFont fontWithName:@"Parisine-Bold" size:13.0f];
    _message.text = @"La photographie a été ajoutée aux favoris";
    _message.numberOfLines = 2;
    //[_message sizeToFit];
    _message.textColor = [UIColor blackColor];
    _message.backgroundColor = [UIColor clearColor];
    
    [content addSubview:_message];
    
    UITextView *subMessage = [[UITextView alloc] initWithFrame:CGRectMake(18, _message.frame.size.height + _message.frame.origin.y, content.frame.size.width * .8, 25)];
    subMessage.font = [UIFont fontWithName:@"Parisine-Regular" size: 9.0f];
    subMessage.text = @"Rendez-vous dans la catégorie “Favoris“ pour retouver votre séléction de photographies et d’artistes";
    subMessage.backgroundColor = [UIColor clearColor];
    subMessage.textColor = [UIColor blackColor];
    subMessage.editable = NO;
    
    [content addSubview:subMessage];
    
    CGRect frame = subMessage.frame;
    frame.size.height = subMessage.contentSize.height;
    frame.size.width = subMessage.contentSize.width;
    
    subMessage.frame = frame;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setFrame:CGRectMake(25, subMessage.frame.size.height + subMessage.frame.origin.y + 5, content.frame.size.width * .8, 25.0)];
    [closeBtn setTitle:@"OK" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.userInteractionEnabled = YES;
    
    [closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    closeBtn.backgroundColor = [UIColor r:241 g:241 b:241 alpha:1];
    closeBtn.layer.borderColor = [UIColor r:0 g:0 b:236 alpha:1].CGColor;
    
    closeBtn.layer.borderWidth = 1.0f;
    closeBtn.layer.cornerRadius = 3.0f;
    
    [content addSubview:closeBtn];
     [self.view addSubview:content];
}


- (void) hide{
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         content.transform = CGAffineTransformMakeScale(.1, .1);
                         content.alpha = 0;
                         arrow.alpha = 0;
                     }completion:^(BOOL finished){
                         [self dismissViewControllerAnimated:YES completion:nil];
                     }];
}

- (void) show{
    
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         content.transform = CGAffineTransformMakeScale(1, 1);
                         content.alpha = 1;
                         arrow.alpha = 1;
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
