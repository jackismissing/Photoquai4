//
//  PhotographyViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "PhotographyViewController.h"
#import "ToolBarPhotography.h"


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
                         descriptionPhotography.frame = CGRectMake(0, 0, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showImageDescription:) name:@"showImageDescription" object:nil];

    
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
    
    ImageZoomable *picture = [[ImageZoomable alloc] initWithImageURL:[NSURL URLWithString:linkImg]];
    
    [self.view addSubview:picture];
    
    NSString *descriptionTextPhotography = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In euismod leo at mi posuere mollis. Morbi lacinia, felis ac ultrices auctor, magna sem tempus mi, nec blandit felis purus ut metus. Donec dolor mauris, eleifend id fermentum eu, placerat eget felis. Proin suscipit bibendum tincidunt.";
    NSString *titleTextPhotography = @"Gangnam Style";
    
    descriptionPhotography = [[DescriptionImageView alloc] initWithFrame:CGRectMake(0, 300, 320, 800) description:descriptionTextPhotography title:titleTextPhotography place:@"Maroc"];
    descriptionPhotography.userInteractionEnabled = YES;
    //[descriptionPhotography setUserInteractionEnabled:YES];
    [self.view addSubview:descriptionPhotography];
    
    ToolBarPhotography *toolBar = [[ToolBarPhotography alloc] initWithFrame:CGRectMake(0, screenHeight - 118, 320, 55)];
    [self.view addSubview:toolBar];
}

- (void) accessPhotographerView:(NSNotification *)notification{

    NSLog(@"%@", [notification object]);
}

- (void) showImageDescription:(NSNotification *)notification{
    
    //Cache la description
    if (descriptionPhotography.frame.origin.y == 0) {
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             descriptionPhotography.frame = CGRectMake(0, 300, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                             descriptionPhotography.photographyDatas.contentOffset = CGPointMake(0, 0); //La description est cachée, on remet le scroll à l'endroit initial
                         }
                         completion:^(BOOL finished){}];
    }else if (descriptionPhotography.frame.origin.y == 300){
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             descriptionPhotography.frame = CGRectMake(0, 0, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                         }
                         completion:^(BOOL finished){}];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
