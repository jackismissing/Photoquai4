//
//  FacebookPopOver.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 29/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FacebookPopOver.h"

@implementation FacebookPopOver

@synthesize content;
//@synthesize urlPhoto;
@synthesize titlePhoto;
@synthesize photographerPhoto;


- (id)initWithFrame:(CGRect)frame imageLink:(NSString*)anImageLink
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        machine = self.urlPhoto;
        
        self.userInteractionEnabled = YES;
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight - 40);
        
        backgroundColorBlack = [[UIView alloc] initWithFrame:self.frame];
        backgroundColorBlack.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
        backgroundColorBlack.opaque = YES;
        backgroundColorBlack.userInteractionEnabled = NO;
        
        float contentX = (screenWidth - screenWidth * .8) /2;
        
        content = [[UIView alloc] initWithFrame:CGRectMake(contentX, 73, screenWidth * .8, 263)];
        content.backgroundColor = [UIColor whiteColor];
        content.layer.cornerRadius = 3.0f;
        content.userInteractionEnabled = YES;
        content.alpha = 0;
        content.clipsToBounds = YES;
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, content.frame.size.height-2, content.frame.size.width, .1f);
        bottomBorder.backgroundColor = [UIColor r:215 g:26 b:33 alpha:1.0f].CGColor;
        [content.layer addSublayer:bottomBorder];
        
        //urlPhoto = [[UILabel alloc] init];
        
        UIImageView *fbPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 70)];
        [fbPhoto setImageWithURL:[NSURL URLWithString:anImageLink]];

        [content addSubview:fbPhoto];
        
        titlePhoto = [[UILabel alloc] initWithFrame:CGRectMake(fbPhoto.frame.origin.x + fbPhoto.frame.size.width + 15, 7, 110, 25)];
        titlePhoto.numberOfLines = 2;
        titlePhoto.backgroundColor = [UIColor clearColor];
        titlePhoto.textColor = [UIColor blackColor];
        //titlePhoto.text = aName;
        titlePhoto.font = [UIFont fontWithName:@"Parisine-Bold" size:13];
        
        [content addSubview:titlePhoto];
        
        photographerPhoto = [[UILabel alloc] initWithFrame:CGRectMake(fbPhoto.frame.origin.x + fbPhoto.frame.size.width + 15, titlePhoto.frame.size.height + titlePhoto.frame.origin.y + 5, 100, 15)];
        photographerPhoto.font = [UIFont fontWithName:@"Helvetica" size:11];
        photographerPhoto.numberOfLines = 2;
        
        photographerPhoto.backgroundColor = [UIColor clearColor];
        photographerPhoto.textColor = [UIColor blackColor];
        [content addSubview:photographerPhoto];
        
        float buttonsX = (content.frame.size.width - content.frame.size.width * .9) / 2;
        float widths = content.frame.size.width * .9;
        
        postMessageTextView = [[UITextField alloc] initWithFrame:CGRectMake(buttonsX, fbPhoto.frame.origin.y + fbPhoto.frame.size.height + 5, widths, 80)];
        postMessageTextView.placeholder = @"Écrivez un message";
        //postMessageTextView.text = @"Écrivez un message";
        postMessageTextView.backgroundColor = [UIColor whiteColor];
        postMessageTextView.textColor = [UIColor grayColor];
        postMessageTextView.font = [UIFont fontWithName:@"Helvetica" size:13];
        postMessageTextView.layer.cornerRadius = 3.0f;
        postMessageTextView.layer.borderColor = [UIColor r:236 g:236 b:236 alpha:1].CGColor;
        postMessageTextView.layer.borderWidth = 1.0f;
        
        [content addSubview:postMessageTextView];
        
        UIButton *shareFB = [UIButton buttonWithType:UIButtonTypeCustom];
        shareFB.layer.cornerRadius = 3.0f;
        [shareFB setTitle:@"Publier sur votre mur" forState:UIControlStateNormal];
        shareFB.backgroundColor = [UIColor r:241 g:241 b:241 alpha:1];
        shareFB.layer.borderWidth = 1.0f;
        shareFB.layer.borderColor = [UIColor r:236 g:236 b:236 alpha:1].CGColor;
        shareFB.titleLabel.textColor = [UIColor r:106 g:106 b:106 alpha:1];
        [shareFB setTitleColor:[UIColor r:106 g:106 b:106 alpha:1] forState:UIControlStateNormal];
        shareFB.frame = CGRectMake(buttonsX, postMessageTextView.frame.origin.y + postMessageTextView.frame.size.height + 5, widths, 40);
        
        [shareFB addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [content addSubview:shareFB];
        
        UIButton *cancelFB = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelFB.frame = CGRectMake(buttonsX, shareFB.frame.origin.y + shareFB.frame.size.height + 5, widths, 40);
        [cancelFB setTitle:@"Annuler" forState:UIControlStateNormal];
        cancelFB.layer.cornerRadius = 3.0f;
        cancelFB.backgroundColor = [UIColor r:241 g:241 b:241 alpha:1];
        cancelFB.layer.borderWidth = 1.0f;
        cancelFB.layer.borderColor = [UIColor r:236 g:236 b:236 alpha:1].CGColor;
        cancelFB.titleLabel.textColor = [UIColor r:106 g:106 b:106 alpha:1];
        [cancelFB setTitleColor:[UIColor r:106 g:106 b:106 alpha:1] forState:UIControlStateNormal];
        [cancelFB addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [content addSubview:cancelFB];
        
        [self addSubview:backgroundColorBlack];
        [self addSubview:content];
        [content sizeToFit];
        
        NSString *linkFacebook = @"http://www.photoquai.fr/";
        NSString *pictureFacebook = anImageLink;
        NSString *nameFacebook = @"Je souhaite vous faire découvrir ";
        //nameFacebook = [nameFacebook stringByAppendingString:self.titlePhoto.text];
        
        NSString *captionFacebook = nil;
        NSString *descriptionFacebook = postMessageTextView.text;
        
        
        
        //PARAMETRES ENVOYÉS À FACEBOOK
        self.facebookParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                           linkFacebook, @"link",
                           pictureFacebook, @"picture",
                           nameFacebook, @"name",
                           captionFacebook, @"caption",
                           descriptionFacebook, @"description",
                           nil];
    }
    return self;
}

- (void)publishStory{
    
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:self.facebookParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = @"Une erreur vient être rencontrée, veuillez essayer plus tard";
         } else {
             alertText = @"Votre message a été publié sur votre mur";
         }
         // Show the result in an alert
         [[[CustomAlertView alloc] initWithTitle:nil message:alertText delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }];
}

- (void)shareButtonAction {
    
    // Add user message parameter if user filled it in
    if (![postMessageTextView.text isEqualToString:@""] ) {
        [self.facebookParams setObject:postMessageTextView.text forKey:@"message"];
    }
    
      if (FBSession.activeSession.isOpen) {
        // Ask for publish_actions permissions in context
        if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
            // No permissions found in session, ask for it
            [FBSession.activeSession reauthorizeWithPublishPermissions: [NSArray arrayWithObject:@"publish_actions"] defaultAudience:FBSessionDefaultAudienceFriends completionHandler:^(FBSession *session, NSError *error) {
                if (!error) {
                    // If permissions granted, publish the story
                    [self publishStory];
                    [self hide];
                }
            }];
            [[FBRequest requestForMe] startWithCompletionHandler: ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                
                if (!error) {
                    
                    self.username.text = user.name;
                    NSLog(@"jhbj : %@", user.name);
                    
                    //self.userProfileImage.profileID = user.id;
                }
            }];
        } else {
            // If permissions present, publish the story
            [self publishStory];
            [self hide];
        }
    }else{
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    
}

//Cache le clavier si on touche ailleurs
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([postMessageTextView isFirstResponder] &&
        (postMessageTextView != touch.view))
    {
        [postMessageTextView resignFirstResponder];
    }
}


- (void) hide{
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         content.transform = CGAffineTransformMakeScale(.1, .1);
                         content.alpha = 0;
                         
                     }completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

- (void) show{
    [UIView animateWithDuration:0.25
                          delay:0
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         content.transform = CGAffineTransformMakeScale(1, 1);
                         content.alpha = 1;
                         
                     }completion:^(BOOL finished){
                         
                     }];
}


@end
