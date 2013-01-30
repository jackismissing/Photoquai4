//
//  FacebookPopOver.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 29/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>

#import "UIColor+RVB255.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "CustomAlertView.h"

@interface FacebookPopOver : UIView <UITextViewDelegate>{
    UIView *backgroundColorBlack;
    UITextField *postMessageTextView;
    NSString *machine;
    
}

@property (nonatomic, strong) UIView *content;
@property (copy, nonatomic) NSString *urlPhoto;
@property (nonatomic, strong) UILabel *titlePhoto;
@property (nonatomic, strong) UILabel *photographerPhoto;
@property (strong, nonatomic) NSMutableDictionary *facebookParams;
@property (strong, nonatomic) UILabel *username;
@property (nonatomic, assign) int idPicture;

- (id)initWithFrame:(CGRect)frame imageLink:(NSString*)anImageLink;

- (void) show;
- (void) hide;

@end
