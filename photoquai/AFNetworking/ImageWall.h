//
//  ImageWall.h
//  ImageWall
//
//  Created by Jean-Louis Danielo on 16/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWall : UIImageView{
    int normalImageNewHeight;
    int idColonne;
    
    int height;
    int width;
    int x;
    int y;
    
}

- (id)initWithFrame:(CGRect)frame imageURL: (NSString*)aImageName colonne:(NSNumber*)colonne;

//Getters
- (int) height;
- (int) width;
- (int) x;
- (int) y;
- (NSNumber *)idColonne;



@end
