//
//  NavigationViewProtocol.h
//  photoquai
//
//  Created by Nicolas on 17/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavigationViewProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue :(int)selectedSection;

@end
