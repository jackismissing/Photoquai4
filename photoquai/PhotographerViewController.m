//
//  PhotographerViewController.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "PhotographerViewController.h"


@interface PhotographerViewController ()

@end

@implementation PhotographerViewController

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
    
    UIImage *favouriteButtonImage;
    idPhotographer = [NSNumber numberWithInt:self.idPhotographer];
    // Bouton favoris
    if ([oldFavorites containsObject:idPhotographer] || [favoritesPhotographers containsObject:idPhotographer]){
        favouriteButtonImage = [UIImage imageNamed:@"etoilejaune"];
    }else{
        favouriteButtonImage = [UIImage imageNamed:@"etoilepush"];
    }
    
    // Boutton shared
    UIImage *shareButtonImage = [UIImage imageNamed:@"share.png"];
    
    
    UIView *rightNavigationButtons = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 84, shareButtonImage.size.height)];
    
    //rightNavigationButtons.clipsToBounds = YES;
    
    //rightNavigationButtons.backgroundColor =  [UIColor grayColor];
    
    //rightNavigationButtons.center = CGPointMake(-30, 0);
    
    //
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:shareButtonImage forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(favouriteButtonImage.size.width, 0, shareButtonImage.size.width, shareButtonImage.size.height);
    [shareButton addTarget:self action:@selector(sharePicture) forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *shareCustomBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    //
    
    favouriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [favouriteButton setImage:favouriteButtonImage forState:UIControlStateNormal];
    favouriteButton.frame = CGRectMake(0, rightNavigationButtons.frame.size.height/2 - favouriteButtonImage.size.height/2, favouriteButtonImage.size.width, favouriteButtonImage.size.height);
    [favouriteButton addTarget:self action:@selector(addToFavorites) forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *favouriteCustomBarItem = [[UIBarButtonItem alloc] initWithCustomView:favouriteButton];
    
    [rightNavigationButtons addSubview:favouriteButton];
    [rightNavigationButtons addSubview:shareButton];
    
    UIBarButtonItem *rightNavigationBarItems = [[UIBarButtonItem alloc] initWithCustomView:rightNavigationButtons];
    self.navigationItem.rightBarButtonItem = rightNavigationBarItems;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    // Do any additional setup after loading the view from its nib.
    
    descriptionIsFull = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessPicture:) name:@"accessPicture" object:nil];
    
    preferencesUser = [NSUserDefaults standardUserDefaults];
    oldFavorites = [[NSArray alloc] initWithArray: [preferencesUser objectForKey:@"favorisPhotographes"]];
    favoritesPhotographers = [[NSMutableArray alloc] initWithArray:oldFavorites];
    idPhotographer = [NSNumber numberWithInt:self.idPhotographer];
    
#pragma mark - Partage
    shareIsHidden = YES; //Par défaut les options de partage sont cachées
    popOver = [[CustomPopOver alloc] init];
    popOver.layer.anchorPoint = CGPointMake(1.0, 0.0);
    popOver.frame = CGRectMake(210, 0, 100, 100);
    popOver.alpha = 0;
    //popOver.center = CGPointMake(CGRectGetWidth(popOver.bounds), 0.0);
    
    // Rotate 90 degrees to hide it off screen
    CGAffineTransform rotationTransform = CGAffineTransformIdentity;
    rotationTransform = CGAffineTransformRotate(rotationTransform, 90);
    popOver.transform = rotationTransform;
    
    [self.view addSubview:popOver];
    
#pragma mark - Scrollview
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    myScrollView.opaque = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = YES;
    //myScrollView.delegate = self;
    myScrollView.alpha = 1;
    myScrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:myScrollView];
    [self loadPhotographersDatas:self.idPhotographer];
    //[self performSelectorInBackground:@selector(loadPhotographersDatas:) withObject:self.idPhotographer];
}

- (void) loadPhotographersDatas:(int)index{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/photographers/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", index]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    //récupération du json
    NSString *photographerPictureLink = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.cover.file.link"];
    NSString *firstnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.firstname"];
    NSString *lastnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.lastname"];
    
    // Coordonnées
    
    NSNumber *latitudeNumber = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.origin_location.latitude"];
    
    double latitude = [latitudeNumber doubleValue];
    
    NSNumber *longitudeNumber = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.origin_location.longitude"];
    
    double longitude = [longitudeNumber doubleValue];
    
    

    // NSString *picturesBrut = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.pictures"];
    
    NSDictionary *photographerPicturesDict = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.pictures"];
    photographerPictures = [photographerPicturesDict valueForKey:@"link_iphone"];
    photographerPicturesIds = [photographerPicturesDict valueForKey:@"id"];
    
    //NSLog(@"photographerPictures : %@", photographerPictures);
    
    patronymPhotographer = [[NSString alloc] initWithString:firstnamePhotographer];
    patronymPhotographer = [patronymPhotographer stringByAppendingString:@" "];
    patronymPhotographer = [patronymPhotographer stringByAppendingString:lastnamePhotographer];
    
    UIImageView *photographerPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
    photographerPicture.opaque = YES;
    photographerPicture.contentMode = UIViewContentModeScaleAspectFill;
    [photographerPicture setImageWithURL:[NSURL URLWithString:photographerPictureLink]];
    
    CALayer *bottomBorderPatronymPhotographerView = [CALayer layer];
    bottomBorderPatronymPhotographerView.frame = CGRectMake(0.0f, photographerPicture.frame.size.height, photographerPicture.frame.size.width, 2.0f);
    bottomBorderPatronymPhotographerView.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1].CGColor;
    [photographerPicture.layer addSublayer:bottomBorderPatronymPhotographerView];
    
    [myScrollView addSubview:photographerPicture];
    
    UIImage *buttonImage = [UIImage imageNamed:@"globe"];
    
    photographerLocalisationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photographerLocalisationButton setImage:buttonImage forState:UIControlStateNormal];
    photographerLocalisationButton.backgroundColor = [UIColor r:35 g:35 b:35 alpha:1];
    photographerLocalisationButton.frame = CGRectMake(screenWidth - 70, photographerPicture.frame.size.height - 17.5, 40, 35);
    [photographerLocalisationButton addTarget:self action:@selector(displayPhotographerLocation) forControlEvents:UIControlEventTouchUpInside];
    
    float contentUnderPhotographerPictureY = photographerPicture.frame.size.height + photographerPicture.frame.origin.y;
    
    // localiser l'artiste sur la map
    
    //  /////////////////////////////////////////////////////////////////////////////////// MAP /////////////////
    
    photographerLocationMap = [[MKMapView alloc] initWithFrame:CGRectMake((screenWidth/2), contentUnderPhotographerPictureY - 73, screenWidth, 150)];

    photographerLocationMap.layer.anchorPoint = CGPointMake(1, 0); //Déplace le centre
    photographerLocationMap.transform = CGAffineTransformMakeScale(1, 0.001);
    [myScrollView addSubview:photographerLocationMap];
    
    // Zoom to artist's coordinates
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude = longitude;
    
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 3000*METERS_PER_MILE, 3000*METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [photographerLocationMap regionThatFits:viewRegion];
    
    [photographerLocationMap setRegion:adjustedRegion animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    
    point.coordinate = coordinate;
       
    [photographerLocationMap addAnnotation:point];
    
    
    //Content
    contentUnderPhotographerPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, contentUnderPhotographerPictureY, screenWidth, 100)];
    contentUnderPhotographerPicture.userInteractionEnabled = YES;
    contentUnderPhotographerPicture.backgroundColor = [UIColor clearColor];
    contentUnderPhotographerPicture.clipsToBounds = YES;
    
    UILabel *patronymPhotographerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 120, 15)];
    patronymPhotographerLabel.text = patronymPhotographer;
    patronymPhotographerLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:17];
    patronymPhotographerLabel.backgroundColor = [UIColor clearColor];
    [contentUnderPhotographerPicture addSubview:patronymPhotographerLabel];
    
    [patronymPhotographerLabel sizeToFit];
    
    float originPhotographerLabelY = patronymPhotographerLabel.frame.origin.y + patronymPhotographerLabel.frame.size.height;
    UILabel *originPhotographerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, originPhotographerLabelY + 5, 75, 15)];
    originPhotographerLabel.text = @"Groland";
    originPhotographerLabel.font = [UIFont fontWithName:@"Parisine-Italic" size:11];
    originPhotographerLabel.textColor = [UIColor r:102 g:102 b:102 alpha:1];
    originPhotographerLabel.backgroundColor = [UIColor clearColor];
    [contentUnderPhotographerPicture addSubview:originPhotographerLabel];
    
    float descriptionPhotographerY = originPhotographerLabel.frame.origin.y + originPhotographerLabel.frame.size.height;
   
    descriptionPhotographer = [[UITextView alloc] initWithFrame:CGRectMake(10, descriptionPhotographerY, screenWidth * .85, 150)];
    descriptionPhotographer.text = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.description"];
    descriptionPhotographer.editable = NO;
    descriptionPhotographer.userInteractionEnabled = NO;
    descriptionPhotographer.textColor = [UIColor r:51 g:51 b:51 alpha:1];
    descriptionPhotographer.font = [UIFont fontWithName:@"Parisine-Regular" size:11];
    
    [contentUnderPhotographerPicture addSubview:descriptionPhotographer];
    
    displayFullDescriptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    displayFullDescriptionButton.frame = CGRectMake(15, descriptionPhotographer.frame.size.height + descriptionPhotographer.frame.origin.y + 15, screenWidth * .9, 35);
    displayFullDescriptionButton.layer.borderColor = [UIColor r:215 g:215 b:215 alpha:1].CGColor;
    displayFullDescriptionButton.layer.borderWidth = 1.0;
    displayFullDescriptionButton.clipsToBounds = YES;
    
    displayFullDescriptionButton.backgroundColor = [UIColor r:236 g:236 b:236 alpha:1];
    [displayFullDescriptionButton setTitle:@"Afficher +" forState:UIControlStateNormal];

    displayFullDescriptionButton.titleLabel.textColor = [UIColor r:106 g:106 b:106 alpha:1];
    [displayFullDescriptionButton addTarget:self action:@selector(displayFullDescription) forControlEvents:UIControlEventTouchUpInside];
    
    [contentUnderPhotographerPicture addSubview:displayFullDescriptionButton];
    
    float contentUnderPhotographerPictureHeight = patronymPhotographerLabel.frame.origin.y + patronymPhotographerLabel.frame.size.height + originPhotographerLabel.frame.size.height + originPhotographerLabel.frame.origin.y + descriptionPhotographer.frame.size.height + 15;
    
    float sliderContentY = contentUnderPhotographerPictureHeight + photographerPicture.frame.size.height + photographerPicture.frame.origin.y + 15;
    sliderContent = [[UIView alloc] initWithFrame:CGRectMake(0, sliderContentY, screenWidth, 260)];
    sliderContent.backgroundColor = [UIColor blackColor];
    
    UILabel *sliderTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 35, 10)];
    sliderTitle.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
    sliderTitle.textColor = [UIColor whiteColor];
    sliderTitle.backgroundColor = [UIColor clearColor];
    sliderTitle.text = @"Ses photographies";
    [sliderContent addSubview:sliderTitle];
    [sliderTitle sizeToFit];
    
    sliderImages = [[SliderImage alloc] initWithImages:photographerPictures withIndexes:photographerPicturesIds atPosition:CGRectMake(0, sliderTitle.frame.origin.y + sliderTitle.frame.size.height + 15, screenWidth - 150, 200)];
    //sliderImages.delegate = self;
    [sliderContent addSubview:sliderImages];
    
    

    contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPictureY, screenHeight, contentUnderPhotographerPictureHeight);
    
    [myScrollView addSubview:contentUnderPhotographerPicture];
    [myScrollView addSubview:sliderContent];
    [sliderContent sizeToFit];
    //[contentUnderPhotographerPicture sizeToFit];
    NSLog(@"contentUnderPhotographerPicture : %f", contentUnderPhotographerPicture.frame.size.height);
    
    myScrollViewHeight = photographerPicture.frame.size.height + contentUnderPhotographerPicture.frame.size.height + sliderContent.frame.size.height + 75;
    myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight);
    descriptionPhotographer.frame = CGRectMake(10, descriptionPhotographerY, screenWidth * .85, 150);
    
    [myScrollView addSubview:photographerLocalisationButton];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [myScrollView setContentOffset:CGPointMake(0, sliderContent.frame.origin.y) animated:YES];
}

- (void)addToFavorites
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![favoritesPhotographers containsObject:idPhotographer]){
        [favoritesPhotographers addObject:idPhotographer];
        [defaults setObject:favoritesPhotographers forKey:@"favorisPhotographes"];
        [defaults synchronize];
        
        FavoriteIndicator *favoriteIndicator = [[FavoriteIndicator alloc] initWithFrame:CGRectMake(0, 0, 320, 540)];
        
        favoriteIndicator.message.text = [patronymPhotographer stringByAppendingString:@" a été ajouté à vos favoris"];
        [self.view addSubview:favoriteIndicator];
        [favoriteIndicator show];
        
//        CustomAlertView *alert = [[CustomAlertView alloc]
//                                  initWithTitle:nil
//                                  message:[patronymPhotographer stringByAppendingString:@" a été ajouté à vos favoris"]
//                                  delegate:self
//                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];

        
        [favouriteButton setImage:[UIImage imageNamed:@"etoilejaune"] forState:UIControlStateNormal];
        
//        [alert show];
    }else{
        [favoritesPhotographers removeObject:idPhotographer];
        
        [defaults setObject:favoritesPhotographers forKey:@"favorisPhotographes"];
        [defaults synchronize];
        
        FavoriteIndicator *favoriteIndicator = [[FavoriteIndicator alloc] initWithFrame:CGRectMake(0, 0, 320, 540)];
        
        favoriteIndicator.message.text = [patronymPhotographer stringByAppendingString:@" a été supprimée de vos favoris"];
        [self.view addSubview:favoriteIndicator];
        [favoriteIndicator show];
        
//        CustomAlertView *alert = [[CustomAlertView alloc]
//                                  initWithTitle:nil
//                                  message:[patronymPhotographer stringByAppendingString:@" a été supprimé de vos favoris"]
//                                  delegate:self
//                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];
//        [alert show];

        
        [favouriteButton setImage:[UIImage imageNamed:@"etoilepush"] forState:UIControlStateNormal];
    }
}


- (void) sharePicture{
    
    if(shareIsHidden){ //Les options de partage ne sont pas là... on les affiche
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             popOver.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
                             popOver.alpha = 1;
                         }
                         completion:^(BOOL finished){}];
        shareIsHidden = NO;
    }else{
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             popOver.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 3);
                             popOver.alpha = 0;
                         }
                         completion:^(BOOL finished){}];
        shareIsHidden = YES;
    }
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

// Gestion des mails

- (void) sendMailImage:(NSNotification *)notification{
    MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
    mailer.mailComposeDelegate = self;
    [mailer setSubject:@"Regarde ce qu'il y a à PHQ"];
    
//    UIImage *picturePHQMail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:linkImg]]];
//    NSData *imageData = UIImagePNGRepresentation(picturePHQMail);
//    [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"PHQPhotography"];
//    NSString *emailBody = @"J'apprécie cette photo de l'exposition PHQ";
//    [mailer setMessageBody:emailBody isHTML:NO];
//    [self presentModalViewController:mailer animated:YES];
}

//Annulation du mail
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error{
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         popOver.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 3);
                         popOver.alpha = 0;
                         shareIsHidden = YES;
                     }completion:^(BOOL finished){}];
    [self dismissModalViewControllerAnimated:YES];
    return;
}

- (void) accessPhotographerPage:(NSNotification *)notification{
    
    PhotographerViewController *imageViewController = [[PhotographerViewController alloc] initWithNibName:@"PhotographerViewController" bundle:nil];
    imageViewController.idPhotographer = [[notification object] intValue];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void)accessPicture:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.42
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                        
                     }
                     completion:^(BOOL finished){
                         
                         //PhotographyViewController *imageViewController = [[PhotographyViewController alloc] initWithNibName:@"PhotographyViewController" bundle:nil];
                         //imageViewController.idPicture = [[notification object] intValue];
                         //[self.navigationController pushViewController:imageViewController animated:YES];
                         
                         SliderViewController *sliderImageViewController = [[SliderViewController alloc] initWithNibName:nil bundle:nil];
                         sliderImageViewController.arrayImages = photographerPictures;
                         sliderImageViewController.arrayIndexes = photographerPicturesIds;
                         sliderImageViewController.patronymPhotographer = patronymPhotographer;
                         
                         UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:sliderImageViewController];
                         [self presentModalViewController:navigationController animated:YES];
                         //[self presentModalViewController:sliderImage animated:YES];
                     }];
}

- (void) displayPhotographerLocation{
    if (descriptionIsFull == YES) {
        [displayFullDescriptionButton setTitle:@"Afficher +" forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             descriptionPhotographer.frame = CGRectMake(10, 60, screenWidth * .85, 150);
                             myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight);
                             displayFullDescriptionButton.frame = CGRectMake(15,
                                                                             descriptionPhotographer.frame.size.height +
                                                                             descriptionPhotographer.frame.origin.y + 15,
                                                                             screenWidth * .9,
                                                                             35);
                             contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPicture.frame.origin.y, screenWidth, 310);
                             sliderContent.frame = CGRectMake(0, sliderContent.frame.origin.y - frame.size.height + 150, screenWidth, sliderContent.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             descriptionIsFull = NO;
                         }];
    }
    
    if (photographerLocationIsVisible == NO) { //La carte apparait
        myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight + 130);
        [photographerLocalisationButton removeTarget:self action:@selector(displayPhotographerLocation) forControlEvents:UIControlEventTouchUpInside];
        UIImage *buttonImage = [UIImage imageNamed:@"closeMap"];
        [photographerLocalisationButton setImage:buttonImage forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             photographerLocationMap.transform = CGAffineTransformMakeScale(1, 1);
                             contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPicture.frame.origin.y + 155, screenHeight, contentUnderPhotographerPicture.frame.size.height);
                             sliderContent.frame = CGRectMake(0, sliderContent.frame.origin.y + 165, screenWidth, sliderContent.frame.size.height);
                             myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight + 165);
                         }
                         completion:^(BOOL finished){
                             photographerLocationIsVisible = YES;
                             [photographerLocalisationButton addTarget:self action:@selector(displayPhotographerLocation) forControlEvents:UIControlEventTouchUpInside];
                         }];
    }else{ //La carte disparait
           //myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight - 20);
        [photographerLocalisationButton removeTarget:self action:@selector(displayPhotographerLocation) forControlEvents:UIControlEventTouchUpInside];
        UIImage *buttonImage = [UIImage imageNamed:@"globe"];
        [photographerLocalisationButton setImage:buttonImage forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             photographerLocationMap.transform = CGAffineTransformMakeScale(1, 0.001);
                             contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPicture.frame.origin.y - 155, screenHeight, contentUnderPhotographerPicture.frame.size.height);
                             myScrollView.contentOffset = CGPointMake(0, 0);
                             myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight);
                             sliderContent.frame = CGRectMake(0, sliderContent.frame.origin.y - 165, screenWidth, sliderContent.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             photographerLocationIsVisible = NO;
                             [photographerLocalisationButton addTarget:self action:@selector(displayPhotographerLocation) forControlEvents:UIControlEventTouchUpInside];
                         }];
    }
}

- (void) displayFullDescription{
    frame = descriptionPhotographer.frame;
    frame.size = descriptionPhotographer.contentSize;
    
    if (photographerLocationIsVisible == YES) {
        UIImage *buttonImage = [UIImage imageNamed:@"globe"];
        [photographerLocalisationButton setImage:buttonImage forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             photographerLocationMap.transform = CGAffineTransformMakeScale(1, 0.001);
                             contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPicture.frame.origin.y - 155, screenHeight, contentUnderPhotographerPicture.frame.size.height);
                             myScrollView.contentOffset = CGPointMake(0, 0);
                             myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight);
                             sliderContent.frame = CGRectMake(0, sliderContent.frame.origin.y - 165, screenWidth, sliderContent.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             photographerLocationIsVisible = NO;
                         }];
    }
    
    if (descriptionIsFull == NO) { //La description se déroule
        [displayFullDescriptionButton setTitle:@"Afficher -" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             descriptionPhotographer.frame = frame;
                             displayFullDescriptionButton.frame = CGRectMake(15, descriptionPhotographer.frame.origin.y + frame.size.height + 15, screenWidth * .9, 35);
                             myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight + frame.size.height - 146);
                             contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPicture.frame.origin.y, screenWidth, frame.size.height + 115);
                             sliderContent.frame = CGRectMake(0, sliderContent.frame.origin.y + frame.size.height - 150, screenWidth, sliderContent.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){
                             descriptionIsFull = YES;
                         }];
    }else{
        [displayFullDescriptionButton setTitle:@"Afficher +" forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             descriptionPhotographer.frame = CGRectMake(10, 60, screenWidth * .85, 150);
                             myScrollView.contentSize = CGSizeMake(screenWidth, myScrollViewHeight);
                             displayFullDescriptionButton.frame = CGRectMake(15,
                                                                             descriptionPhotographer.frame.size.height +
                                                                             descriptionPhotographer.frame.origin.y + 15,
                                                                             screenWidth * .9,
                                                                             35);
                             contentUnderPhotographerPicture.frame = CGRectMake(0, contentUnderPhotographerPicture.frame.origin.y, screenWidth, 310);
                             sliderContent.frame = CGRectMake(0, sliderContent.frame.origin.y - frame.size.height + 150, screenWidth, sliderContent.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             descriptionIsFull = NO;
                         }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
