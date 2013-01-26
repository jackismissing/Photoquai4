//
//  PhotographerVignette.h
//  PHQ
//
//  Created by Jean-Louis Danielo on 09/01/13.
//  Copyright (c) 2013 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotographerVignette : UIView {
    UIImageView *imageView;
    
    NSString *lastname;
    NSString *firstname;
    
    int idPhotographer;
}

- (id)initWithFrame:(CGRect)frame withId:(int)anId;

- (NSString*) lastname;
- (NSString*) firstname;
- (int) idPhotographer;

- (void) setLastname:(NSString*)lastname;
- (void) setFirstname:(NSString*)firstname;
- (void) setIdPhotographer:(int)anIdPhotographer;

@end
