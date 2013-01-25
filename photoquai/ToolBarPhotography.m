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
    informationsView.tag = 0;

    //informations.backgroundColor = [UIColor redColor];
    
    _infosImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    _infosImage.frame = CGRectMake(((informationsView.frame.size.width - _infosImage.frame.size.width) / 2), -5, 25, 25);
    _infosImage.image = [UIImage imageNamed:@"informations"];
    _infosImage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * myText = @"Informations";
    
    CGRect labelFrame = CGRectMake(0, _infosImage.frame.origin.y + _infosImage.frame.size.height, 55, 15);
    _infosLabel = [[UILabel alloc] initWithFrame:labelFrame];
    _infosLabel.text = myText;
    //infosLabel.backgroundColor = [UIColor whiteColor];
    [_infosLabel setFrame:CGRectMake(((informationsView.frame.size.width - _infosLabel.frame.size.width) / 2), _infosImage.frame.origin.y + _infosImage.frame.size.height, CGRectGetWidth(_infosLabel.frame), CGRectGetHeight(_infosLabel.frame))];
    _infosLabel.font = formatLabels;
    _infosLabel.backgroundColor = [UIColor clearColor];
    _infosLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    _infosLabel.shadowColor = [UIColor blackColor];
    _infosLabel.shadowOffset = CGSizeMake(0, -1);
    
    UITapGestureRecognizer *informationsAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voletAction:)];
    [informationsView addGestureRecognizer:informationsAction];

    [informationsView sizeToFit];
    [informationsView addSubview:_infosLabel];
    [informationsView addSubview:_infosImage];
    [self addSubview:informationsView];
    
#pragma mark - audioguide tab
    UIView *audioguideView = [[UIView alloc] initWithFrame:CGRectMake(informationsView.frame.origin.x + informationsView.frame.size.width + 7, marginTop - 2, viewWidth, 35)];
    audioguideView.tag = 1;
    //audioguideView.backgroundColor = [UIColor whiteColor];
    
    _audioguideImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    _audioguideImage.frame = CGRectMake(((audioguideView.frame.size.width - _audioguideImage.frame.size.width) / 2), -5, 25, 25);
    _audioguideImage.image = [UIImage imageNamed:@"audioguide"];
    _audioguideImage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * audioguideText = @"Audio Description";
    
    CGRect labelAudioGuideFrame = CGRectMake(7, _audioguideImage.frame.origin.y + _audioguideImage.frame.size.height + 2, 73, 15);
    
    _audioguideLabel = [[UILabel alloc] initWithFrame:labelAudioGuideFrame];
    _audioguideLabel.text = audioguideText;
    _audioguideLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    _audioguideLabel.shadowColor = [UIColor blackColor];
    _audioguideLabel.shadowOffset = CGSizeMake(0, -1);

    //[audioguideLabel setFrame:CGRectMake(((audioguideView.frame.size.width - audioguideLabel.frame.size.width) / 2), infosImage.frame.origin.y + infosImage.frame.size.height, CGRectGetWidth(infosLabel.frame), CGRectGetHeight(audioguideLabel.frame))];
    _audioguideLabel.font = formatLabels;
    _audioguideLabel.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *audioguideAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voletAction:)];
    [audioguideView addGestureRecognizer:audioguideAction];
    
    //[audioguideLabel sizeToFit];
    [audioguideView sizeToFit];
    [audioguideView addSubview:_audioguideLabel];
    [audioguideView addSubview:_audioguideImage];
    [self addSubview:audioguideView];
    

#pragma mark - location tab
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(audioguideView.frame.origin.x + audioguideView.frame.size.width + 10, marginTop, viewWidth, 35)];
    //locationView.backgroundColor = [UIColor whiteColor];
    locationView.tag = 2;
    
    _locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    _locationImage.frame = CGRectMake(((locationView.frame.size.width - _locationImage.frame.size.width) / 2), -5, 25, 25);
    _locationImage.image = [UIImage imageNamed:@"geoloc"];
    _locationImage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString * locationText = @"Localisation";
    
    CGRect labelLocationFrame = CGRectMake(25, _locationImage.frame.origin.y + _locationImage.frame.size.height, 50, 15);
    _locationLabel = [[UILabel alloc] initWithFrame:labelLocationFrame];
    _locationLabel.text = locationText;
    _locationLabel.font = formatLabels;
    _locationLabel.textColor = [UIColor r:109 g:109 b:109 alpha:1];
    _locationLabel.backgroundColor = [UIColor clearColor];
    _locationLabel.shadowColor = [UIColor blackColor];
    _locationLabel.shadowOffset = CGSizeMake(0, -1);

    //[locationLabel setFrame:CGRectMake(((audioguideView.frame.size.width - audioguideLabel.frame.size.width) / 2), infosImage.frame.origin.y + infosImage.frame.size.height, CGRectGetWidth(infosLabel.frame), CGRectGetHeight(audioguideLabel.frame))];
    
    UITapGestureRecognizer *locationAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voletAction:)];
    [locationView addGestureRecognizer:locationAction];
    
    //[locationLabel sizeToFit];
    [locationView sizeToFit];
    [locationView addSubview:_locationLabel];
    [locationView addSubview:_locationImage];
    
    [self addSubview:locationView];
}

- (void)voletAction:(UIGestureRecognizer *)gesture{
    
    UIView *index = gesture.view;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showImageVolet" object:[NSNumber numberWithInt:index.tag]];
}


@end