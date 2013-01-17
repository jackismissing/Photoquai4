//
//  rotaryWheel.h
//  photoquai
//
//  Created by Nicolas on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewProtocol.h"
#import "rotaryWheel.h"
#import "wheelSector.h"

@interface rotaryWheel : UIControl

@property (weak) id <NavigationViewProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;
@property CGAffineTransform startTransform;
@property (nonatomic, strong) NSMutableArray *sectors;
@property int currentSector;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;
-(void)rotate;

@end
