//
//  FavoritePhotographerViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 23/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FavoritePhotographerViewController.h"


@interface FavoritePhotographerViewController ()

@end

@implementation FavoritePhotographerViewController

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
    
    UIImage* image3 = [UIImage imageNamed:@"suppfavoris"];
    CGRect frameimg = CGRectMake(-100, 0, image3.size.width, image3.size.height);
    UIButton *removeButton = [[UIButton alloc] initWithFrame:frameimg];
    [removeButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(suppfavoris) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *removeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:removeButton];
    self.navigationItem.rightBarButtonItem = removeButtonItem;
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate showTabBar:self.tabBarController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessPhotographer:) name:@"accessPhotographer" object:nil];
    
    //Réinstancie la navigation bar, une fois le menu disparu
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"Favoris";
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    NSUserDefaults *preferencesUser = [NSUserDefaults standardUserDefaults];
    favoritesPhotographers = [[NSMutableArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisPhotographes"]];
    favoritesToRemove = [[NSMutableArray alloc] init];
    
    if ([favoritesPhotographers count] == 0) {
        CustomAlertView *alert = [[CustomAlertView alloc]
                                  initWithTitle:nil
                                  message:@"Vous n'avez pas de favoris pour le moment."
                                  delegate:self
                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];
        [alert show];
    }
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    myScrollView.opaque = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = YES;
    myScrollView.delegate = self;
    myScrollView.clipsToBounds = YES;
    
    removeEnabled = NO; //La suppression de favoris n'est pas actif par défaut
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeFavorites) name:@"removeFavorites" object:nil];
    
    
    [self loadFavoris];
}

- (void) loadFavoris{
    int yPosition = 0, xPosition = 0;
    
    for (int i = 0; i < [favoritesPhotographers count]; i++) {
        xPosition++;
        if (i % 2 == 0) {
            xPosition = 0;
        }
        
        if (i % 2 == 0 && i != 0) {
            yPosition++;
        }
        
        artistFavoriteElement = [[ArtistFavoriteElement alloc] initWithFrame:CGRectMake(xPosition * 150 + 13, (yPosition * 189) + 15, 145, 200) withId:[[favoritesPhotographers objectAtIndex:i] intValue]];
        [artistFavoriteElement setIdColonne:xPosition];
        
        [myScrollView addSubview:artistFavoriteElement];
        
        //Calcul de la hauteur de la scrollview
        int heightMax = 0;
        //heightColumn récupère la hauteur de chaque colonne
        for (int heightColumn = 0; heightColumn < 1 ; heightColumn++) {
            
            int hauteurColonne = 0;
            for(ArtistFavoriteElement *view in myScrollView.subviews){
                
                int idColonne = [view idColonne];
                if (idColonne == heightColumn) {
                    
                    hauteurColonne += view.frame.size.height + 15;
                }
            }
            
            if (hauteurColonne > heightMax) {
                
                heightMax = hauteurColonne + 5;
            }
        }
        
        [myScrollView setContentSize:CGSizeMake(320, heightMax + 70)];
    }
    
    [self.view addSubview:myScrollView];
    
    fakeActionSheet = [[FakeActionSheet alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:fakeActionSheet];
}

- (void) accessPhotographer:(NSNotification *)notification{
    
    PhotographerViewController *imageViewController = [[PhotographerViewController alloc] initWithNibName:@"PhotographerViewController" bundle:nil];
    imageViewController.idPhotographer = [[notification object] intValue];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void) suppfavoris{ //Activation de la possibilité de supprimer les favoris
    if(removeEnabled == NO){
        [fakeActionSheet show];
        removeEnabled = YES;
        for(ArtistFavoriteElement *view in myScrollView.subviews){
            selectFavorites2Remove = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFavorites2Remove:)];
            [view addGestureRecognizer:selectFavorites2Remove];
            [view removeGestureRecognizer:accessPhotographer];
        }
        myScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight - 75);
    }else{ 
        [fakeActionSheet hide];
        removeEnabled = NO;
        for(ArtistFavoriteElement *view in myScrollView.subviews){
            accessPhotographer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPhotographer:)];
            [view addGestureRecognizer:accessPhotographer];
            [view removeGestureRecognizer:selectFavorites2Remove];
        }
        myScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }
}


- (void) removeFavorites{ //Supprime les favoris
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    removeEnabled = NO;
//    
//    if ([favoritesToRemove count] == 0) {
//        CustomAlertView *alert = [[CustomAlertView alloc]
//                                  initWithTitle:nil
//                                  message:@"Vous n'avez pas sélectionné de favoris à supprimer"
//                                  delegate:self
//                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];
//        [alert show];
//    }
    
    for (int i = 0; i < [favoritesToRemove count]; i++) {
        for (ArtistFavoriteElement *view in myScrollView.subviews) {
            if (view.tag == [[favoritesToRemove objectAtIndex:i] intValue]) {
                [UIView animateWithDuration:0.42
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     view.layer.anchorPoint = CGPointMake(0.5, 0.5);
                                     view.transform = CGAffineTransformMakeScale(1, 0.001);
                                     view.alpha = 0;
                                 }
                                 completion:^(BOOL finished){
                                     for (UIView *view in myScrollView.subviews) {
                                         [view removeFromSuperview];
                                     }
                                     [self loadFavoris];
                                 }];
            }
        }
        [favoritesPhotographers removeObject:[favoritesToRemove objectAtIndex:i]];
    }
    
    [defaults setObject:favoritesPhotographers forKey:@"favorisPhotographes"];
    [defaults synchronize];
}

- (void) selectFavorites2Remove:(UIGestureRecognizer *)gesture{
    UIView *index = gesture.view;
    
    NSNumber *favorite = [NSNumber numberWithInteger:index.tag];

    UIImage*    backgroundImage = [UIImage imageNamed:@"favorite2remove"];
    CALayer*    crossLayer = [CALayer layer];
    CGRect startFrame = CGRectMake(index.frame.size.width - 30, index.frame.size.height - 30, 30, 30);
    crossLayer.contents = (id)backgroundImage.CGImage;
    crossLayer.frame = startFrame;
    
    crossLayer.opaque = YES;
    
    if (![favoritesToRemove containsObject:favorite]){ //On checke si le favoris n'a pas déjà été checké
        [favoritesToRemove addObject:favorite];
        [index.layer addSublayer:crossLayer];
        crossLayer.name = [NSString stringWithFormat:@"%i", index.tag];
    }else{
        [favoritesToRemove removeObject:favorite];
        for (CALayer *layer in index.layer.sublayers) {
            if ([layer.name isEqualToString:[NSString stringWithFormat:@"%i", index.tag]]) {
                [layer removeFromSuperlayer];
                break;
            }
        }
        
        
//        for (CALayer *layer in self.view.layer.sublayers) {
//            [layer removeFromSuperlayer];
//        }
    }
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
