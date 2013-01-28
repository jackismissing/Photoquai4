//
//  FilterViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 28/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController (){
    NSMutableArray *listOfItems;
}

@end

@implementation FilterViewController

@synthesize tableContents;
@synthesize sortedKeys;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Initialize the array.
    listOfItems = [[NSMutableArray alloc] init];
    
    //Add items
    [listOfItems addObject:@"Iceland"];
    [listOfItems addObject:@"Greenland"];
    [listOfItems addObject:@"Switzerland"];
    [listOfItems addObject:@"Norway"];
    [listOfItems addObject:@"New Zealand"];
    [listOfItems addObject:@"Greece"];
    [listOfItems addObject:@"Rome"];
    [listOfItems addObject:@"Ireland"];
    
    //Set the title
    self.navigationItem.title = @"Countries";
    
    self.view.backgroundColor = [UIColor whiteColor];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
    cell.text = cellValue;
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
