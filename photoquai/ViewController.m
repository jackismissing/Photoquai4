//
//  ViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 15/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#define   DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

#import "ViewController.h"
#import "AgendaController.h"
#import "ImageWall.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "UIColor+RVB255.h"
#import "PhotographyViewController.h"


@interface ViewController (){
    int randomNumber;
}

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
    
    [self setTitle:@"Galerie"];
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
    myScrollView.contentSize = CGSizeMake(130 * 5, 2000);
    myScrollView.autoresizesSubviews = YES;
    myScrollView.zoomScale = 1.7;
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 3.0;
    [self.view addSubview:myScrollView];

    
    Reachability *reachabilityInfo;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connexionStateChanged:) name:@"loginComplete" object:reachabilityInfo];
    
    // Post a notification to loginComplete
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loginComplete" object:reachabilityInfo];
    
    //AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [NSThread detachNewThreadSelector:@selector(loadingViewAsync) toTarget:self withObject:nil];
   
}

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
    
    UIButton *fetchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];
    [fetchBtn addTarget:self action:@selector(filterImages) forControlEvents:UIControlEventTouchUpInside];
    fetchBtn.backgroundColor = [UIColor clearColor];
    [fetchBtn setImage:[UIImage imageNamed:@"filtres"] forState:UIControlStateNormal];
    //[self.view addSubview:cancelBtn];
    
    UIView *rightNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightNavigationButtons addSubview:fetchBtn];
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButtons];
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;
    
    UIBarButtonItem* menuBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    [self.navigationItem setLeftBarButtonItem:menuBarButtonItem];
    
    //Accéléromètre
    UIAccelerometer *testAccel = [UIAccelerometer sharedAccelerometer];
    testAccel.delegate = self;
    testAccel.updateInterval = 0.1f;
    
    
}


//Gestion du shake
- (BOOL) canBecomeFirstResponder{
    return YES; //La vue se charge de prendre les évènements
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        PhotographyViewController *imageViewController = [[PhotographyViewController alloc] initWithNibName:@"PhotographyViewController" bundle:nil];
        imageViewController.idPicture = randomNumber;
        [self.navigationController pushViewController:imageViewController animated:YES];
    }
    [super motionEnded:motion withEvent:event];
}

//On génère un chiffre entre 0 et le nombre de photographies affichées
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        randomNumber = arc4random() % nbrPictures; 
    }
    [super motionBegan:motion withEvent:event];
}
//Gestion du shake

- (void) loadingViewAsync{
    i = 0;
    
    yPosition = 0, totalWidth = 0;
    widthThumb = 130;
    nbrColumns = 5;
    nbrPictures = 100;

    
    [self performSelectorInBackground:@selector(loadImageWall) withObject:nil];
    
    heights = [[NSMutableArray alloc] init];
    ys = [[NSMutableArray alloc] init];
}

- (void) loadImageWall{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    
    [navigationController setNavigationBarHidden:NO animated:NO];
    
    // You can even set the style of stuff before you show it
    //navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // And now you want to present the view in a modal fashion all nice and animated
    [self presentModalViewController:navigationController animated:YES];
    
    
   // [self presentModalViewController:mainMenu animated:YES];
}

- (void)accessPicture:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    [self.view setNeedsDisplay];
    index.alpha = .5;
    //index.backgroundColor = [UIColor redColor];
    
    // Set up the shape of the circle
    int radius = 42;
    
    float midX = ((index.frame.size.width - radius) / 2);
    float midY = ((index.frame.size.height - radius) / 2);
   
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(midX, midY, radius, radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    //circle.position = CGPointMake(midX, midY);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor whiteColor].CGColor;
    circle.lineWidth = 3;
    
    // Add to parent layer
    [index.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 0.42; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
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
                         [circle removeFromSuperlayer];
                     }];
    
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStylePlain target:nil action:nil];
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:v];
    //backButton.image = [UIImage imageNamed:@"backButton"];
    
    //[self.navigationItem setBackBarButtonItem: backButton];
}

- (void) filterImages{
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:filterViewController];
    [self presentModalViewController:navigationController animated:YES];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Dispose of any resources that can be recreated.
}


@end
