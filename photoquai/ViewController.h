//
//  ViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"
#import "ImageWall.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    //  id delegate;
    UIImageView *imageWall;
    ImageWall *imageWallElement;
    UIScrollView *myScrollView;
    
    UIView *thumbsContainer;
    
    NSMutableArray *heights;
    NSMutableArray *ys;
    int imgIterate, nbrPictures, xPosition, yPosition, nbrColumns, totalWidth, widthThumb, i;
}


@property(nonatomic, strong) NavigationViewController *navTest;

//@property (nonatomic, strong) id delegate;

//-(void)changeViewToAgenda;
- (void)showMenu;

@end
