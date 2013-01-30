//
//  CommissaryViewController.h
//  photoquai
//
//  Created by Nicolas on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissaryViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *commissaryScrollView;

@property (strong, nonatomic) UIButton *commissaryCheatButton;

@property (strong, nonatomic) UIImageView *infos;

@property (strong, nonatomic) UIImageView *otherComissaries;

@property BOOL isDisplayed;


-(void)displayInfos;

@end
