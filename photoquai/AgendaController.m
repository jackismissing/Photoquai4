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



@synthesize dateLabel;
@synthesize headerTitle;
@synthesize headerText;




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
    
    self.infosTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 40, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    v.backgroundColor = [UIColor clearColor];
    
    [self.infosTableView setTableFooterView:v];
    
    // Set width and height
    
    width = self.view.frame.size.width;
    
    height = self.view.frame.size.height;
    
    centerX = width/2;
    
    ///////////////////////////////////////////////////////////////////////////
    
    // Menu for the agenda
    
    
    // Creating the scrollview
    
    agendaScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    [agendaScroll setScrollEnabled:YES];
    
    
    agendaScroll.contentSize = CGSizeMake(780, 50);
    [agendaScroll setShowsHorizontalScrollIndicator:NO];
    [agendaScroll scrollRectToVisible:CGRectMake(190, 0, self.view.frame.size.width, 50) animated:NO];
    [agendaScroll setDelegate:self];
    
    
    
    [self.view addSubview:agendaScroll];
    
    // Creating one view per button
    
    octobreLastView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 50, 50)];
    octobreLastView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:octobreLastView];
    
    novembreLastView = [[UIView alloc] initWithFrame:CGRectMake(70, 0, 50, 50)];
    novembreLastView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:novembreLastView];
    
    decembreLastView = [[UIView alloc] initWithFrame:CGRectMake(130, 0, 50, 50)];
    decembreLastView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:decembreLastView];
    
    
    juinView = [[UIView alloc] initWithFrame:CGRectMake(190, 0, 50, 50)];
    juinView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:juinView];
    
    juilletView = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 50, 50)];
    juilletView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:juilletView];
    
    aoutView = [[UIView alloc] initWithFrame:CGRectMake(310, 0, 50, 50)];
    aoutView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:aoutView];
    
    septembreView = [[UIView alloc] initWithFrame:CGRectMake(370, 0, 50, 50)];
    septembreView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:septembreView];
    
    octobreView = [[UIView alloc] initWithFrame:CGRectMake(430, 0, 50, 50)];
    octobreView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:octobreView];
    
    novembreView = [[UIView alloc] initWithFrame:CGRectMake(490, 0, 50, 50)];
    novembreView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:novembreView];
    
    decembreView = [[UIView alloc] initWithFrame:CGRectMake(550, 0, 50, 50)];
    decembreView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:decembreView];
    
    juinFirstView = [[UIView alloc] initWithFrame:CGRectMake(610, 0, 50, 50)];
    juinFirstView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:juinFirstView];
    
    juilletFirstView = [[UIView alloc] initWithFrame:CGRectMake(670, 0, 50, 50)];
    juilletFirstView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:juilletFirstView];
    
    aoutFirstView = [[UIView alloc] initWithFrame:CGRectMake(730, 0, 50, 50)];
    aoutFirstView.backgroundColor = [UIColor colorWithWhite:0 alpha:100];
    [agendaScroll addSubview:aoutFirstView];
    
    
    
    // juin
    
    agendaButtonJuin = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonJuin addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonJuin.tag = 1;
    
    [agendaButtonJuin setTitle:@"Jun." forState:UIControlStateNormal];
    
    agendaButtonJuin.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonJuin setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [juinView addSubview:agendaButtonJuin];
    
    
    agendaFirstButtonJuin = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaFirstButtonJuin addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaFirstButtonJuin.tag = 1;
    
    [agendaFirstButtonJuin setTitle:@"Jun." forState:UIControlStateNormal];
    
    agendaFirstButtonJuin.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaFirstButtonJuin setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [juinFirstView addSubview:agendaFirstButtonJuin];
    
    
    // Juillet
    
    agendaButtonJuillet = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonJuillet addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonJuillet.tag = 1;
    
    [agendaButtonJuillet setTitle:@"Jul." forState:UIControlStateNormal];
    
    agendaButtonJuillet.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonJuillet setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [juilletView addSubview:agendaButtonJuillet];
    
    agendaFirstButtonJuillet = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaFirstButtonJuillet addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaFirstButtonJuillet.tag = 1;
    
    [agendaFirstButtonJuillet setTitle:@"Jul." forState:UIControlStateNormal];
    
    agendaFirstButtonJuillet.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaFirstButtonJuillet setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [juilletFirstView addSubview:agendaFirstButtonJuillet];
    
    
    // Aout
    
    
    
    agendaButtonAout = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonAout addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonAout.tag = 1;
    
    [agendaButtonAout setTitle:@"Aoû." forState:UIControlStateNormal];
    
    agendaButtonAout.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonAout setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [aoutView addSubview:agendaButtonAout];
    
    agendaFirstButtonAout = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaFirstButtonAout addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaFirstButtonAout.tag = 1;
    
    [agendaFirstButtonAout setTitle:@"Aoû." forState:UIControlStateNormal];
    
    agendaFirstButtonAout.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaFirstButtonAout setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [aoutFirstView addSubview:agendaFirstButtonAout];
    
    
    
    
    
    // september
    
    agendaButtonSeptembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonSeptembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonSeptembre.tag = 1;
    
    [agendaButtonSeptembre setTitle:@"Sep." forState:UIControlStateNormal];
    
    agendaButtonSeptembre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonSeptembre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [septembreView addSubview:agendaButtonSeptembre];
    
    
    // october
    
    
    
    agendaButtonOctobre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonOctobre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonOctobre.tag = 1;
    
    [agendaButtonOctobre setTitle:@"Oct." forState:UIControlStateNormal];
    
    agendaButtonOctobre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonOctobre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [octobreView addSubview:agendaButtonOctobre];
    
    agendaLastButtonOctobre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaLastButtonOctobre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaLastButtonOctobre.tag = 1;
    
    [agendaLastButtonOctobre setTitle:@"Oct." forState:UIControlStateNormal];
    
    agendaLastButtonOctobre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaLastButtonOctobre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [octobreLastView addSubview:agendaLastButtonOctobre];
    
    // november
    
    agendaButtonNovembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonNovembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonNovembre.tag = 1;
    
    [agendaButtonNovembre setTitle:@"Nov." forState:UIControlStateNormal];
    
    agendaButtonNovembre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonNovembre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [novembreView addSubview:agendaButtonNovembre];
    
    agendaLastButtonNovembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaLastButtonNovembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaLastButtonNovembre.tag = 1;
    
    [agendaLastButtonNovembre setTitle:@"Nov." forState:UIControlStateNormal];
    
    agendaLastButtonNovembre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaLastButtonNovembre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [novembreLastView addSubview:agendaLastButtonNovembre];
    
    
    // december
    
    agendaButtonDecembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaButtonDecembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaButtonDecembre.tag = 1;
    
    [agendaButtonDecembre setTitle:@"Dec." forState:UIControlStateNormal];
    
    agendaButtonDecembre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaButtonDecembre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [decembreView addSubview:agendaButtonDecembre];
    
    agendaLastButtonDecembre = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    
    [agendaLastButtonDecembre addTarget:self action:@selector(showTable:) forControlEvents:UIControlEventTouchUpInside];
    
    // Passing parameter to button
    agendaLastButtonDecembre.tag = 1;
    
    [agendaLastButtonDecembre setTitle:@"Dec." forState:UIControlStateNormal];
    
    agendaLastButtonDecembre.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    
    [agendaLastButtonDecembre setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
    
    [decembreLastView addSubview:agendaLastButtonDecembre];
    
    
    
#pragma mark - Navigation Controller
    
    
    
    
    self.navigationItem.title = @"Agenda";
    //self.navigationItem.tintColor = [UIColor whiteColor];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showMenu)];
    
    self.navigationItem.hidesBackButton = YES;
    
    
    // By default, press october
    
    // [agendaButtonOctobre sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Init table
    
    
    [self.view addSubview:infosTableView];
    
    items = [[NSArray alloc] initWithObjects:@"", nil];
    
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
- (void)viewWillAppear:(BOOL)animated
{
    //Réinstancie la navigation bar, une fois le menu disparu
    //self.navigationController.navigationBar.tintColor = [UIColor r:219 g:25 b:23 alpha:1];
    [super viewWillAppear:animated];
    
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
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
{/*
  
  
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
  
  
  
  
  
  // Reloading table properties in casse where another button was already selected before
  
  
  
  NSLog(@"test");
  
  
  //Add the tableview as sa subview of our view ---> making "view" our superview.
  
  // Animate add sub view
  
  
  
  [infosTableView setFrame:CGRectMake(self.view.frame.origin.x, 40, self.view.frame.size.width, self.view.frame.size.height)];
  
  
  [self.view addSubview:infosTableView];
  
  items = [[NSArray alloc] initWithObjects:@"", nil];
  
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
  
  
  
  
  */}






#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    
    if([self tableView:tableView canCollapseSection:section])
    {
        if([expandedSections containsIndex:section])
        {
            return 2;
        }
        
        return 1;
    }
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row)
    {
        return 120;
        
    } else return 490;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Where we configure the cell in each row
    
    
    
    // Remove dateLabel and headerTitle
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row) {
            
            // Set data according to month
            
            
            
            // Date label
            
            dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 23, 45, 40)];
            
            dateLabel.text = @"13.10.13 17.12.13";
            
            dateLabel.numberOfLines = 2;
            
            dateLabel.font = [UIFont fontWithName:@"Parisine-Italic" size:11];
            
            
            [cell addSubview:dateLabel];
            
            // Filet date
            
            UIImageView *contentFilet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filetRougeAgenda.png"]];
            
            [contentFilet sizeToFit];
            
            UIView *contentFiletView = [[UIView alloc] initWithFrame:CGRectMake(15, 60, 30, contentFilet.frame.size.height)];
            
            [contentFiletView addSubview:contentFilet];
            
            [cell addSubview:contentFiletView];
            
            
            
            // Header title
            
            headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 25, 164, 70)];
            
            
            headerTitle.text = @"Ambassade d'Australie";
            
            headerTitle.numberOfLines = 1;
            
            headerTitle.font = [UIFont fontWithName:@"Parisine-Bold" size:14];
            
            [headerTitle sizeToFit];
            
            [cell addSubview:headerTitle];
            
            // Header content
            
            headerText = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 200, 42)];
            
            headerText.text = @"Minutes to Midnight et Coming Soon de Trent Parke et Between Worlds de Polixeni Papapetrou";
            
            headerText.numberOfLines = 3;
            
            headerText.font = [UIFont fontWithName:@"Parisine" size:12];
            
            [cell addSubview:headerText];
            
            
            
            
            
            
        }
        else if (indexPath.row == 1)
        {
            
            // Contenu jour intro
            
            UILabel *contentIntro = [[UILabel alloc] initWithFrame:CGRectMake(22, 15, 250, 85)];
            
            contentIntro.text = @"Dans le cadre de Photoquai 2011, l'Ambassade d'Australie à Paris est heureuse de présenter l'exposition « Minutes to Midnight » et « Coming Soon » de Trent Parke et « Between Worlds » de Polixeni Papapetrou.";
            
            contentIntro.numberOfLines = 5;
            
            contentIntro.font = [UIFont fontWithName:@"Parisine-Italic" size:12];
            
            contentIntro.textColor = [UIColor whiteColor];
            
            contentIntro.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
            
            [cell addSubview:contentIntro];
            
            // Contenu jour filet
            
            UIImageView *contentFilet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filetRougeAgenda.png"]];
            
            UIView *contentFiletView = [[UIView alloc] initWithFrame:CGRectMake(22, 115, contentFilet.frame.size.width, contentFilet.frame.size.height)];
            
            [contentFiletView addSubview:contentFilet];
            
            [cell addSubview:contentFiletView];
            
            UIImageView *contentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"agendaPhoto.png"]];
            
            UIView *contentImageView = [[UIView alloc] initWithFrame:CGRectMake(22, 145, contentImage.frame.size.width, contentImage.frame.size.height)];
            
            [contentImageView addSubview:contentImage];
            
            [cell addSubview:contentImageView];
            
            UILabel *contentImageLegend = [[UILabel alloc] initWithFrame:CGRectMake(22, 150 + contentImage.frame.size.height , 290, 10)];
            
            contentImageLegend.text = @"Trent Parke, Pacific Highway Motel, 2006 © Trent Parke/Magnum";
            
            contentImageLegend.font = [UIFont fontWithName:@"Parisine-Italic" size:10];
            
            contentImageLegend.textColor = [UIColor whiteColor];
            
            contentImageLegend.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
            
            [cell addSubview:contentImageLegend];
            
            UILabel *contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(22, 170 + contentImage.frame.size.height , 290, 20)];
            
            contentTitle.text = @"Minutes to Midnight";
            
            contentTitle.font = [UIFont fontWithName:@"Parisine-bold" size:14];
            
            contentTitle.textColor = [UIColor whiteColor];
            
            contentTitle.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
            
            [cell addSubview:contentTitle];
            
            UILabel *contentContent = [[UILabel alloc] initWithFrame:CGRectMake(22, 184 + contentImage.frame.size.height , 290, 170)];
            
            contentContent.text =  @"Nous sommes en 2003. Le sort de la plus grande île du monde est dans la balance. Alors que le pays est assoiffé après la plus grande sècheresse de ces dernières décennies et que les incendies dévorent son territoire, que des invasion de pourceaux, de chats et de crapauds sauvages envahissent les campagnes détruisant tout sur leur passage, dans les grandes villes, les gens vivent dans l’ombre du terrorisme.";
            
            contentContent.numberOfLines = 9;
            
            
            contentContent.font = [UIFont fontWithName:@"Parisine" size:12];
            
            contentContent.textColor = [UIColor whiteColor];
            
            contentContent.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
            
            [cell addSubview:contentContent];
            
            cell.contentView.backgroundColor = [UIColor blackColor];
            
            
        }
        
        
        
        
        
        
    }
    else
    {
        //cell.textLabel.text = @"Fock";
    }
    
    
    // Set the background color when selected (default blue)
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}



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
            
            
            
        }
        
    }
    
    // Deselect the cell when changing page
    
    [self.infosTableView deselectRowAtIndexPath:[self.infosTableView indexPathForSelectedRow] animated:YES];
    
    
    
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
