//
//  FilterSwitch.m
//  photoquai
//
//  Created by Jean-Louis Danielo on 29/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "FilterSwitch.h"

@implementation FilterSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 3;
        
        UILabel *onText = [UILabel new];
        onText.text = NSLocalizedString(@"ON", @"Switch localized string");
        onText.textColor = [UIColor whiteColor];
        onText.font = [UIFont boldSystemFontOfSize:14];
        onText.shadowColor = [UIColor colorWithRed:104.0/255 green:73.0/255 blue:54.0/255 alpha:1.0];
        onText.shadowOffset = CGSizeMake(0, 1);
        
        UILabel *offText = [UILabel new];
        offText.text = NSLocalizedString(@"OFF", @"Switch localized string");
        offText.textColor = [UIColor colorWithRed:104.0/255 green:73.0/255 blue:54.0/255 alpha:1.0];
        offText.font = [UIFont boldSystemFontOfSize:14];
        offText.shadowColor = [UIColor whiteColor];
        offText.shadowOffset = CGSizeMake(0, 1);
    }
    return self;
}


@end
