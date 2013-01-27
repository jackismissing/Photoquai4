//
//  ViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ViewController.h"
#import "AgendaController.h"
#import "ImageWall.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "UIColor+RVB255.h"
#import "PhotographyViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //récupère les favoris
    preferencesUser = [NSUserDefaults standardUserDefaults];
    //[preferencesUser removeObjectForKey:@"favorisImages"]; //Supprime tous les éléments d'une clé bien précise
    oldFavorites = [[NSArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisImages"]];
    [preferencesUser synchronize];
    
    [self setTitle:@"Photographies"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //Réinstancie la navigation bar, une fois le menu disparu
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
    
    thumbsContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    thumbsContainer.userInteractionEnabled = YES;
    
    //penser à recalculer la hauteur quand il y aura la navigation bar
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-40)];
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.delegate = self;
    //myScrollView.contentSize = CGSizeMake(130 * 5, 2000);
    //myScrollView.autoresizesSubviews = YES;
    myScrollView.zoomScale = .5;
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 5.0;
    [self.view addSubview:myScrollView];

    
    Reachability *reachabilityInfo;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connexionStateChanged:) name:@"loginComplete" object:reachabilityInfo];
    
    // Post a notification to loginComplete
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loginComplete" object:reachabilityInfo];
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate hideTabBar:self.tabBarController];
    
    [NSThread detachNewThreadSelector:@selector(loadingViewAsync) toTarget:self withObject:nil];
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

- (void) loadingViewAsync{
    i = 0;
    
    yPosition = 0, totalWidth = 0;
    widthThumb = 130;
    nbrColumns = 5;
    nbrPictures = 50;

    
    [self performSelectorInBackground:@selector(loadImageWall) withObject:nil];
    
    heights = [[NSMutableArray alloc] init];
    ys = [[NSMutableArray alloc] init];
}

- (void) loadImageWall{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int randomAnimate = (arc4random() % 2);
    
    
    if (i >= nbrPictures) return;
    
    //On vérifie que l'on a pas atteint le nombre maximal de colonnes
    imgIterate = i+5;
    
    xPosition++;
    if(i % nbrColumns == 0){
        
        xPosition = 0;
    }
    
    if(i >= nbrColumns){
        
        int h = [[heights objectAtIndex: (i - nbrColumns)] integerValue];
        int y = [[ys objectAtIndex: (i - nbrColumns)] integerValue];
        yPosition =  h + y + 15;
    }else{
        
        yPosition = 5;
    }
    
    NSMutableString *linkImg = [[NSMutableString alloc] init];
    NSInteger idPicture;
    
    if (i == 0) {
        [linkImg setString:@"http://nicolasgarnier.fr/phq/firstImgPHQ.png"];
        
    }else{
        
        NSString *appendLink = @"http://phq.cdnl.me/api/fr/pictures/";
        appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", imgIterate]];
        appendLink = [appendLink stringByAppendingString:@".json"];
        
        idPicture = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.id"] integerValue];
        linkImg = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.link_iphone"];
    }
    
    imageWallElement = [[ImageWall alloc] initWithFrame:CGRectMake(0, yPosition, widthThumb, 75)
                                          imageURL:linkImg
                                          colonne:[NSNumber numberWithInt:xPosition]];
    
    imageWallElement.alpha = 0;
    imageWallElement.opaque = YES;
    imageWallElement.clipsToBounds = NO;
    
    int height = [imageWallElement height];
    int width = [imageWallElement width];
    
    imageWallElement.frame = CGRectMake(((width + 5) * xPosition + 5), yPosition - 10, width, height); //L'image vient du haut
    
    imageWallElement.clipsToBounds = YES;
    imageWallElement.tag = idPicture;
    
    
    if ([oldFavorites containsObject:[NSNumber numberWithInt:idPicture]]){
        UIImage*    backgroundImage = [UIImage imageNamed:@"etoilejaune"];
        CALayer*    aLayer = [CALayer layer];
        CGRect startFrame = CGRectMake(width - 25, 0.0, 25, 25);
        aLayer.contents = (id)backgroundImage.CGImage;
        aLayer.frame = startFrame;
        
        [imageWallElement.layer addSublayer:aLayer];
    }
    
    [heights addObject: [NSNumber numberWithInt: imageWallElement.frame.size.height]];
    [ys addObject: [NSNumber numberWithInt: imageWallElement.frame.origin.y]];
    
    [UIView beginAnimations:@"fadeIn" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:imageWallElement];
    imageWallElement.alpha = 1.0;
    imageWallElement.frame = CGRectMake(((width + 5) * xPosition + 5), yPosition, width, height);
    
    [UIView commitAnimations];
    
    if (i != 0) { //Ne place pas l'écouteur d'évènement du clic sur la première image, celle du logo PHQ
        UITapGestureRecognizer *accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
        [imageWallElement addGestureRecognizer:accessPicture];
    }
    
    [thumbsContainer addSubview:imageWallElement];
    i++;
    [self performSelectorInBackground:@selector(loadImageWall) withObject:nil];
    
    //Calcul de la hauteur de la scrollview
    int heightMax = 0;
    //heightColumn récupère la hauteur de chaque colonne
    for (int heightColumn = 0; heightColumn < nbrColumns ; heightColumn++) {
        
        int hauteurColonne = 0;
        for(ImageWall *view in thumbsContainer.subviews){
            
            int idColonne = [[view idColonne] integerValue];
            if (idColonne == heightColumn) {
                
                hauteurColonne += [view height] + 5;
            }
        }
        
        if (hauteurColonne > heightMax) {
            
            heightMax = hauteurColonne + 5;
        }
    }
    
    totalWidth = (imageWallElement.frame.size.width * nbrColumns) + (nbrColumns * 6); //Le chiffre 6 étant les marges entre chaque vue
    
    
    [myScrollView addSubview:thumbsContainer];
    
    thumbsContainer.frame = CGRectMake(0, 0, totalWidth, heightMax + 21);

    [myScrollView setContentSize:CGSizeMake(totalWidth, heightMax + 21)];
    //Place le catalogue à une valeur aléatoire
    float randNumY = (arc4random() % heightMax);
    float randNumX = (arc4random() % totalWidth);
    
    CGPoint offset;
    offset.x = randNumX;
    offset.y = randNumY;
}

//Gère le pinch to zoom gesture
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return thumbsContainer;
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
    
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:nil action:nil];
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:v];
    //backButton.image = [UIImage imageNamed:@"backButton"];
    
    //[self.navigationItem setBackBarButtonItem: backButton];
}

/*- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    for (UIImageView *img in thumbsContainer.subviews){
        if(img.frame.origin.y < myScrollView.contentOffset.y || img.frame.origin.y > (myScrollView.contentOffset.y + myScrollView.frame.size.height) || img.frame.origin.x < myScrollView.contentOffset.x || img.frame.origin.x > (myScrollView.contentOffset.x + myScrollView.frame.size.width))
        {            
            img.alpha = .3;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    for (UIImageView *img in thumbsContainer.subviews){
        if(img.frame.origin.y > myScrollView.contentOffset.y || img.frame.origin.y < (myScrollView.contentOffset.y + myScrollView.frame.size.height) || img.frame.origin.x > myScrollView.contentOffset.x || img.frame.origin.x < (myScrollView.contentOffset.x + myScrollView.frame.size.width))
        {
            //[myScrollView bringSubviewToFront:img];
            img.hidden = NO;
            img.opaque = YES;
            [UIImageView beginAnimations:@"fadeIn" context:NULL];
            [UIImageView setAnimationDuration:0.5];
            img.alpha = 1.0;
            [UIImageView commitAnimations];
        }
    }
}*/


/*-(void)changeViewToAgenda{

    AgendaController *agenda = [[AgendaController alloc] init] ;
    [self.navigationController pushViewController:agenda animated:YES];
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
