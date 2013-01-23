//
//  ArtistsLisViewController.m
//  photoquai
//
//  Created by Nicolas on 20/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ArtistsLisViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "NavigationViewController.h"

#define NAME_TAG 1

#define FIRSTNAME_TAG 1

#define ARTISTCOVER_TAG 1

#define ARTISTAVATAR_TAG 1


@interface ArtistsLisViewController ()

@end

@implementation ArtistsLisViewController
@synthesize sections;
@synthesize artistsTable;
@synthesize tableMenuScrollView;
@synthesize cellBackground;

@synthesize nameLabel;
@synthesize firstNameLabel;

@synthesize artistCover;
@synthesize artistAvatar;

@synthesize disclosure;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        Reachability *reachabilityInfo;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(connexionStateChanged:)
                                                     name:@"loginComplete" object:reachabilityInfo];
        
        // Post a notification to loginComplete
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginComplete" object:reachabilityInfo];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
#pragma mark - Navigation Controller
    
    
    //self.navigationItem.titleView = customLabel;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"Artistes";
    //self.navigationItem.tintColor = [UIColor whiteColor];
    
    // Menu scroll view
    
    self.tableMenuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [self.tableMenuScrollView setShowsHorizontalScrollIndicator:NO];
    [self.tableMenuScrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, 50) animated:NO];
    [self.tableMenuScrollView setDelegate:self];
    
    [self.view addSubview:tableMenuScrollView];

    
    artistsList = [[NSMutableArray alloc] init];
    
    self.sections = [[NSMutableDictionary alloc] init];
    
    cellNumber = 0;
    
    self.artistsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.tableMenuScrollView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - self.tableMenuScrollView.frame.size.height) style:UITableViewStylePlain];
    
    self.artistsTable.delegate = self;
    self.artistsTable.dataSource = self;
    
    [artistsTable reloadData];
    
    [self.view addSubview:artistsTable];
    
        
    
}

-(void)viewWillAppear:(BOOL)animated
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
    
    // Custom menu Scroll View
    
    self.tableMenuScrollView.backgroundColor = [UIColor blackColor];
    
    // Table View
    
    self.artistsTable.backgroundColor = [UIColor whiteColor];
    

    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Détecte la connexion d'un utilisateur
- (void)connexionStateChanged:(NSNotification*)notification{
    
    //Permet de savoir si l'utilisateur est connecté à Internet (Wi-fi, 3G, EDGE)
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) { //Oui, il l'est
        
        [NSThread detachNewThreadSelector:@selector(loadingViewAsync) toTarget:self withObject:nil];
    } else { // Non, on lui balance une erreur
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"Votre appareil n'est pas connecté à Internet. Pour profiter pleinement de l'expérience PHQ4, veuillez vous connecter à Internet."
                              delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) loadingViewAsync{
    i = 0;
    
    
    nbrArtists = 35;
    
    
    [self performSelectorInBackground:@selector(loadArtists) withObject:nil];
    
}

- (void)loadArtists
{
    
    //NSLog(@"Load artists");
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
    if (i >= nbrArtists) {
        
        // Sort artistsList and split into alphabetical sections
        // http://www.icodeblog.com/2010/12/10/implementing-uitableview-sections-from-an-nsarray-of-nsdictionary-objects/
        
        BOOL found;
        
        for (NSDictionary *artistIndex in artistsList) {
        
            NSString *c = [[artistIndex objectForKey:@"artistName"] substringToIndex:1];
            
            found = NO;
            
            for (NSString *str in [self.sections allKeys])
            {
                
                if ([str isEqualToString:c])
                {
                    found = YES;
                }
            
            }
            
            if (!found)
            {
                [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
            }
            
        
        
        }
        
        
        for (NSDictionary *artistIndex in artistsList)
        {
            [[self.sections objectForKey:[[artistIndex objectForKey:@"artistName"] substringToIndex:1]] addObject:artistIndex];
        }
        

        
        [self createTableMenu];
        
        [artistsTable reloadData];
                
        return;
        
    }
    

    artistsIterate = i+1;
    
    
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/photographers/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", artistsIterate]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    //NSLog(@"%@",appendLink);
    
    id idArtist = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.id"];
    
    //NSLog(@"%@",idArtist);
    
    NSString *lastNameArtist = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.lastname"];
    NSString *firstNameArtist = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.firstname"];
    NSString *avatarArtist = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.avatar.file.link"];
    NSString *coverArtist = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.cover.file.link"];
    
    UIImage *artistAvatarImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarArtist]]];
    
    UIImage *artistCoverImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:coverArtist]]];
    
        
    NSDictionary *artistInfos = [[NSDictionary alloc] initWithObjectsAndKeys:(id)idArtist, @"artistId", lastNameArtist, @"artistName", firstNameArtist, @"artistFirstName", artistAvatarImage, @"artistAvatar", artistCoverImage, @"artistCover", nil];
    
    //NSLog(@"%@", avatarArtist);
    //NSLog(@"%@", coverArtist);
    
    
    // Add single artist infos to NSMutableArray
    
    [artistsList addObject:artistInfos];
    
    // Order artistsList by name (e.g order by name within NSMutableArray Objects
    
    [artistsList sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"artistName" ascending:YES], nil]];
    
    //NSLog(@"%@", artistInfos);
    
        
    i++;
    [self performSelectorInBackground:@selector(loadArtists) withObject:nil];
    

    //NSLog(@"%u", i);
    
    
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

// Customize header section


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    
    
    UIImageView *artistsSeparator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"artistsSeparator.png"]];

    
    artistsSeparator.center = CGPointMake(headerView.bounds.size.width / 2, headerView.bounds.size.height /2);
    
    [headerView addSubview:artistsSeparator];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width / 2 - 10, 0, 20, headerView.frame.size.height)];
    
    headerTitle.text = [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    
    headerTitle.textAlignment = UITextAlignmentCenter;
    
    headerTitle.font = [UIFont fontWithName:@"Parisine-Bold" size:15];
    
    headerTitle.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
    
    [headerView addSubview:headerTitle];
    
    
    return headerView;
}
 
 

/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
 
 */

#pragma mark - Table willDisplay cell



#pragma mark - Table view cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d%d", indexPath.section, indexPath.row];
    
    NSLog(@"%@", CellIdentifier);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        // Custon disclosure
        
        //cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure.png"]];  ;
    

        
        
        
        // Création du label name de chaque cellule
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 72, 150, 18)];
        
        nameLabel.tag = NAME_TAG;
        
        nameLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:18];
        
        nameLabel.textColor = [UIColor blackColor];
        
        nameLabel.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
        
        [cell.contentView addSubview:nameLabel];
        
        // Création du label firstname de chaque cellule
        
        
        
        firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 75 + nameLabel.frame.size.height , 150, 18)];
        
        firstNameLabel.tag = FIRSTNAME_TAG;
        
        firstNameLabel.font = [UIFont fontWithName:@"Parisine-Italic" size:15];
        
        firstNameLabel.textColor = [UIColor grayColor];
        
        firstNameLabel.backgroundColor = [UIColor colorWithWhite:255 alpha:0];
        
        [cell.contentView addSubview:firstNameLabel];
        
        // Artist Cover
        
        artistCover = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 290, 60)];
        
        [cell.contentView addSubview:artistCover];
        
        // Artist avatar
        
         artistAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(25, 50, 73, 73)];
        
        [cell.contentView addSubview:artistAvatar];
        
        // Disclosure button
        
        disclosure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosure.png"]];
        
        disclosure.center = CGPointMake(cell.contentView.frame.size.width - 25, 90);
        
        [cell.contentView addSubview:disclosure];
  
        
        
    }
    
    NSDictionary *artistInfos = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    
    //[artistAvatar setImage:[artistInfos objectForKey:@"artistAvatar"]];
    
    // Set avatar, corp it in circle shape and add border
    
    artistAvatar.image = [artistInfos objectForKey:@"artistAvatar"];
    
    artistAvatar.layer.masksToBounds = YES;
    
    artistAvatar.layer.cornerRadius = 35;
    
    artistAvatar.layer.borderWidth = 2;
    
    artistAvatar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    artistCover.image = [artistInfos objectForKey:@"artistCover"];
    
    nameLabel.text = [artistInfos objectForKey:@"artistName"];
    firstNameLabel.text = [artistInfos objectForKey:@"artistFirstName"];
    
    // Artist Cover
    
    
    //[artistCover setImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[artistInfos objectForKey:@"artistCover"]]]]];
    

    
    //[artistAvatar setImage:[artistInfos objectForKey:@"artistAvatar"]];
    
    /*
    
    [artistAvatar setImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[artistInfos objectForKey:@"artistAvatar"]]]]];
     */
    
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}






-(void)createTableMenu
{
    
    
    // Navigation menu
    
    j = 0;
    
    for (NSString *index in [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)])
    {
        
        UIButton *indexButton = [[UIButton alloc] initWithFrame:CGRectMake(j*30, 15, 20, 20)];
        
        [indexButton addTarget:self action:@selector(scrollToSection:) forControlEvents:UIControlEventTouchUpInside];
        
        // Passing parameter to button
        indexButton.tag = j;
        
        [indexButton setTitle:index forState:UIControlStateNormal];
        
        indexButton.titleLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
        
        [indexButton setBackgroundColor:[UIColor colorWithWhite:255 alpha:0]];
        
        [tableMenuScrollView addSubview:indexButton];
        
        j++;
    }
    
    self.tableMenuScrollView.contentSize = CGSizeMake(j*30, 50);


}

- (void)scrollToSection : (id)sender;
{
    
    NSInteger section = ((UIControl *) sender).tag;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    [self.artistsTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
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

@end
