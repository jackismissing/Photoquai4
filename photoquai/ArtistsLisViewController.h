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
    int artistsIterate, i, nbrArtists;
    NSMutableArray *artistsList;

}

@property(nonatomic, strong) NSMutableDictionary *sections;
@property(nonatomic, strong) UITableView *artistsTable;

-(void)loadArtists;
-(void)showMenu;

@end
