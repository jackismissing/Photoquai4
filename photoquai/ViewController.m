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

@interface ViewController ()

@end

@implementation ViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showMenu)];
    
    thumbsContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    thumbsContainer.userInteractionEnabled = YES;
    
    //penser à recalculer la hauteur quand il y aura la navigation bar
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 440)];
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.delegate = self;
    myScrollView.autoresizesSubviews = YES;
    myScrollView.minimumZoomScale = 0.5;
    myScrollView.maximumZoomScale = 5.0;
    [self.view addSubview:myScrollView];
    
    Reachability *reachabilityInfo;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connexionStateChanged:)
                                                 name:@"loginComplete" object:reachabilityInfo];
    
    // Post a notification to loginComplete
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginComplete" object:reachabilityInfo];
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
    
    yPosition = 0, totalWidth = 0;
    widthThumb = 130;
    nbrColumns = 5;
    nbrPictures = 50;
    
    [self performSelectorInBackground:@selector(loadImageWall) withObject:nil];
    
    heights = [[NSMutableArray alloc] init];
    ys = [[NSMutableArray alloc] init];
}

- (void) loadImageWall{
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];

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
        yPosition =  h + y + 5;
    }else{
        
        yPosition = 5;
    }
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/pictures/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", imgIterate]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    NSInteger idPicture = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.id"] integerValue];
    NSString *linkImg = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.link_iphone"];
    
    
    imageWallElement = [[ImageWall alloc] initWithFrame:CGRectMake(0, yPosition, widthThumb, 75)
                                               imageURL:linkImg
                                                colonne:[NSNumber numberWithInt:xPosition]];
    imageWallElement.alpha = 0;
    imageWallElement.opaque = YES;
    imageWallElement.clipsToBounds = NO;
    
    int height = [imageWallElement height];
    int width = [imageWallElement width];
    
    imageWallElement.frame = CGRectMake(((width + 5) * xPosition + 5), yPosition, width, height);
    imageWallElement.clipsToBounds = YES;
    imageWallElement.tag = idPicture;
    //imageWallElement.layer.borderColor = (__bridge CGColorRef)([UIColor purpleColor]);
    //imageWallElement.layer.borderWidth = 3.0f;
    
    //    CALayer *bottomBorder = [CALayer layer];
    //
    //    bottomBorder.frame = CGRectMake(0.0f, imageWallElement.frame.size.height - 1, 50, 50.0f);
    //
    //    bottomBorder.backgroundColor = (__bridge CGColorRef)([UIImage imageNamed:@"coeur"]);
    //[UIColor colorWithRed:.9 green:.1 blue:.9 alpha:1.0f].CGColor;
    
//    UIImage*    backgroundImage = [UIImage imageNamed:@"coeur"];
//    CALayer*    aLayer = [CALayer layer];
//    CGFloat nativeWidth = CGImageGetWidth(backgroundImage.CGImage);
//    CGFloat nativeHeight = CGImageGetHeight(backgroundImage.CGImage);
//    CGRect      startFrame = CGRectMake(width - nativeWidth, 0.0, nativeWidth, nativeHeight);
//    aLayer.contents = (id)backgroundImage.CGImage;
//    aLayer.frame = startFrame;
    
    //[imageWallElement.layer addSublayer:aLayer];
    
    [heights addObject: [NSNumber numberWithInt: imageWallElement.frame.size.height]];
    [ys addObject: [NSNumber numberWithInt: imageWallElement.frame.origin.y]];
    
    [UIView beginAnimations:@"fadeIn" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:imageWallElement];
    imageWallElement.alpha = 1.0;
    [UIView commitAnimations];
    
    UITapGestureRecognizer *accessPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accessPicture:)];
    [imageWallElement addGestureRecognizer:accessPicture];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeAndHoldFrom:)];
    longPressRecognizer.delegate = self;
    longPressRecognizer.cancelsTouchesInView = NO;
    [longPressRecognizer setMinimumPressDuration:0.5];
    //[longPressRecognizer setEnabled:NO];
    [imageWallElement addGestureRecognizer:longPressRecognizer];
    
    [thumbsContainer addSubview:imageWallElement];
    i++;
    [self performSelectorInBackground:@selector(loadImageWall) withObject:nil];
    
    //Calcul de la hauteur
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
    
    thumbsContainer.frame = CGRectMake(0, 0, totalWidth, heightMax);
    
    [myScrollView setContentSize:CGSizeMake(totalWidth, heightMax + 21)];
    //Place le catalogue à une valeur aléatoire
    float randNumY = (arc4random() % heightMax);
    float randNumX = (arc4random() % totalWidth);
    
    CGPoint offset;
    offset.x = randNumX;
    offset.y = randNumY;
    //[myScrollView setContentOffset:offset animated:NO];
}

//Gère le pinch to zoom gesture
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return thumbsContainer;
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

- (void)accessPicture:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    NSLog(@"%i", index.tag);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    for (UIImageView *img in thumbsContainer.subviews){
        if(img.frame.origin.y < myScrollView.contentOffset.y || img.frame.origin.y > (myScrollView.contentOffset.y + myScrollView.frame.size.height) || img.frame.origin.x < myScrollView.contentOffset.x || img.frame.origin.x > (myScrollView.contentOffset.x + myScrollView.frame.size.width))
        {
            //[img removeFromSuperview];
            //img.hidden = YES;
            //img.opaque = NO;
            
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
}

/*-(void)changeViewToAgenda{

    AgendaController *agenda = [[AgendaController alloc] init] ;
    [self.navigationController pushViewController:agenda animated:YES];
}*/


@end
