//
//  ViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"

@interface ViewController : UIViewController//<NavigationViewControllerDelegate>
{
    id delegate;
}


@property(nonatomic, strong) NavigationViewController *navTest;

@property (nonatomic, strong) id delegate;

//-(void)changeViewToAgenda;
- (void)showMenu;

@end
