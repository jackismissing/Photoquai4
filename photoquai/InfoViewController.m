//
//  InfoViewController.m
//  navigationWheel
//
//  Created by Nicolas on 01/01/13.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import "InfoViewController.h"

#import "AgendaController.h"

#import "NavigationViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize infosTableView;
@synthesize items;

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
    //Create a tableView programmatically
    self.infosTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    //Add the tableview as sa subview of our view ---> making "view" our superview.
    [self.view addSubview:infosTableView];
    
    items = [[NSArray alloc] initWithObjects:@"Agenda", @"Informations pratiques", @"Directeur artistique", @"Commissaires", @"Partenaires", nil];
    //From the step 8 above, this is how we do that programmatically
    self.infosTableView.delegate = self;
    self.infosTableView.dataSource = self;
    
#pragma mark - Navigation Controller
    
    
    //self.navigationItem.titleView = customLabel;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"Informations";
    //self.navigationItem.tintColor = [UIColor whiteColor];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    //Réinstancie la navigation bar, une fois le menu disparu
    //self.navigationController.navigationBar.tintColor = [UIColor r:219 g:25 b:23 alpha:1];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage* image = [UIImage imageNamed:@"menu.png"];
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton *menuButton = [[UIButton alloc] initWithFrame:frame];
    [menuButton setBackgroundImage:image forState:UIControlStateNormal];
    //[menuButton setShowsTouchWhenHighlighted:YES];
    
    [menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* menuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    [self.navigationItem setLeftBarButtonItem:menuBarButtonItem];
    
    
    
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
    
        [navigationController setNavigationBarHidden:YES animated:NO];
    
    // You can even set the style of stuff before you show it
    //navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // And now you want to present the view in a modal fashion all nice and animated
    [self presentModalViewController:navigationController animated:YES];
    
    
    // [self presentModalViewController:mainMenu animated:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [items count];
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
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    // Set the background color when selected (default blue)
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    return cell;
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
    
    if(indexPath.row == 2) {
        
        /*
        
        ADViewController *ADView = [[ADViewController alloc] init] ;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ADView];
        
        [navigationController setNavigationBarHidden:NO];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        [self.navigationController pushViewController:ADView animated:YES];
         
         */

        
    }
    
    if(indexPath.row == 0) {
        
        AgendaController *AgendaView = [[AgendaController alloc] init] ;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:AgendaView];
        
        [navigationController setNavigationBarHidden:NO];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        [self.navigationController pushViewController:AgendaView animated:YES];
        
        
    }

    
    // Deselect the cell when changing page
    
    [self.infosTableView deselectRowAtIndexPath:[self.infosTableView indexPathForSelectedRow] animated:YES];
}

@end
