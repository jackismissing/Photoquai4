//
//  ToolBarPhotography.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 18/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "ToolBarPhotography.h"
#import "UIColor+RVB255.h"

@implementation ToolBarPhotography


- (id)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        [self drawRect:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    
    UIImage *image = [UIImage imageNamed: @"toolbar-photographie"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    self.clipsToBounds = YES;
    //self.frame = CGRectMake(0, screenHeight - 75, screenWidth, 55);
    
    int viewWidth = 95;
    int marginTop = 10;
    UIFont *formatLabels = [UIFont fontWithName:@"Parisine-Regular" size:9.0f];
    
#pragma mark - informations tab
    UIView *informationsView = [[UIView alloc] initWithFrame:CGRectMake(10, marginTop, viewWidth, 35)];
    
    //informations.backgroundColor = [UIColor redColor];
    
    UIImageView *infosImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    infosImage.frame = CGRectMake(((informationsView.frame.size.width - infosImage.frame.size.width) / 2), -5, 25, 25);
    infosImage.image = [UIImage imageNamed:@"informations"];
    infosImage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * myText = @"Informations";
    
    CGRect labelFrame = CGRectMake(0, infosImage.frame.origin.y + infosImage.frame.size.height, 55, 15);
    UILabel *infosLabel = [[UILabel alloc] initWithFrame:labelFrame];
    infosLabel.text = myText;
    //infosLabel.backgroundColor = [UIColor whiteColor];
    [infosLabel setFrame:CGRectMake(((informationsView.frame.size.width - infosLabel.frame.size.width) / 2), infosImage.frame.origin.y + infosImage.frame.size.height, CGRectGetWidth(infosLabel.frame), CGRectGetHeight(infosLabel.frame))];
    infosLabel.font = formatLabels;
    infosLabel.backgroundColor = [UIColor clearColor];
    infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    infosLabel.shadowColor = [UIColor blackColor];
    infosLabel.shadowOffset = CGSizeMake(0, -1);
    
    UITapGestureRecognizer *informationsAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(informationsAction:)];
    [informationsView addGestureRecognizer:informationsAction];

    [informationsView sizeToFit];
    [informationsView addSubview:infosLabel];
    [informationsView addSubview:infosImage];
    [self addSubview:informationsView];
    
#pragma mark - audioguide tab
    UIView *audioguideView = [[UIView alloc] initWithFrame:CGRectMake(informationsView.frame.origin.x + informationsView.frame.size.width + 7, marginTop - 2, viewWidth, 35)];
    //audioguideView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *audioguideImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    audioguideImage.frame = CGRectMake(((audioguideView.frame.size.width - audioguideImage.frame.size.width) / 2), -5, 25, 25);
    audioguideImage.image = [UIImage imageNamed:@"audioguide"];
    audioguideImage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * audioguideText = @"Audio Description";
    
    CGRect labelAudioGuideFrame = CGRectMake(7, audioguideImage.frame.origin.y + audioguideImage.frame.size.height + 2, 73, 15);
    
    UILabel *audioguideLabel = [[UILabel alloc] initWithFrame:labelAudioGuideFrame];
    audioguideLabel.text = audioguideText;
    audioguideLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    audioguideLabel.shadowColor = [UIColor blackColor];
    audioguideLabel.shadowOffset = CGSizeMake(0, -1);

    //[audioguideLabel setFrame:CGRectMake(((audioguideView.frame.size.width - audioguideLabel.frame.size.width) / 2), infosImage.frame.origin.y + infosImage.frame.size.height, CGRectGetWidth(infosLabel.frame), CGRectGetHeight(audioguideLabel.frame))];
    audioguideLabel.font = formatLabels;
    audioguideLabel.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *audioguideAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(audioguideAction:)];
    [audioguideView addGestureRecognizer:audioguideAction];
    
    //[audioguideLabel sizeToFit];
    [audioguideView sizeToFit];
    [audioguideView addSubview:audioguideLabel];
    [audioguideView addSubview:audioguideImage];
    [self addSubview:audioguideView];
    

#pragma mark - location tab
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(audioguideView.frame.origin.x + audioguideView.frame.size.width + 10, marginTop, viewWidth, 35)];
    //locationView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    locationImage.frame = CGRectMake(((locationView.frame.size.width - locationImage.frame.size.width) / 2), -5, 25, 25);
    locationImage.image = [UIImage imageNamed:@"geoloc"];
    locationImage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * locationText = @"Localisation";
    
    CGRect labelLocationFrame = CGRectMake(25, locationImage.frame.origin.y + locationImage.frame.size.height, 50, 15);
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:labelLocationFrame];
    locationLabel.text = locationText;
    locationLabel.font = formatLabels;
    locationLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.shadowColor = [UIColor blackColor];
    locationLabel.shadowOffset = CGSizeMake(0, -1);

    //[locationLabel setFrame:CGRectMake(((audioguideView.frame.size.width - audioguideLabel.frame.size.width) / 2), infosImage.frame.origin.y + infosImage.frame.size.height, CGRectGetWidth(infosLabel.frame), CGRectGetHeight(audioguideLabel.frame))];
    
    UITapGestureRecognizer *locationAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationAction:)];
    [locationView addGestureRecognizer:locationAction];
    
    //[locationLabel sizeToFit];
    [locationView sizeToFit];
    [locationView addSubview:locationLabel];
    [locationView addSubview:locationImage];
    
    [self addSubview:locationView];
}

- (void)locationAction:(UIGestureRecognizer *)gesture{
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"showImageDescription" object:nil];
}

- (void)audioguideAction:(UIGestureRecognizer *)gesture{
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"showImageDescription" object:nil];
}

- (void)informationsAction:(UIGestureRecognizer *)gesture{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showImageDescription" object:nil];
}


@end