//
//  PhotographyViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "PhotographyViewController.h"



@interface PhotographyViewController ()

@end

@implementation PhotographyViewController

- (void)viewWillAppear:(BOOL)animated
{
    //Réinstancie la navigation bar, une fois le menu disparu
    //self.navigationController.navigationBar.tintColor = [UIColor r:219 g:25 b:23 alpha:1];
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar-photographie.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    // Bouton favoris
    UIImage *favouriteButtonImage = [UIImage imageNamed:@"etoilepush.png"];
    
    // Boutton shared
    UIImage *shareButtonImage = [UIImage imageNamed:@"share.png"];
    
        
    // rightNavigationButtons
    
    UIView *rightNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 84, shareButtonImage.size.height)];
    
    //rightNavigationButtons.clipsToBounds = YES;
    
    //rightNavigationButtons.backgroundColor =  [UIColor grayColor];
    
    //rightNavigationButtons.center = CGPointMake(-30, 0);
    
    //
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:shareButtonImage forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(favouriteButtonImage.size.width, 0, shareButtonImage.size.width, shareButtonImage.size.height);
    [shareButton addTarget:self action:@selector(addToFavorite) forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *shareCustomBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    //
    
    UIButton *favouriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [favouriteButton setImage:favouriteButtonImage forState:UIControlStateNormal];
    favouriteButton.frame = CGRectMake(0, rightNavigationButtons.frame.size.height/2 - favouriteButtonImage.size.height/2, favouriteButtonImage.size.width, favouriteButtonImage.size.height);
    [favouriteButton addTarget:self action:@selector(addToFavorite) forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *favouriteCustomBarItem = [[UIBarButtonItem alloc] initWithCustomView:favouriteButton];
    
    [rightNavigationButtons addSubview:favouriteButton];
    [rightNavigationButtons addSubview:shareButton];
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButtons];
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;

    [UIView animateWithDuration:0.5
                          delay:0.5
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         descriptionPhotography.frame = CGRectMake(0, 500, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                     }
                     completion:^(BOOL finished){}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor r:9 g:9 b:9 alpha:1];
    
    self.navigationItem.hidesBackButton = YES;
    
    [self setTitle:@"Title"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessPhotographerView:) name:@"showArtistPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showImageVolet:) name:@"showImageVolet" object:nil];

    
    //NSString *imageLink = [[machine getPictureElementsAtIndex:self.index] valueForKey:@"linkImg"];
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: imageLink]]];
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/pictures/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", self.idPicture]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    NSInteger idPicture = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.id"] integerValue];
    NSString *linkImg = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"picture.link_iphone"];
    
    NSLog(@"%@", linkImg);
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    picture = [[ImageZoomable alloc] initWithImageURL:[NSURL URLWithString:linkImg] andFrame:CGRectMake(0, 0, screenWidth, screenHeight-100)];


    picture.transform = CGAffineTransformMakeScale(1, 1);
    picture.userInteractionEnabled = YES;
    
    [self.view addSubview:picture];
    
    NSString *descriptionTextPhotography = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In euismod leo at mi posuere mollis. Morbi lacinia, felis ac ultrices auctor, magna sem tempus mi, nec blandit felis purus ut metus. Donec dolor mauris, eleifend id fermentum eu, placerat eget felis. Proin suscipit bibendum tincidunt.";
    NSString *titleTextPhotography = @"Gangnam Style";
    
    descriptionPhotography = [[DescriptionImageView alloc] initWithFrame:CGRectMake(0, 500, 320, 500) description:descriptionTextPhotography title:titleTextPhotography place:@"Maroc"];
    descriptionPhotography.userInteractionEnabled = YES;
    //[descriptionPhotography setUserInteractionEnabled:YES];
    [self.view addSubview:descriptionPhotography];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNavigation)];
    [picture addGestureRecognizer:singleTap];

    elementsNavigationAreHidden = NO; //Par défaut les élements de navigation ne sont pas affichés
    
    audioDescription = [[AudioImageView alloc] initWithFrame:CGRectMake(0, 500, screenWidth, 230) title:titleTextPhotography];
    [self.view addSubview:audioDescription];
    
    

    //Laisser en bas pour la que la toolbar passe devant les volets
    toolBar = [[ToolBarPhotography alloc] initWithFrame:CGRectMake(0, screenHeight - 118, 320, 55)];
    [self.view addSubview:toolBar];
}

- (void)addToFavorite
{
    
}

- (void) hideNavigation{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if(elementsNavigationAreHidden == NO){
        self.navigationController.navigationBarHidden = YES;
        elementsNavigationAreHidden = YES;
        toolBar.infosImage.image = [UIImage imageNamed:@"informations"];
        toolBar.infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
        toolBar.audioguideImage.image = [UIImage imageNamed:@"audioguide"];
        toolBar.audioguideLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
        toolBar.locationImage.image = [UIImage imageNamed:@"geoloc"];
        toolBar.locationLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             toolBar.frame = CGRectMake(0, 500, toolBar.frame.size.width, toolBar.frame.size.height);
                             audioDescription.frame = CGRectMake(0, 500, audioDescription.frame.size.width, audioDescription.frame.size.height);
                             descriptionPhotography.frame = CGRectMake(0, 500, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                             picture.frame = CGRectMake(0, 50, screenWidth, screenHeight);
                             picture.transform=CGAffineTransformMakeScale(1.2, 1.2);
                        }completion:^(BOOL finished){}];
        
    }else{
        self.navigationController.navigationBarHidden = NO;
        elementsNavigationAreHidden = NO;
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             toolBar.frame = CGRectMake(0, screenHeight - 118, toolBar.frame.size.width, toolBar.frame.size.height);
                             picture.transform=CGAffineTransformMakeScale(1, 1);
                             picture.frame = CGRectMake(0, 0, screenWidth, screenHeight-100);
                         }completion:^(BOOL finished){}];
    }
    
    
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) accessPhotographerView:(NSNotification *)notification{

    NSLog(@"%@", [notification object]);
}

- (void) showImageVolet:(NSNotification *)notification{
    
    
    NSInteger idToolBarItem = [[notification object] integerValue];
    
    switch (idToolBarItem) {
        case 0: //Description volet
        {
            if (descriptionPhotography.frame.origin.y == 50) {
                [UIView animateWithDuration:0.5
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     picture.transform=CGAffineTransformMakeScale(1, 1);
                                     descriptionPhotography.frame = CGRectMake(0, 500, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                                     descriptionPhotography.photographyDatas.contentOffset = CGPointMake(0, 0); //La description est cachée, on remet le scroll à l'endroit initial
                                 }completion:^(BOOL finished){}];
                
                
                toolBar.infosImage.image = [UIImage imageNamed:@"informations"];
                toolBar.infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            }else if (descriptionPhotography.frame.origin.y == 500){
                [UIView animateWithDuration:0.5
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     picture.transform=CGAffineTransformMakeScale(1.2, 1.2);
                                     descriptionPhotography.frame = CGRectMake(0, 50, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                                     audioDescription.frame = CGRectMake(0, 500, audioDescription.frame.size.width, audioDescription.frame.size.height);
                                     //locationPicture
                                 }
                                 completion:^(BOOL finished){}];
                
                toolBar.infosImage.image = [UIImage imageNamed:@"informations-blanc"];
                toolBar.infosLabel.textColor = [UIColor whiteColor];
            }
            
            toolBar.audioguideImage.image = [UIImage imageNamed:@"audioguide"];
            toolBar.audioguideLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            toolBar.locationImage.image = [UIImage imageNamed:@"geoloc"];
            toolBar.locationLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
        }
            break;
            
        case 1: //Audio volet
        {
            if (audioDescription.frame.origin.y == 132) {
                [UIView animateWithDuration:0.5
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     picture.transform=CGAffineTransformMakeScale(1, 1);
                                     audioDescription.frame = CGRectMake(0, 500, audioDescription.frame.size.width, audioDescription.frame.size.height);
                                 }completion:^(BOOL finished){}];
                
                
                toolBar.audioguideImage.image = [UIImage imageNamed:@"audioguide"];
                toolBar.audioguideLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            }else if (audioDescription.frame.origin.y == 500){
                [UIView animateWithDuration:0.5
                                      delay:0
                                    options: UIViewAnimationCurveEaseOut
                                 animations:^{
                                     picture.transform=CGAffineTransformMakeScale(1.2, 1.2);
                                     descriptionPhotography.frame = CGRectMake(0, 500, descriptionPhotography.frame.size.width, descriptionPhotography.frame.size.height);
                                     audioDescription.frame = CGRectMake(0, 132, audioDescription.frame.size.width, audioDescription.frame.size.height);
                                 }
                                 completion:^(BOOL finished){}];
                
                toolBar.audioguideImage.image = [UIImage imageNamed:@"audioguide-over"];
                toolBar.audioguideLabel.textColor = [UIColor whiteColor];
            }
            
            toolBar.infosImage.image = [UIImage imageNamed:@"informations"];
            toolBar.infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            toolBar.locationImage.image = [UIImage imageNamed:@"geoloc"];
            toolBar.locationLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
        }
            break;
            
        case 2:
        {
            
            
            toolBar.infosImage.image = [UIImage imageNamed:@"informations"];
            toolBar.infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
            toolBar.audioguideImage.image = [UIImage imageNamed:@"audioguide"];
            toolBar.audioguideLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
        }
            break;
            
        default:
            break;
    } //Fin switch
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"ok");
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
