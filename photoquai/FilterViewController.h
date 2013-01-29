//
//  FilterViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 28/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+RVB255.h"
#import "FilterSwitch.h"

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSDictionary *tableViewDatas;
    NSArray *localisationDatas;
    NSArray *geographyDatas;
}

@property (nonatomic, strong) UITableView *sampleTableView;
@property (nonatomic, strong) NSArray *items;

@end
