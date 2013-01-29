//
//  ShareFBViewController.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 29/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ShareFBViewController : UIViewController


@property (strong, nonatomic) NSMutableDictionary *postParams;
@property int idPicture;

@end
