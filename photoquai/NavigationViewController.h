//
//  NavigationViewController.h
//  photoquai
//
//  Created by Nicolas on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewProtocol.h"
#import "AgendaController.h"

/*
@protocol NavigationViewControllerDelegate <NSObject>

-(void)changeViewToAgenda;

@end
 
 */


@interface NavigationViewController : UIViewController

@property (nonatomic, strong) UILabel *sectorLabel;
@property (nonatomic, assign) id delegate;
@end
