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
    
    UIImage* image3 = [UIImage imageNamed:@"poubelle"];
    CGRect frameimg = CGRectMake(-100, 0, image3.size.width, image3.size.height);
    UIButton *removeButton = [[UIButton alloc] initWithFrame:frameimg];
    [removeButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(suppfavoris) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *removeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:removeButton];
    self.navigationItem.rightBarButtonItem = removeButtonItem;

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
    favoritesPictures = [[NSMutableArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisImages"]];
    favoritesToRemove = [[NSMutableArray alloc] init];
    
    if ([favoritesPictures count] == 0) {
        CustomAlertView *alert = [[CustomAlertView alloc]
                                  initWithTitle:nil
                                  message:@"Vous n'avez pas de favoris pour le moment."
                                  delegate:self
                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];
        [alert show];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(2, 0, screenWidth, screenHeight-40)];
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = YES;
    myScrollView.delegate = self;
    myScrollView.clipsToBounds = YES;
    myScrollView.autoresizesSubviews = YES;
    myScrollView.pagingEnabled = YES;
    [self.view addSubview:myScrollView];
    
    fakeActionSheet = [[FakeActionSheet alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeFavorites) name:@"removeFavorites" object:nil];
    removeEnabled = NO; //La suppression de favoris n'est pas actif par défaut
    [self.view addSubview:fakeActionSheet];
    
    [self performSelectorInBackground:@selector(loadFavoritesPictures) withObject:nil];
} //Fin du view didload


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
        
        [myScrollView setContentSize:CGSizeMake(320, heightMax + 70)];
    }
}


- (void) suppfavoris{
    if(removeEnabled == NO){
        [fakeActionSheet show];
        removeEnabled = YES;
        for(FavoriteElement *view in myScrollView.subviews){
            selectFavorites2Remove = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFavorites2Remove:)];
            [view addGestureRecognizer:selectFavorites2Remove];
            [view removeGestureRecognizer:accessPicture];
            
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
        [fakeActionSheet hide];
        removeEnabled = NO;
        for(FavoriteElement *view in myScrollView.subviews){
            accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
            [view addGestureRecognizer:accessPicture];
            [view removeGestureRecognizer:selectFavorites2Remove];
            
            for (CALayer *layer in view.layer.sublayers) {
                    [layer removeFromSuperlayer];
                    break;
                
            }
        }
        
    }
}

- (void) removeFavorites{ //Supprime les favoris
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    removeEnabled = NO;
    
    if ([favoritesToRemove count] == 0) {
        CustomAlertView *alert = [[CustomAlertView alloc]
                                  initWithTitle:nil
                                  message:@"Vous n'avez pas sélectionné de favoris à supprimer"
                                  delegate:self
                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];
        [alert show];
    }
    
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
                                         //[[view viewWithTag:[[favoritesToRemove objectAtIndex:i] intValue]] removeFromSuperview];
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
