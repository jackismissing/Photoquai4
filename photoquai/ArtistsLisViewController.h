//
//  ArtistsLisViewController.h
//  photoquai
//
//  Created by Nicolas on 20/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistsLisViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    int artistsIterate, i, nbrArtists, j;
    NSMutableArray *artistsList;

}

@property(nonatomic, strong) NSMutableDictionary *sections;
@property(nonatomic, strong) UITableView *artistsTable;
@property(nonatomic, strong) UIScrollView *tableMenuScrollView;
@property(nonatomic, strong) UIImageView *cellBackground;

-(void)loadArtists;
-(void)showMenu;
-(void)createTableMenu;

@end
