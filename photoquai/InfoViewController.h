//
//  InfoViewController.h
//  navigationWheel
//
//  Created by Nicolas on 01/01/13.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *infosTableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIImageView *photoInfos;
@property (nonatomic, strong) UIImageView *cellBackground;
@property CGSize screenSize;

-(void)showMenu;


@end
