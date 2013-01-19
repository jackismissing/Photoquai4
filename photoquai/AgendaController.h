//
//  AgendaController.h
//  navigationWheel
//
//  Created by Nicolas Garnier on 08/01/13.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AgendaController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIScrollViewDelegate>
{
    NSMutableIndexSet *expandedSections;
    int selectedMonth;

}

@property (nonatomic, strong) UITableView *infosTableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSMutableArray *rowsInTmpArray;

@property (nonatomic, strong) UIScrollView *agendaScroll;

@property (nonatomic, strong) UIView *juinView;
@property (nonatomic, strong) UIView *juinFirstView;

@property (nonatomic, strong) UIView *juilletFirstView;
@property (nonatomic, strong) UIView *juilletView;

@property (nonatomic, strong) UIView *aoutView;
@property (nonatomic, strong) UIView *aoutFirstView;

@property (nonatomic, strong) UIView *septembreView;

@property (nonatomic, strong) UIView *octobreView;
@property (nonatomic, strong) UIView *octobreLastView;

@property (nonatomic, strong) UIView *novembreView;
@property (nonatomic, strong) UIView *novembreLastView;

@property (nonatomic, strong) UIView *decembreView;
@property (nonatomic, strong) UIView *decembreLastView;

@property (nonatomic, strong) UIButton *agendaButtonJuin;
@property (nonatomic, strong) UIButton *agendaFirstButtonJuin;

@property (nonatomic, strong) UIButton *agendaButtonJuillet;
@property (nonatomic, strong) UIButton *agendaFirstButtonJuillet;

@property (nonatomic, strong) UIButton *agendaButtonAout;
@property (nonatomic, strong) UIButton *agendaFirstButtonAout;

@property (nonatomic, strong) UIButton *agendaButtonSeptembre;

@property (nonatomic, strong) UIButton *agendaButtonOctobre;
@property (nonatomic, strong) UIButton *agendaLastButtonOctobre;

@property (nonatomic, strong) UIButton *agendaButtonNovembre;
@property (nonatomic, strong) UIButton *agendaLastButtonNovembre;

@property (nonatomic, strong) UIButton *agendaButtonDecembre;
@property (nonatomic, strong) UIButton *agendaLastButtonDecembre;

@property CGFloat width;
@property CGFloat height;
@property CGFloat centerX;

@property int index;

@property UILabel *dateLabel;
@property UILabel *headerTitle;
@property UILabel *headerText;



- (void)showMenu;

- (void)showTable;

- (void)back;



@end
