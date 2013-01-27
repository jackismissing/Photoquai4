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

#import "InfosPratiquesViewController.h"

#import "ArtDirectorViewController.h"

#import "CreditsViewController.h"

#define MAINLABEL_TAG 1

#define NUMBERLABEL_TAG 1

#define SEPARATORIMAGE_TAG 1

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize infosTableView;
@synthesize items;
@synthesize photoInfos;
@synthesize cellBackground;
@synthesize screenSize;

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
    
    // Informations Image
    
    // Detect screen height
    
    screenSize = [[UIScreen mainScreen] bounds].size;
    
    
    
    if(screenSize.height == 568){
        
        photoInfos = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photoInfos.png"]];
        
    } else photoInfos = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photoInfos4.png"]];
    
    UIView *photoInfosView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, photoInfos.frame.size.width, photoInfos.frame.size.height)];
    
    [photoInfosView addSubview:photoInfos];
    
    [self.view addSubview:photoInfosView];
    
    
    //Create a tableView programmatically
    self.infosTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, photoInfos.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - photoInfos.frame.size.height - self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    
    self.infosTableView.separatorColor = [UIColor blackColor];
    
    self.infosTableView.scrollEnabled = NO;
    
    
    //Add the tableview as sa subview of our view ---> making "view" our superview.
    [self.view addSubview:infosTableView];
    
    items = [[NSArray alloc] initWithObjects:@"Agenda", @"Infos pratiques", @"Directeur artistique", @"Commissaires", @"Partenaires", @"Crédits", nil];
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

#pragma mark - Table view cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return infosTableView.frame.size.height / 6;
    
    
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
    
    UILabel *mainLabel, *numberLabel;
    UIImageView *separatorImage;
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // Custon disclosure
        
        
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure.png"]];  ;
        
        // Création du label principal de chaque cellule
        
        mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, cell.frame.size.height / 2 - 9, 175, 18)];
        
        mainLabel.tag = MAINLABEL_TAG;
        
        mainLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:18];
        
        mainLabel.textColor = [UIColor whiteColor];
        
        mainLabel.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
        
        [cell.contentView addSubview:mainLabel];
        
        // Image séparant le numéro de cellule du label
        
        separatorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infosLabelSeparator.png"]];
        
        separatorImage.frame = CGRectMake(42, cell.frame.size.height / 2 - separatorImage.frame.size.height / 2, separatorImage.frame.size.width, separatorImage.frame.size.height);
        
        separatorImage.tag = SEPARATORIMAGE_TAG;
        
        [cell.contentView addSubview:separatorImage];
        
        // Label numéro de cellule
        
        numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, cell.frame.size.height / 2 - 9, 20, 18)];
        
        numberLabel.tag = NUMBERLABEL_TAG;
        
        numberLabel.font = [UIFont fontWithName:@"Parisine-Italic" size:18];
        
        numberLabel.textColor = [UIColor whiteColor];
        
        numberLabel.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
        
        [cell.contentView addSubview:numberLabel];
        
    } else {
        
        mainLabel = (UILabel *)[cell.contentView viewWithTag:MAINLABEL_TAG];
        
        separatorImage = (UIImageView *)[cell.contentView viewWithTag:SEPARATORIMAGE_TAG];
        
        numberLabel = (UILabel *)[cell.contentView viewWithTag:NUMBERLABEL_TAG];
        
    }
    
    // Configure the cell... setting the text of our cell's label
    
    mainLabel.text = [items objectAtIndex:indexPath.row];
    
    numberLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    
    
    
    
    
    
    
    
    // Set the background color when selected (default blue)
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - Table willDisplay cell

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(screenSize.height == 568){
        
        cellBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pushnoir.png"]];
        
    } else cellBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pushnoir4.png"]];
    
    UIView *cellBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [cellBackgroundView addSubview:cellBackground];
    
    cell.backgroundView = cellBackgroundView;
    

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    // If you want to push another view upon tapping one of the cells on your table.
    
    
    
        
    if(indexPath.row == 0) {
        
        AgendaController *AgendaView = [[AgendaController alloc] init] ;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:AgendaView];
        
        [navigationController setNavigationBarHidden:NO];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        [self.navigationController pushViewController:AgendaView animated:YES];
        
        
    }
    
    if(indexPath.row == 1) {
        
        InfosPratiquesViewController *InfosPratiques = [[InfosPratiquesViewController alloc] init] ;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:InfosPratiques];
        
        [navigationController setNavigationBarHidden:NO];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        [self.navigationController pushViewController:InfosPratiques animated:YES];
        
        
    }
    
    if(indexPath.row == 2) {
        
        
         
         ArtDirectorViewController *ADView = [[ArtDirectorViewController alloc] init] ;
         
         UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ADView];
         
         [navigationController setNavigationBarHidden:NO];
         
         // [self presentViewController:navigationController animated:YES completion:nil];
         
         [self.navigationController pushViewController:ADView animated:YES];
         
         
        
        
    }
    
    if(indexPath.row == 5) {
        
        
        
        CreditsViewController *creditsView = [[CreditsViewController alloc] init] ;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:creditsView];
        
        [navigationController setNavigationBarHidden:NO];
        
        // [self presentViewController:navigationController animated:YES completion:nil];
        
        [self.navigationController pushViewController:creditsView animated:YES];
        
        
        
        
    }


    
    
    // Deselect the cell when changing page
    
    [self.infosTableView deselectRowAtIndexPath:[self.infosTableView indexPathForSelectedRow] animated:YES];
}

@end
