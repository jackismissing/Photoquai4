//
//  SliderImage.h
//  photoquai
//
//  Created by Jean-Louis Danielo on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderImage : UIScrollView{
    
    int fakeTag;
}

- (id)initWithImages:(NSArray*)arrayImages withIndexes:(NSArray*)arrayIndexes atPosition:(CGRect)frame;

- (int) fakeTag;
- (void) setFakeTag:(int)aFakeTag;


@end