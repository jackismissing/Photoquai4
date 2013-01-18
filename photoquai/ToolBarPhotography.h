//
//  ToolBarPhotography.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 18/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBarPhotography : UIToolbar

@property (nonatomic, strong) UIImageView *locationImage;
@property (nonatomic, strong) UIImageView *infosImage;
@property (nonatomic, strong) UIImageView *audioguideImage;

@property (nonatomic, strong) UILabel *audioguideLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *infosLabel;

@end
