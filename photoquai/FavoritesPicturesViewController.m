//
//  FavoritesPicturesViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 20/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FavoritesPicturesViewController.h"

@interface FavoritesPicturesViewController (){
    
    UIScrollView *myScrollView;
    
}

@end

@implementation FavoritesPicturesViewController

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
    
    NSUserDefaults *preferencesUser = [NSUserDefaults standardUserDefaults];
    favoritesPictures = [[NSArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisImages"]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(2, 0, screenWidth, screenHeight-40)];
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = YES;
    myScrollView.delegate = self;
    myScrollView.clipsToBounds = YES;
    myScrollView.autoresizesSubviews = YES;
    [self.view addSubview:myScrollView];
    
    [self performSelectorInBackground:@selector(loadFavoritesPictures) withObject:nil];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    [appdelegate showTabBar:self.tabBarController];
    
    
} //Fin du view didload



- (void) loadFavoritesPictures{
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
    int xPosition = 0;
    int yPosition = 10;
    
    NSMutableArray *heights = [[NSMutableArray alloc] init];
    NSMutableArray *ys = [[NSMutableArray alloc] init];
    
    for (int imgIterate = 0; imgIterate < [favoritesPictures count]; imgIterate++) {
        xPosition++;
        
        if (imgIterate % 2) {
            xPosition = 0;
        }
        
        if(imgIterate >= 2){
            int h = [[heights objectAtIndex: (imgIterate - 2)] integerValue];
            int y = [[ys objectAtIndex: (imgIterate - 2)] integerValue];
            yPosition =  h + y + 15;
        }else{
            yPosition = 10;
        }
        
        NSString *imgFavoriteIndex = [favoritesPictures objectAtIndex:imgIterate];
        NSString *appendLink = @"http://phq.cdnl.me/api/fr/pictures/";
        appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%@", imgFavoriteIndex]];
        appendLink = [appendLink stringByAppendingString:@".json"];
        
        NSInteger idPicture = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.id"] integerValue];
        NSString *linkImg = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.link_iphone"];
        
        FavoriteElement *favoritePictureElement = [[FavoriteElement alloc] initWithFrame:CGRectMake(0, yPosition + 15, 150, 500) imageURL:linkImg colonne:[NSNumber numberWithInt:xPosition]];
        
        int height = [favoritePictureElement.imageWallElement height];
        int width = [favoritePictureElement.imageWallElement width];
        float heightText = favoritePictureElement.heightText + 7;
        
        favoritePictureElement.frame = CGRectMake(((width + 5) * xPosition + 5), yPosition, width, height + heightText);
        
        favoritePictureElement.tag = idPicture;
        
        [heights addObject: [NSNumber numberWithInt: favoritePictureElement.frame.size.height]];
        [ys addObject: [NSNumber numberWithInt: favoritePictureElement.imageWallElement.frame.origin.y]];
        
        [myScrollView addSubview:favoritePictureElement];
        
        UITapGestureRecognizer *accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
        [favoritePictureElement addGestureRecognizer:accessPicture];
        
        //Calcul de la hauteur de la scrollview
        int heightMax = 0;
        //heightColumn récupère la hauteur de chaque colonne
        for (int heightColumn = 0; heightColumn < 2 ; heightColumn++) {
            
            int hauteurColonne = 0;
            for(ImageWall *view in myScrollView.subviews){
                
                int idColonne = [[view idColonne] integerValue];
                if (idColonne == heightColumn) {
                    
                    hauteurColonne += view.frame.size.height + 15;
                }
            }
            
            if (hauteurColonne > heightMax) {
                
                heightMax = hauteurColonne + 5;
            }
        }
        
        [myScrollView setContentSize:CGSizeMake(320, heightMax + 21)];
    }
}

- (void)accessPicture:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    
    index.alpha = .3;
    index.backgroundColor = [UIColor redColor];
    
    [UIView animateWithDuration:0.42
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         index.alpha = 1.0;
                         index.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished){
                         
                         PhotographyViewController *imageViewController = [[PhotographyViewController alloc] initWithNibName:@"PhotographyViewController" bundle:nil];
                         imageViewController.idPicture = index.tag;
                         [self.navigationController pushViewController:imageViewController animated:YES];
                     }];
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
