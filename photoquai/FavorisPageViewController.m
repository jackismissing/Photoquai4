//
//  FavorisPageViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 30/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FavorisPageViewController.h"

@interface FavorisPageViewController ()

@end

@implementation FavorisPageViewController

- (void)viewWillAppear:(BOOL)animated
{
    //Réinstancie la navigation bar, une fois le menu disparu
    //self.navigationController.navigationBar.tintColor = [UIColor r:219 g:25 b:23 alpha:1];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage* image = [UIImage imageNamed:@"menu.png"];
    CGRect frame = CGRectMake(0, 0, image.size.width + 20, image.size.height);
    UIButton *menuButton = [[UIButton alloc] initWithFrame:frame];
    [menuButton setImage:image forState:UIControlStateNormal];
    //[menuButton setShowsTouchWhenHighlighted:YES];
    
    [menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* menuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    [self.navigationItem setLeftBarButtonItem:menuBarButtonItem];
    
    UIImage* image3 = [UIImage imageNamed:@"poubelle"];
    //CGRect frameimg = CGRectMake(-100, 0, image3.size.width, image3.size.height);
    removeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];
    [removeButton setImage:image3 forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(suppfavoris) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *rightNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightNavigationButtons addSubview:removeButton];
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButtons];
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;
    
    UIBarButtonItem *removeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:removeButton];
    self.navigationItem.rightBarButtonItem = removeButtonItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Vos favoris";
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    removeEnabled = NO; //La suppression de favoris n'est pas actif par défaut
    
    NSUserDefaults *preferencesUser = [NSUserDefaults standardUserDefaults];
    favoritesPictures = [[NSMutableArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisImages"]];
    favoritesPhotographers = [[NSMutableArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisPhotographes"]];
    favoritesToRemove = [[NSMutableArray alloc] init];
    
    //Notification liée au bouton de toolbar actif
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPageFavorites:) name:@"setPageFavorites" object:nil];
    //Notification pour accéder à la fiche artiste
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessPhotographer:) name:@"accessPhotographer" object:nil];
    //Notification de la supression des favoris
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeFavorites) name:@"removeFavorites" object:nil];
    
    if ([favoritesPictures count] == 0 && [favoritesPhotographers count] == 0) {
        CustomAlertView *alert = [[CustomAlertView alloc]
                                  initWithTitle:nil
                                  message:@"Vous n'avez pas de favoris pour le moment."
                                  delegate:self
                                  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 55)];
    myScrollView.opaque = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = YES;
    //myScrollView.delegate = self;
    myScrollView.clipsToBounds = YES;
    
    myScrollView.backgroundColor = [UIColor whiteColor];
   [self.view addSubview:myScrollView];
    
    
    
    
    toolbarFavorites = [[ToolBarFavorites alloc] initWithFrame:CGRectMake(0, (screenHeight - 119), screenWidth, 55)];
    [self.view addSubview:toolbarFavorites];
    
    fakeActionSheet = [[FakeActionSheet alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:fakeActionSheet];
    
    [self performSelectorInBackground:@selector(loadFavoritesPictures) withObject:nil];
    //[self loadFavoritesPictures];
} //Fin du view didload



#pragma mark - Suppression des élements

//Active la possibilité de supprimer des favoris
- (void) suppfavoris{
    if(removeEnabled == NO){
        [fakeActionSheet show];
        removeEnabled = YES;
        if (tabEnabled == 0) {
            for(FavoriteElement *view in myScrollView.subviews){
                [view removeGestureRecognizer:accessPicture];
                selectFavorites2Remove = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFavorites2Remove:)];
                [view addGestureRecognizer:selectFavorites2Remove];
                
                
                UIImage*    backgroundImage = [UIImage imageNamed:@"favorite2remove"];
                CALayer*    crossLayer = [CALayer layer];
                crossLayer.opacity = .3;
                CGRect startFrame = CGRectMake(view.frame.size.width - 30, view.frame.size.height - 30, 30, 30);
                crossLayer.contents = (id)backgroundImage.CGImage;
                crossLayer.frame = startFrame;
                crossLayer.opaque = YES;
                [view.layer addSublayer:crossLayer];
            }
        }else{
            for(ArtistFavoriteElement *view in myScrollView.subviews){
                [view removeGestureRecognizer:accessPhotographer];
                selectFavorites2Remove = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFavorites2Remove:)];
                [view addGestureRecognizer:selectFavorites2Remove];
                
                
                UIImage*    backgroundImage = [UIImage imageNamed:@"favorite2remove"];
                CALayer*    crossLayer = [CALayer layer];
                crossLayer.opacity = .3;
                CGRect startFrame = CGRectMake(view.frame.size.width - 30, view.frame.size.height - 30, 30, 30);
                crossLayer.contents = (id)backgroundImage.CGImage;
                crossLayer.frame = startFrame;
                crossLayer.opaque = YES;
                [view.layer addSublayer:crossLayer];
            }
        }
    }
    //Lorsque l'on active l'option, il n'est plus possible d'appuyer une nouvelle fois
    [removeButton removeTarget:self action:@selector(suppfavoris) forControlEvents:UIControlEventTouchUpInside];
    removeButton.alpha = .5;
//    }else{
//        [fakeActionSheet hide];
//        removeEnabled = NO;
//        if (tabEnabled == 0) {
//            for(FavoriteElement *view in myScrollView.subviews){
//                [view removeGestureRecognizer:selectFavorites2Remove];
//                accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
//                [view addGestureRecognizer:accessPicture];
//                
//                view.layer.sublayers = nil;
////                for (CALayer *layer in view.layer.sublayers) {
////                    NSLog(@"truc");
////                    [layer removeFromSuperlayer];
////                    break;
////                }
//            }
//        }else{
//            for(ArtistFavoriteElement *view in myScrollView.subviews){
//                [view removeGestureRecognizer:selectFavorites2Remove];
//                accessPhotographer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPhotographer:)];
//                [view addGestureRecognizer:accessPhotographer];
//                
//                
//                for (CALayer *layer in view.layer.sublayers) {
//                    [layer removeFromSuperlayer];
//                    break;
//                    
//                }
//            }
//        }
//        
//    }
}


- (void) setPageFavorites:(NSNotification *)notification{
    NSInteger idToolBarItem = [[notification object] integerValue];
    tabEnabled = idToolBarItem;
    switch (idToolBarItem) {
        case 0: //Description volet
        {
            
            toolbarFavorites.photographersFavoritesImage.image = [UIImage imageNamed:@"favoris-artistes-off"];
            toolbarFavorites.photosFavoritesImage.image = [UIImage imageNamed:@"favoris-photos-on"];
            toolbarFavorites.photographersFavoritesLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            toolbarFavorites.photosFavoritesLabel.textColor = [UIColor whiteColor];
            myScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight - 119);
            for (UIView *view in myScrollView.subviews) {
                
                [UIView animateWithDuration:.42
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     view.layer.anchorPoint = CGPointMake(0.5, 0.5);
                                     view.transform = CGAffineTransformMakeScale(1, 0.001);
                                     view.alpha = 0;
                                 }
                                 completion:^(BOOL finished){
                                     [view removeFromSuperview];
                                     //for (UIView *view in myScrollView.subviews) {
                                         //[[view viewWithTag:[[favoritesToRemove objectAtIndex:i] intValue]] removeFromSuperview];
                                         
                                     //}
                                     //[self loadFavoritesPictures];
                                 }];
                
            }
            [self loadFavoritesPictures];
        }break;
        case 1:
        {
            
            toolbarFavorites.photographersFavoritesImage.image = [UIImage imageNamed:@"favoris-artistes-on"];
            toolbarFavorites.photosFavoritesImage.image = [UIImage imageNamed:@"favoris-photos-off"];
            toolbarFavorites.photographersFavoritesLabel.textColor = [UIColor whiteColor];
            toolbarFavorites.photosFavoritesLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            myScrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight - 119);
     
            for (UIView *view in myScrollView.subviews) {
                
                [UIView animateWithDuration:.42
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     view.layer.anchorPoint = CGPointMake(0.5, 0.5);
                                     view.transform = CGAffineTransformMakeScale(1, 0.001);
                                     view.alpha = 0;
                                 }
                                 completion:^(BOOL finished){
                                     //for (UIView *view in myScrollView.subviews) {
                                         [view removeFromSuperview];
                                         //}
                                     //[self loadFavoritesPhotographers];
                                 }];
                
            }[self loadFavoritesPhotographers];
        }break;
    }
}

- (void) removeFavorites{ //Supprime les favoris
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    removeEnabled = NO;
    [fakeActionSheet hide];
    [removeButton addTarget:self action:@selector(suppfavoris) forControlEvents:UIControlEventTouchUpInside];
    removeButton.alpha = 1;
    if (tabEnabled == 0) {
        
        for (int i = 0; i < [favoritesToRemove count]; i++) {
            for (FavoriteElement *view in myScrollView.subviews) {
                if (view.tag == [[favoritesToRemove objectAtIndex:i] intValue]) {
                    [UIView animateWithDuration:.42
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
                                         [self loadFavoritesPictures];
                                     }];
                }
            }
            
            [favoritesPictures removeObject:[favoritesToRemove objectAtIndex:i]];
        }
        
        [defaults setObject:favoritesPictures forKey:@"favorisImages"];
        [defaults synchronize];
    }else{
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
                                         [self loadFavoritesPhotographers];
                                     }];
                }
            }
            [favoritesPhotographers removeObject:[favoritesToRemove objectAtIndex:i]];
        }
        
        [defaults setObject:favoritesPhotographers forKey:@"favorisPhotographes"];
        [defaults synchronize];
    }
}

- (void) selectFavorites2Remove:(UIGestureRecognizer *)gesture{ //On sélectionne les favoris à supprimer
    UIView *index = gesture.view;
//    index.layer.borderColor = [UIColor redColor].CGColor;
//    index.layer.borderWidth = 1.0f;
    
    NSNumber *favorite = [NSNumber numberWithInteger:index.tag];
    
    if (tabEnabled == 0) {
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
        }
    }else{
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
        }
    }
}

#pragma mark - Affichage des pages

- (void) loadFavoritesPictures{
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int xPosition = 0;
    int yPosition = 10;
    
    NSMutableArray *heights = [[NSMutableArray alloc] init];
    NSMutableArray *ys = [[NSMutableArray alloc] init];
    
    for (int imgIterate = 0; imgIterate < [favoritesPictures count]; imgIterate++) {
        xPosition++;
        
        if (imgIterate % 2 == 0) {
            xPosition = 0;
        }
        
        if(imgIterate >= 2){
            int h = [[heights objectAtIndex: (imgIterate - 2)] integerValue];
            int y = [[ys objectAtIndex: (imgIterate - 2)] integerValue];
            yPosition =  h + y + 5;
        }else{
            yPosition = 5;
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
        accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
        [favoritePictureElement addGestureRecognizer:accessPicture];
        
        [heights addObject: [NSNumber numberWithInt: favoritePictureElement.frame.size.height]];
        [ys addObject: [NSNumber numberWithInt: favoritePictureElement.frame.origin.y]];
        
        [myScrollView addSubview:favoritePictureElement];
        
        //Calcul de la hauteur de la scrollview
        int heightMax = 0;
        //heightColumn récupère la hauteur de chaque colonne
        for (int heightColumn = 0; heightColumn < 2 ; heightColumn++) {
            
            int hauteurColonne = 0;
            for(FavoriteElement *view in myScrollView.subviews){
                //NSLog(@"view : %@", view);
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
}

- (void) loadFavoritesPhotographers{
    
    int yPosition = 0, xPosition = 0;
    
    for (int i = 0; i < [favoritesPhotographers count]; i++) {
        xPosition++;
        if (i % 2 == 0) {
            xPosition = 0;
        }
        
        if (i % 2 == 0 && i != 0) {
            yPosition++;
        }
        
        artistFavoriteElement = [[ArtistFavoriteElement alloc] initWithFrame:CGRectMake(xPosition * 150 + 5, (yPosition * 189) + 5, 145, 200) withId:[[favoritesPhotographers objectAtIndex:i] intValue]];
        [artistFavoriteElement setIdColonne:xPosition];
        
        [myScrollView addSubview:artistFavoriteElement];
        int heightMax = (int) ([favoritesPhotographers count] * 200) / 2;
//        //Calcul de la hauteur de la scrollview
//        int heightMax = 0;
//        //heightColumn récupère la hauteur de chaque colonne
//        for (int heightColumn = 0; heightColumn < 1 ; heightColumn++) {
//            
//            int hauteurColonne = 0;
//            for(ArtistFavoriteElement *view in myScrollView.subviews){
//                
//                int idColonne = [view idColonne];
//                if (idColonne == heightColumn) {
//                    
//                    hauteurColonne += view.frame.size.height + 15;
//                }
//            }
//            
//            if (hauteurColonne > heightMax) {
//                
//                heightMax = hauteurColonne + 5;
//            }
//        }
        
        [myScrollView setContentSize:CGSizeMake(320, heightMax + 70)];
    }
    
    [self.view addSubview:myScrollView];
    
    fakeActionSheet = [[FakeActionSheet alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:fakeActionSheet];
}

#pragma mark - Gestion de tap des élements de le vue
- (void) accessPhotographer:(NSNotification *)notification{
    
    PhotographerViewController *imageViewController = [[PhotographerViewController alloc] initWithNibName:@"PhotographerViewController" bundle:nil];
    imageViewController.idPhotographer = [[notification object] intValue];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void)accessPicture:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    
    PhotographyViewController *imageViewController = [[PhotographyViewController alloc] initWithNibName:@"PhotographyViewController" bundle:nil];
    imageViewController.idPicture = index.tag;
    [self.navigationController pushViewController:imageViewController animated:YES];
}


- (void)showMenu
{
    NavigationViewController *mainMenu = [[NavigationViewController alloc] init];
    mainMenu.delegate = self;
    
    // This is where you wrap the view up nicely in a navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainMenu];
    
    [navigationController setNavigationBarHidden:NO animated:NO];
    
    // You can even set the style of stuff before you show it
    //navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // And now you want to present the view in a modal fashion all nice and animated
    [self presentModalViewController:navigationController animated:YES];
    
    
    // [self presentModalViewController:mainMenu animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
