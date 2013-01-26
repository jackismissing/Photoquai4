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
    
    [self loadPhotographersDatas:self.idPhotographer];
    
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
}

- (void) loadPhotographersDatas:(int)index{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *appendLink = @"http://phq.cdnl.me/api/fr/photographers/";
    appendLink = [appendLink stringByAppendingString:[NSString stringWithFormat:@"%d", index]];
    appendLink = [appendLink stringByAppendingString:@".json"];
    
    NSString *firstnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.firstname"];
    NSString *lastnamePhotographer = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.lastname"];
    patronymPhotographer = [[NSString alloc] initWithString:firstnamePhotographer];
    patronymPhotographer = [patronymPhotographer stringByAppendingString:@" "];
    patronymPhotographer = [patronymPhotographer stringByAppendingString:lastnamePhotographer];
    
    
    UIView *patronymPhotographerView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 70)];
    patronymPhotographerView.backgroundColor = [UIColor whiteColor];
    
    CALayer *bottomBorderPatronymPhotographerView = [CALayer layer];
    bottomBorderPatronymPhotographerView.frame = CGRectMake(0.0f, patronymPhotographerView.frame.size.height, patronymPhotographerView.frame.size.width, 2.0f);
    bottomBorderPatronymPhotographerView.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1].CGColor;
    [patronymPhotographerView.layer addSublayer:bottomBorderPatronymPhotographerView];
    
    CALayer *topBorderPatronymPhotographerView = [CALayer layer];
    topBorderPatronymPhotographerView.frame = CGRectMake(0.0f, 0.0f, patronymPhotographerView.frame.size.width, 2.0f);
    topBorderPatronymPhotographerView.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1].CGColor;
    [patronymPhotographerView.layer addSublayer:topBorderPatronymPhotographerView];
    
    [self.view addSubview:patronymPhotographerView];
    
    UILabel *patronymPhotographerLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - 90) / 2, 25, 120, 15)];
    patronymPhotographerLabel.text = patronymPhotographer;
    patronymPhotographerLabel.font = [UIFont fontWithName:@"Parisine-Bold" size:15];
    [patronymPhotographerView addSubview:patronymPhotographerLabel];
    [patronymPhotographerLabel sizeToFit];
    
    UITextView *descriptionPhotographer = [[UITextView alloc] initWithFrame:CGRectMake(0, patronymPhotographerView.frame.origin.y + patronymPhotographerView.frame.size.height + 10, screenWidth * .8, screenHeight)];
    descriptionPhotographer.text = [[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"photographer.description"];
    descriptionPhotographer.editable = NO;
    descriptionPhotographer.textColor = [UIColor blackColor];
    descriptionPhotographer.font = [UIFont fontWithName:@"Parisine-Regular" size:11];
    [self.view addSubview:descriptionPhotographer];
    CGRect frame = descriptionPhotographer.frame;
    frame.size.height = descriptionPhotographer.contentSize.height;
    //descriptionPhotographer.frame = frame;
    descriptionPhotographer.contentSize = CGSizeMake(descriptionPhotographer.frame.size.width, frame.size.height + 10);
    descriptionPhotographer.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    self.navigationItem.title = patronymPhotographer;
}


- (void)addToFavorites
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![favoritesPhotographers containsObject:idPhotographer]){
        [favoritesPhotographers addObject:idPhotographer];
        [defaults setObject:favoritesPhotographers forKey:@"favorisPhotographes"];
        [defaults synchronize];
        
        CustomAlertView *alert = [[CustomAlertView alloc]
                                  initWithTitle:nil
                                  message:[patronymPhotographer stringByAppendingString:@" a été ajouté à vos favoris"]
                                  delegate:self
                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];

        
        [favouriteButton setImage:[UIImage imageNamed:@"etoilejaune"] forState:UIControlStateNormal];
        
        [alert show];
    }else{
        [favoritesPhotographers removeObject:idPhotographer];
        
        [defaults setObject:favoritesPhotographers forKey:@"favorisPhotographes"];
        [defaults synchronize];
        
        
        CustomAlertView *alert = [[CustomAlertView alloc]
                                  initWithTitle:nil
                                  message:[patronymPhotographer stringByAppendingString:@" a été supprimé de vos favoris"]
                                  delegate:self
                                  cancelButtonTitle:@"OK" otherButtonTitles:@"Favoris", nil];
        [alert show];

        
        [favouriteButton setImage:[UIImage imageNamed:@"etoilepush"] forState:UIControlStateNormal];

    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        FavoritePhotographerViewController *favoritesPictures = [[FavoritePhotographerViewController alloc] init];
        [self.navigationController pushViewController:favoritesPictures animated:YES];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
