//
//  PhotographyViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "PhotographyViewController.h"



@interface PhotographyViewController ()

@end

@implementation PhotographyViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    //NSLog(@"1 %f",descriptionPhotography.frame.size.height);
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         descriptionPhotography.frame = CGRectMake(0, 500, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                     }
                     completion:^(BOOL finished){}];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"title"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(someMethod)];
    
    self.navigationController.navigationItem.rightBarButtonItem = barButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor r:9 g:9 b:9 alpha:1];
    
    [self setTitle:@"Title"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessPhotographerView:) name:@"showArtistPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showImageDescription) name:@"showImageDescription" object:nil];

    
    //NSString *imageLink = [[machine getPictureElementsAtIndex:self.index] valueForKey:@"linkImg"];
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageLink]]];
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/pictures/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", self.idPicture]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    NSInteger idPicture = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.id"] integerValue];
    NSString *linkImg = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.link_iphone"];
    
    NSLog(@"%@", linkImg);
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    picture = [[ImageZoomable alloc] initWithImageURL:[NSURL URLWithString:linkImg]];
    picture.transform = CGAffineTransformMakeScale(1, 1);
    picture.userInteractionEnabled = YES;
    
    [self.view addSubview:picture];
    
    NSString *descriptionTextPhotography = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In euismod leo at mi posuere mollis. Morbi lacinia, felis ac ultrices auctor, magna sem tempus mi, nec blandit felis purus ut metus. Donec dolor mauris, eleifend id fermentum eu, placerat eget felis. Proin suscipit bibendum tincidunt.";
    NSString *titleTextPhotography = @"Gangnam Style";
    
    descriptionPhotography = [[DescriptionImageView alloc] initWithFrame:CGRectMake(0, 500, 320, 500) description:descriptionTextPhotography title:titleTextPhotography place:@"Maroc"];
    descriptionPhotography.userInteractionEnabled = YES;
    //[descriptionPhotography setUserInteractionEnabled:YES];
    [self.view addSubview:descriptionPhotography];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageDescription)];
    [picture addGestureRecognizer:singleTap];

    
    toolBar = [[ToolBarPhotography alloc] initWithFrame:CGRectMake(0, screenHeight - 118, 320, 55)];
    [self.view addSubview:toolBar];
}

- (void) accessPhotographerView:(NSNotification *)notification{

    NSLog(@"%@", [notification object]);
}

- (void) showImageDescription{
    
    //Cache la description
    if (descriptionPhotography.frame.origin.y == 50) {
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             picture.transform=CGAffineTransformMakeScale(1, 1);
                             descriptionPhotography.frame = CGRectMake(0, 500, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                             descriptionPhotography.photographyDatas.contentOffset = CGPointMake(0, 0); //La description est cachée, on remet le scroll à l'endroit initial
                         }
                         completion:^(BOOL finished){}];
        toolBar.infosImage.image = [UIImage imageNamed:@"informations"];
        toolBar.infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    }else if (descriptionPhotography.frame.origin.y == 500){
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             picture.transform=CGAffineTransformMakeScale(1.2, 1.2);
                             descriptionPhotography.frame = CGRectMake(0, 50, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                         }
                         completion:^(BOOL finished){}];
        toolBar.infosImage.image = [UIImage imageNamed:@"informations-blanc"];
        toolBar.infosLabel.textColor = [UIColor whiteColor];
        //toolBar.locationImage.image = [UIImage imageNamed:@"geoloc-RO"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
