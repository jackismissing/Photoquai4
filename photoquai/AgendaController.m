//
//  AgendaController.m
//  navigationWheel
//
//  Created by Nicolas Garnier on 08/01/13.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import "AgendaController.h"
#import "NavigationViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface AgendaController ()

@end

@implementation AgendaController
@synthesize infosTableView;
@synthesize items;
@synthesize index;
@synthesize rowsInTmpArray;
@synthesize agendaScroll;
@synthesize juinView;
@synthesize juinFirstView;

@synthesize juilletView;
@synthesize juilletFirstView;

@synthesize aoutView;
@synthesize aoutFirstView;

@synthesize septembreView;

@synthesize octobreView;
@synthesize octobreLastView;

@synthesize novembreView;
@synthesize novembreLastView;

@synthesize decembreView;
@synthesize decembreLastView;

@synthesize agendaButtonJuin;
@synthesize agendaFirstButtonJuin;

@synthesize agendaButtonJuillet;
@synthesize agendaFirstButtonJuillet;

@synthesize agendaButtonAout;
@synthesize agendaFirstButtonAout;

@synthesize agendaButtonSeptembre;

@synthesize agendaButtonOctobre;
@synthesize agendaLastButtonOctobre;

@synthesize agendaButtonNovembre;
@synthesize agendaLastButtonNovembre;

@synthesize agendaButtonDecembre;
@synthesize agendaLastButtonDecembre;

@synthesize width;
@synthesize height;
@synthesize centerX;


/*
 
 Month values :
 
 1 : october
 2 : november
 
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set selectedMonth to 0;
    
    selectedMonth = 0;
    
    // Init table
    
    self.infosTableView = [[UITableView alloc] init];
    
    // Set width and height
    
    width = self.view.frame.size.width;
    
    height = self.view.frame.size.height;
    
    centerX = width/2;
    
    ///////////////////////////////////////////////////////////////////////////
    
    // Menu for the agenda
    
  
    // Creating the scrollview
        
    agendaScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    [agendaScroll setScrollEnabled:YES];
    
    
    agendaScroll.contentSize = CGSizeMake(780, 40);
    [agendaScroll setShowsHorizontalScrollIndicator:NO];
    [agendaScroll scrollRectToVisible:CGRectMake(190, 0, self.view.frame.size.width, 40) animated:NO];
    [agendaScroll setDelegate:self];
  
     
    
    [self.view addSubview:agendaScroll];
       
    // Creating one view per button
    
    octobreLastView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 40)];
    octobreLastView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:octobreLastView];
    
    novembreLastView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 50, 40)];
    novembreLastView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:novembreLastView];
    
    decembreLastView = [[UIView alloc] initWithFrame:CGRectMake(130, 0, 50, 40)];
    decembreLastView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:decembreLastView];
    
    
    juinView = [[UIView alloc] initWithFrame:CGRectMake(190, 0, 50, 40)];
    juinView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:juinView];
    
    juilletView = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 50, 40)];
    juilletView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:juilletView];
    
    aoutView = [[UIView alloc] initWithFrame:CGRectMake(310, 0, 50, 40)];
    aoutView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:aoutView];
    
    septembreView = [[UIView alloc] initWithFrame:CGRectMake(370, 0, 50, 40)];
    septembreView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:septembreView];
    
    octobreView = [[UIView alloc] initWithFrame:CGRectMake(430, 0, 50, 40)];
    octobreView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:octobreView];
    
    novembreView = [[UIView alloc] initWithFrame:CGRectMake(490, 0, 50, 40)];
    novembreView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:novembreView];
    
    decembreView = [[UIView alloc] initWithFrame:CGRectMake(550, 0, 50, 40)];
    decembreView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:decembreView];
    
    juinFirstView = [[UIView alloc] initWithFrame:CGRectMake(610, 0, 50, 40)];
    juinFirstView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:juinFirstView];
    
    juilletFirstView = [[UIView alloc] initWithFrame:CGRectMake(670, 0, 50, 40)];
    juilletFirstView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:juilletFirstView];
    
    aoutFirstView = [[UIView alloc] initWithFrame:CGRectMake(730, 0, 50, 40)];
    aoutFirstView.backgroundColor = [UIColor lightGrayColor];
    [agendaScroll addSubview:aoutFirstView];
    
    
    
    // juin
    
    agendaButtonJuin = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonJuin addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonJuin.tag = 1;
    
    [agendaButtonJuin setTitle:@"1" forState:UIControlStateNormal];
    
    [agendaButtonJuin setBackgroundColor:[UIColor redColor]];
    
    [juinView addSubview:agendaButtonJuin];
    
    
    agendaFirstButtonJuin = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaFirstButtonJuin addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaFirstButtonJuin.tag = 1;
    
    [agendaFirstButtonJuin setTitle:@"1" forState:UIControlStateNormal];
    
    [agendaFirstButtonJuin setBackgroundColor:[UIColor redColor]];
    
    [juinFirstView addSubview:agendaFirstButtonJuin];

    
    // Juillet
    
    agendaButtonJuillet = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonJuillet addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonJuillet.tag = 1;
    
    [agendaButtonJuillet setTitle:@"2" forState:UIControlStateNormal];
    
    [agendaButtonJuillet setBackgroundColor:[UIColor redColor]];
    
    [juilletView addSubview:agendaButtonJuillet];
    
    agendaFirstButtonJuillet = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaFirstButtonJuillet addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaFirstButtonJuillet.tag = 1;
    
    [agendaFirstButtonJuillet setTitle:@"2" forState:UIControlStateNormal];
    
    [agendaFirstButtonJuillet setBackgroundColor:[UIColor redColor]];
    
    [juilletFirstView addSubview:agendaFirstButtonJuillet];
    
    
    // Aout
    
    
    
    agendaButtonAout = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonAout addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonAout.tag = 1;
    
    [agendaButtonAout setTitle:@"3" forState:UIControlStateNormal];
    
    [agendaButtonAout setBackgroundColor:[UIColor redColor]];
    
    [aoutView addSubview:agendaButtonAout];
    
    agendaFirstButtonAout = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaFirstButtonAout addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaFirstButtonAout.tag = 1;
    
    [agendaFirstButtonAout setTitle:@"3" forState:UIControlStateNormal];
    
    [agendaFirstButtonAout setBackgroundColor:[UIColor redColor]];
    
    [aoutFirstView addSubview:agendaFirstButtonAout];
    
    

    
    
    // september
    
    agendaButtonSeptembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonSeptembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonSeptembre.tag = 1;
    
    [agendaButtonSeptembre setTitle:@"4" forState:UIControlStateNormal];
    
    [agendaButtonSeptembre setBackgroundColor:[UIColor redColor]];
    
    [septembreView addSubview:agendaButtonSeptembre];
    
    
    // october
    
    

    agendaButtonOctobre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonOctobre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonOctobre.tag = 1;
    
    [agendaButtonOctobre setTitle:@"5" forState:UIControlStateNormal];
    
    [agendaButtonOctobre setBackgroundColor:[UIColor redColor]];
    
    [octobreView addSubview:agendaButtonOctobre];
    
    agendaLastButtonOctobre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaLastButtonOctobre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaLastButtonOctobre.tag = 1;
    
    [agendaLastButtonOctobre setTitle:@"5" forState:UIControlStateNormal];
    
    [agendaLastButtonOctobre setBackgroundColor:[UIColor redColor]];
    
    [octobreLastView addSubview:agendaLastButtonOctobre];
    
    // november
    
    agendaButtonNovembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonNovembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonNovembre.tag = 2;
    
    [agendaButtonNovembre setTitle:@"6" forState:UIControlStateNormal];
    
    [agendaButtonNovembre setBackgroundColor:[UIColor redColor]];
    
    [novembreView addSubview:agendaButtonNovembre];
    
    agendaLastButtonNovembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaLastButtonNovembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaLastButtonNovembre.tag = 2;
    
    [agendaLastButtonNovembre setTitle:@"6" forState:UIControlStateNormal];
    
    [agendaLastButtonNovembre setBackgroundColor:[UIColor redColor]];
    
    [novembreLastView addSubview:agendaLastButtonNovembre];

    
    // december
    
    agendaButtonDecembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonDecembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonDecembre.tag = 3;
    
    [agendaButtonDecembre setTitle:@"7" forState:UIControlStateNormal];
    
    [agendaButtonDecembre setBackgroundColor:[UIColor redColor]];
    
    [decembreView addSubview:agendaButtonDecembre];
    
    agendaLastButtonDecembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaLastButtonDecembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaLastButtonDecembre.tag = 1;
    
    [agendaLastButtonDecembre setTitle:@"7" forState:UIControlStateNormal];
    
    [agendaLastButtonDecembre setBackgroundColor:[UIColor redColor]];
    
    [decembreLastView addSubview:agendaLastButtonDecembre];
    
    
    
#pragma mark - Navigation Controller
    

    
    
    self.navigationItem.title = @"Agenda";
    //self.navigationItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showMenu)];
    
    
    // By default, press october
    
    [agendaButtonOctobre sendActionsForControlEvents:UIControlEventTouchUpInside];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showMenu
{
    
    NavigationViewController *mainMenu = [[NavigationViewController alloc] init];
    mainMenu.delegate = self;
    
    // This is where you wrap the view up nicely in a navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainMenu];
    
    // You can even set the style of stuff before you show it
    //navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // And now you want to present the view in a modal fashion all nice and animated
    [self presentModalViewController:navigationController animated:YES];
    
    
    // [self presentModalViewController:mainMenu animated:YES];
}




- (void)showTable : (id)sender;
{
    
    NSLog(@"agendaBtn");
    
    
    //Create a tableView programmatically
    
    
    // Get the parameter
    
    NSInteger monthId = ((UIControl *) sender).tag;
    
    
    // If october
    
    if(monthId == 1 && selectedMonth != 1)
    {
        
        // Set month to 1
        selectedMonth = 1;
        
        NSLog(@"october");
        
        // Set opacity for buttons
        
        /*
        [agendaButtonOctober setAlpha:1];
        [agendaButtonNovember setAlpha:0.7];
        [agendaButtonDecember setAlpha:0.3];
         */
        
        
        
        // Reloading table properties in casse where another button was already selected before
        
        [infosTableView reloadData];
        
        NSLog(@"test");
        
        [infosTableView setFrame:CGRectMake(350, 40, self.view.frame.size.width, self.view.frame.size.height)];
        //Add the tableview as sa subview of our view ---> making "view" our superview.
        
        // Animate add sub view
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:0.4];
        [infosTableView setFrame:CGRectMake(self.view.frame.origin.x, 40, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
        [self.view addSubview:infosTableView];
        
        items = [[NSArray alloc] initWithObjects:@"Expo 1", @"Expo 2", @"Expo 3", @"Expo 4", nil];
        
        self.infosTableView.delegate = self;
        self.infosTableView.dataSource = self;
        
        /////////////////
        //// EXPANDABLE SECTIONS ///
        ///////////////////////////
        
        if (!expandedSections)
        {
            
            expandedSections = [[NSMutableIndexSet alloc] init];
            
        }
        
    }
    
    // If november
    
    if(monthId == 2 && selectedMonth != 2)
    {
        // Set month to 2
        selectedMonth = 2;
        
        // Reloading table head section data
        [infosTableView reloadData];
        
        // Set opacity for buttons
        
        
        /*
         [agendaButtonOctober setAlpha:1];
         [agendaButtonNovember setAlpha:0.7];
         [agendaButtonDecember setAlpha:0.3];
         */
        
        NSLog(@"november");
        [infosTableView setFrame:CGRectMake(350, 40, self.view.frame.size.width, self.view.frame.size.height)];
        //Add the tableview as sa subview of our view ---> making "view" our superview.
        
        // Animate add sub view
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:0.4];
        [infosTableView setFrame:CGRectMake(self.view.frame.origin.x, 40, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
        [self.view addSubview:infosTableView];
        
        items = [[NSArray alloc] initWithObjects:@"Expo 1", @"Expo 2", @"Expo 3", @"Expo 4", nil];
        self.infosTableView.delegate = self;
        self.infosTableView.dataSource = self;
        
        /////////////////
        //// EXPANDABLE SECTIONS ///
        ///////////////////////////
        
        if (!expandedSections)
        {
            
            expandedSections = [[NSMutableIndexSet alloc] init];
            
        }
        
    }
    
    // If december
    
    if(monthId == 3 && selectedMonth != 3)
    {
        // Set month to 2
        selectedMonth = 3;
        
        // Reloading table head section data
        [infosTableView reloadData];
        
        // Set opacity for buttons
        
        
        /*
         [agendaButtonOctober setAlpha:1];
         [agendaButtonNovember setAlpha:0.7];
         [agendaButtonDecember setAlpha:0.3];
         */
        
        NSLog(@"december");
        [infosTableView setFrame:CGRectMake(350, 40, self.view.frame.size.width, self.view.frame.size.height)];
        //Add the tableview as sa subview of our view ---> making "view" our superview.
        
        // Animate add sub view
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:0.4];
        [infosTableView setFrame:CGRectMake(self.view.frame.origin.x, 40, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
        [self.view addSubview:infosTableView];
        
        items = [[NSArray alloc] initWithObjects:@"Expo 1", @"Expo 2", @"Expo 3", @"Expo 4", nil];
        self.infosTableView.delegate = self;
        self.infosTableView.dataSource = self;
        
        /////////////////
        //// EXPANDABLE SECTIONS ///
        ///////////////////////////
        
        if (!expandedSections)
        {
            
            expandedSections = [[NSMutableIndexSet alloc] init];
            
        }
        
    }
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    
    if([self tableView:tableView canCollapseSection:section])
    {
        if([expandedSections containsIndex:section])
        {
            return [items count];
        }
        
        return 1;
    }
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Where we configure the cell in each row
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            
            // Set data according to month
            
            if(selectedMonth == 1) {
                
                cell.textLabel.text = @"Jour Octobre";
                
            } else if (selectedMonth == 2) {
                
                cell.textLabel.text = @"Jour Novembre";
                
            }
            
            else if (selectedMonth == 3) {
                
                cell.textLabel.text = @"Jour Decembre";
                
            }
        }
        else
        {
            cell.textLabel.text = [items objectAtIndex:indexPath.row];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            
        }
    }
    else
    {
        cell.textLabel.text = @"Fock";
    }
    
    
    // Set the background color when selected (default blue)
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Expandable sections

- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>=0) return YES;
    
    return NO;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    // If you want to push another view upon tapping one of the cells on your table.
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    
    
    
    
    NSLog(@"%@",expandedSections);
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        // Only first row can be expanded
        
        if(!indexPath.row) {
            
        
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            /*
            if(index){
            
                [tableView deleteRowsAtIndexPaths:rowsInTmpArray withRowAnimation:UITableViewRowAnimationTop];
                [expandedSections removeIndex:index];
            }
             */
        
        
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
        
            NSMutableArray *tmpArray = [NSMutableArray array];
        
            if(currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
        
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
                              
            }
        
            for(int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
        
            // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationTop];
            
            }
        
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationTop];
            }
            
            rowsInTmpArray = tmpArray;
        
        }
        
    }
    
    // Deselect the cell when changing page
    
    [self.infosTableView deselectRowAtIndexPath:[self.infosTableView indexPathForSelectedRow] animated:YES];
    
    // set index
    
    index = indexPath.section;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    
    
    

    
    CGFloat centerXBoundNegative = centerX - 20;
    
    CGFloat centerXBoundPositive = centerX + 20;
    
    
    
    NSLog(@"%f", centerXBoundNegative);
    
    NSLog(@"%f", centerXBoundPositive);
    
    /*
    
    if(decemberButtonCenter > centerXBoundNegative && decemberButtonCenter < centerXBoundPositive) {
        NSLog(@"%f", decemberButtonCenter);
    }
     
     */
     
     
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
    {
        
        NSLog(@"decelerate");
        // The key is repositioning without animation
        if (agendaScroll.contentOffset.x == 0) {
            NSLog(@"Offset x");
            // user is scrolling to the left from image 1 to image 10.
            // reposition offset to show image 10 that is on the right in the scroll view
           [agendaScroll scrollRectToVisible:CGRectMake(420,0,self.view.frame.size.width, 40) animated:NO];
        }
        else if (agendaScroll.contentOffset.x == 460) {
            NSLog(@"420 x");
            // user is scrolling to the right from image 10 to image 1.
            // reposition offset to show image 1 that is on the left in the scroll view
            [agendaScroll scrollRectToVisible:CGRectMake(40,0,self.view.frame.size.width, 40) animated:NO];
        }
        
            }

@end
