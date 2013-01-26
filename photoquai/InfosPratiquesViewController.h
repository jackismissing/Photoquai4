//
//  InfosPratiquesViewController.h
//  photoquai
//
//  Created by Nicolas on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfosPratiquesViewController : UIViewController<UIScrollViewDelegate>

@property(strong, nonatomic) UIScrollView *infoPratiqueScrollView;

@property(strong, nonatomic) UIView *menu;

@property(strong, nonatomic) UIButton *metroBtn;

@property(strong, nonatomic) UIButton *rerBtn;

@property(strong, nonatomic) UIButton *busBtn;

@property(strong, nonatomic) UIButton *velibBtn;

@property(strong, nonatomic) UIView *metroView;

@property(strong, nonatomic) UIView *rerView;

@property(strong, nonatomic) UIView *busView;

@property(strong, nonatomic) UIView *velibView;

-(void)scrollToTransport : (id)sender;

-(void)viewMetro;

-(void)viewRer;

-(void)viewBus;

-(void)viewVelib;



@end
