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

@interface ArtistsLisViewController ()

@end

@implementation ArtistsLisViewController
@synthesize sections;
@synthesize artistsTable;

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
    
    artistsList = [[NSMutableArray alloc] init];
    
    self.sections = [[NSMutableDictionary alloc] init];
    
    self.artistsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    
    self.artistsTable.delegate = self;
    self.artistsTable.dataSource = self;
    
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
    
        
    NSDictionary *artistInfos = [[NSDictionary alloc] initWithObjectsAndKeys:(id)idArtist, @"artistId", lastNameArtist, @"artistName", firstNameArtist, @"artistFirstName", nil];
    
    
    
    // Add single artist infos to NSMutableArray
    
    [artistsList addObject:artistInfos];
    
    // Order artistsList by name (e.g order by name within NSMutableArray Objects
    
    [artistsList sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"artistName" ascending:YES], nil]];
    
    //NSLog(@"%@", artistInfos);
    
        
    i++;
    [self performSelectorInBackground:@selector(loadArtists) withObject:nil];
    

    NSLog(@"%u", i);
    
    
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

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [artistsTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *artistInfos = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [artistInfos objectForKey:@"artistName"];
    cell.detailTextLabel.text = [artistInfos objectForKey:@"artistFirstName"];
    
    return cell;
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
