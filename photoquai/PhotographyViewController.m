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



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //NSString *imageLink = [[machine getPictureElementsAtIndex:self.index] valueForKey:@"linkImg"];
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageLink]]];
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/pictures/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", self.idPicture]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    NSInteger idPicture = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.id"] integerValue];
    NSString *linkImg = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.link_iphone"];
    
    ImageZoomable *picture = [[ImageZoomable alloc] initWithImageView:image];
    
    [self.view addSubview:picture];
    
    NSLog(@"%i", self.idPicture);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
