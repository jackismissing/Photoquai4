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
    CGRect frameimg = CGRectMake(-10, 0, image3.size.width, image3.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(suppfavoris)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=mailbutton;
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate showTabBar:self.tabBarController];
    
    //[self showTabBar:self.tabBarController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Réinstancie la navigation bar, une fois le menu disparu
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.title = @"Favoris";
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSUserDefaults *preferencesUser = [NSUserDefaults standardUserDefaults];
    //favoritesPictures = [[NSArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisImages"]];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    myScrollView.opaque = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = YES;
    myScrollView.delegate = self;
    myScrollView.clipsToBounds = YES;
    
    
    int yPosition = 0, xPosition = 0;
    
    for (int i = 0; i < 8; i++) {
        xPosition++;
        if (i % 2 == 0) {
            xPosition = 0;
            
        }
        
        if (i % 2 == 0 && i != 0) {
            yPosition++;
        }
        
        NSLog(@"yPosition : %i", yPosition);
        
        ArtistFavoriteElement *artistFavoriteElement = [[ArtistFavoriteElement alloc] initWithFrame:CGRectMake(xPosition * 150 + 13, (yPosition * 189) + 15, 145, 200) withId:1];
        [artistFavoriteElement setIdColonne:xPosition];
        //NSLog(@"%i", artistFavoriteElement.idColonne);
        [myScrollView addSubview:artistFavoriteElement];
        
        UITapGestureRecognizer *accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
        [artistFavoriteElement addGestureRecognizer:accessPicture];
        
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
}

- (void) suppfavoris{
    NSLog(@"oki");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
