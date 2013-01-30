//
//  FilterViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 28/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController (){
    UILabel *filterName;
    FilterSwitch *filterSwitch;
}

@end



@implementation FilterViewController


@synthesize items;

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar-photographie.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"Filtres";
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [cancelBtn addTarget:self action:@selector(dismissPage) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelBtn setImage:[UIImage imageNamed:@"closeMap"] forState:UIControlStateNormal];
    
    UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [checkBtn addTarget:self action:@selector(dismissPage) forControlEvents:UIControlEventTouchUpInside];
    
    [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    
    UIView *rightNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightNavigationButtons addSubview:cancelBtn];
    
    UIView *leftNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftNavigationButtons addSubview:checkBtn];
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButtons];
    UIBarButtonItem *leftNavigationButtonItems = [[UIBarButtonItem alloc] initWithCustomView:leftNavigationButtons];
    
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;
    self.navigationItem.leftBarButtonItem = leftNavigationButtonItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    geographyDatas = [[NSArray alloc] initWithObjects:@"Afrique", @"Amérique du Nord", @"Amérique du Sud", @"Asie", @"Europe", @"Océanie", nil];
    localisationDatas = [[NSArray alloc] initWithObjects:@"Sur le quai", @"Dans les jardins du musée", nil];
    
    tableViewDatas = [NSDictionary dictionaryWithObjectsAndKeys: geographyDatas, @"Origine géographique", localisationDatas, @"Localisation", nil];
    
    //Create a tableView programmatically
    self.sampleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    //Add the tableview as sa subview of our view ---> making "view" our superview.
    [self.view addSubview:self.sampleTableView];
    //From step 7 above.
    items = [[NSArray alloc] initWithObjects:@"", nil];
    //From the step 8 above, this is how we do that programmatically
    self.sampleTableView.delegate = self;
    self.sampleTableView.dataSource = self;
    self.sampleTableView.backgroundColor = [UIColor blackColor];
    self.sampleTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.sampleTableView.separatorColor = [UIColor lightGrayColor];
    
    //self.sampleTableView.backgroundView.hidden = YES;
    
    //self.sampleTableView.separatorColor = [UIColor r:34 g:34 b:34 alpha:1];
    self.sampleTableView.separatorColor = [UIColor clearColor];
    
    //self.sampleTableView.separatorColor = [UIImage imageNamed:@"etoilejaune"];
    
    [self.view addSubview:self.sampleTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self->tableViewDatas allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self->tableViewDatas allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self->tableViewDatas valueForKey:[[self->tableViewDatas allKeys] objectAtIndex:section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        filterName = [[UILabel alloc] initWithFrame:CGRectMake(13, 11, 150, 18)];
    
        filterName.font = [UIFont fontWithName:@"Parisine-Bold" size:17];
        filterName.backgroundColor = [UIColor clearColor];
        filterName.textColor = [UIColor r:153 g:153 b:153 alpha:1];
        filterName.tag = 0;
        [cell.contentView addSubview:filterName];
        
        filterSwitch = [[FilterSwitch alloc] initWithFrame:CGRectMake(cell.frame.size.width - 10, 11, 139, 55)];
        [cell.contentView addSubview:filterSwitch];
    }

    NSArray* allKeys = [tableViewDatas allKeys]; //On récupère toutes les clés du dictionnaire
    
    filterName.text = [[tableViewDatas objectForKey:[allKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    [filterName sizeToFit];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    
    if (cell.backgroundColor == [UIColor darkGrayColor]) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor darkGrayColor];
    }
}

- (void) changeBackground:(UIGestureRecognizer *)gesture{
    UIView *index = gesture.view;
    
    if (index.tag == 0) {
        index.backgroundColor = [UIColor whiteColor];
        index.tag = 1;
    }else{
        index.backgroundColor = [UIColor blackColor];
        index.tag = 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, headerView.frame.size.height)];
    headerTitle.text = [[self->tableViewDatas allKeys] objectAtIndex:section];
    headerTitle.textColor = [UIColor whiteColor];
    headerTitle.font = [UIFont fontWithName:@"Parisine-Bold" size:17];
    headerTitle.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
    [headerView addSubview:headerTitle];
    
    return headerView;
}

- (void)dismissPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
