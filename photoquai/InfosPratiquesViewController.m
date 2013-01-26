//
//  InfosPratiquesViewController.m
//  photoquai
//
//  Created by Nicolas on 25/01/13.
//  Copyright (c) 2013 Groupe 5 PHQ Gobelins CDNL. All rights reserved.
//

#import "InfosPratiquesViewController.h"

@interface InfosPratiquesViewController ()

@end

@implementation InfosPratiquesViewController
{
    CGFloat width;
}

@synthesize infoPratiqueScrollView;
@synthesize menu;
@synthesize metroBtn;
@synthesize rerBtn;
@synthesize busBtn;
@synthesize velibBtn;

@synthesize metroView;
@synthesize rerView;
@synthesize busView;
@synthesize velibView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        width = self.view.frame.size.width;
        
        //  ////////////////////////////////////////////////////////////////////////////////// Init la scroll view //////////////////
        
        infoPratiqueScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 102, width, 1000)];
        infoPratiqueScrollView.contentSize = CGSizeMake(4 * width, 1000);
        infoPratiqueScrollView.scrollEnabled = NO;
        infoPratiqueScrollView.contentOffset = CGPointMake(0,0);
        
        [self.view addSubview:infoPratiqueScrollView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue metro /////////////////
        
        metroView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
        
        [infoPratiqueScrollView addSubview:metroView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue rer /////////////////
        
        rerView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, 1000)];

        
        [infoPratiqueScrollView addSubview:rerView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue bus /////////////////
        
        busView = [[UIView alloc] initWithFrame:CGRectMake(2*width, 0, width, 1000)];

        
        [infoPratiqueScrollView addSubview:busView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init de la vue velib /////////////////
        
        velibView = [[UIView alloc] initWithFrame:CGRectMake(3*width, 0, width, 1000)];

        
        [infoPratiqueScrollView addSubview:velibView];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init du menu /////////////////
        
        menu = [[UIView alloc] initWithFrame:CGRectMake(15, 82, 290, 35)];
        
        UIImageView *fondMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blocnoirinfospratiques.png"]];
        
        [menu addSubview:fondMenu];
        
        [self.view addSubview:menu];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Init des boutons /////////////////
        
        self.navigationItem.title = @"Infos pratiques";
        
        self.navigationItem.hidesBackButton = YES;
        
        metroBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72.5, 35)];
        
        [metroBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        metroBtn.tag = 1;
        
        [self.menu addSubview:metroBtn];
        
        rerBtn = [[UIButton alloc] initWithFrame:CGRectMake(metroBtn.frame.size.width, 0, 72.5, 35)];
        
        [rerBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        rerBtn.tag = 2;
        
        [self.menu addSubview:rerBtn];
        
        busBtn = [[UIButton alloc] initWithFrame:CGRectMake(2*metroBtn.frame.size.width, 0, 72.5, 35)];
        
        [busBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        busBtn.tag = 3;
        
        [self.menu addSubview:busBtn];
        
        velibBtn = [[UIButton alloc] initWithFrame:CGRectMake(3*metroBtn.frame.size.width, 0, 72.5, 35)];
        
        [velibBtn addTarget:self action:@selector(scrollToTransport:) forControlEvents:UIControlEventTouchUpInside];
        
        velibBtn.tag = 4;
    
        [self.menu addSubview:velibBtn];
        
        //  /////////////////////////////////////////////////////////////////////////////////// Nav Bar /////////////////
        
        self.navigationItem.title = @"Infos pratiques";
        
        self.navigationItem.hidesBackButton = YES;

        

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //Réinstancie la navigation bar, une fois le menu disparu

    [super viewWillAppear:animated];
    
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = customBarItem;

    
    [self.infoPratiqueScrollView setShowsHorizontalScrollIndicator:NO];
    
    metroView.backgroundColor = [UIColor whiteColor];
    
    rerView.backgroundColor = [UIColor whiteColor];
    
    busView.backgroundColor = [UIColor whiteColor];
    
    velibView.backgroundColor = [UIColor whiteColor];

    
    [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
    
    [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
    
    [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];
    
    [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
    
    // Image on select
    
    [metroBtn setImage:[UIImage imageNamed:@"metro"] forState:UIControlStateHighlighted];
    
    [rerBtn setImage:[UIImage imageNamed:@"rerselect"] forState:UIControlStateHighlighted];
    
    [busBtn setImage:[UIImage imageNamed:@"busselect"] forState:UIControlStateHighlighted];
    
    [velibBtn setImage:[UIImage imageNamed:@"velibselect"] forState:UIControlStateHighlighted];
    
    //  /////////////////////////////////////////////////////////////////////////////////// Vue metro /////////////////
    
    [self viewMetro];
    
    //  /////////////////////////////////////////////////////////////////////////////////// Vue rer /////////////////
    
    [self viewRer];
    
    //  /////////////////////////////////////////////////////////////////////////////////// Vue bus /////////////////
    
    [self viewBus];
    
    //  /////////////////////////////////////////////////////////////////////////////////// Vue bus /////////////////
    
    [self viewVelib];
    
        

}

- (void)scrollToTransport:(id)sender
{
    NSInteger btnId = ((UIControl *) sender).tag;
    
    if(btnId == 1)
    {
        [metroBtn setImage:[UIImage imageNamed:@"metro"] forState:UIControlStateNormal];
        
        [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
        
        [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];
        
        [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
        
        [infoPratiqueScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if(btnId == 2)
    {
        [rerBtn setImage:[UIImage imageNamed:@"rerselect"] forState:UIControlStateNormal];

        [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
        
        [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];
        
        [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
        
        [infoPratiqueScrollView setContentOffset:CGPointMake(width, 0) animated:YES];

    }
    
    if(btnId == 3)
    {
        [busBtn setImage:[UIImage imageNamed:@"busselect"] forState:UIControlStateNormal];
        
        [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
        
        [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
        
        [velibBtn setImage:[UIImage imageNamed:@"velibnotselect"] forState:UIControlStateNormal];
        
        [infoPratiqueScrollView setContentOffset:CGPointMake(2*width, 0) animated:YES];

    }
    
    if(btnId == 4)
    {
        [velibBtn setImage:[UIImage imageNamed:@"velibselect"] forState:UIControlStateNormal];
        
        [metroBtn setImage:[UIImage imageNamed:@"metronotselect"] forState:UIControlStateNormal];
        
        [rerBtn setImage:[UIImage imageNamed:@"rerpasselect"] forState:UIControlStateNormal];
        
        [busBtn setImage:[UIImage imageNamed:@"busnotselect"] forState:UIControlStateNormal];

        [infoPratiqueScrollView setContentOffset:CGPointMake(3*width, 0) animated:YES];
        

    }
    
}

-(void)viewMetro {
    
    UIImageView *ligne9 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 18, 18)];
    
    [ligne9 setImage:[UIImage imageNamed:@"ligne9.png"]];
    
    [metroView addSubview:ligne9];
    
    UIImageView *ligne9bis = [[UIImageView alloc] initWithFrame:CGRectMake(15, 55, 18, 18)];
    
    [ligne9bis setImage:[UIImage imageNamed:@"ligne9.png"]];
    
    [metroView addSubview:ligne9bis];
    
    UIImageView *ligne8 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 80, 18, 18)];
    
    [ligne8 setImage:[UIImage imageNamed:@"ligne8.png"]];
    
    [metroView addSubview:ligne8];
    
    UIImageView *ligne6 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 105, 18, 18)];
    
    [ligne6 setImage:[UIImage imageNamed:@"ligne6.png"]];
    
    [metroView addSubview:ligne6];
    
    
    /// Labels
    
    // Ligne 9
    
    UILabel *ligne9Label = [[UILabel alloc]initWithFrame:CGRectMake(43, 28, 70, 12)];
    
    ligne9Label.text = @"Alma-Marceau - ";
    
    [ligne9Label sizeToFit];
    
    ligne9Label.numberOfLines = 1;
    
    ligne9Label.font = [UIFont fontWithName:@"Parisine" size:12];
    
    [metroView addSubview:ligne9Label];
    
    UILabel *ligne9LabelDetail = [[UILabel alloc]initWithFrame:CGRectMake(4 + ligne9Label.frame.size.width, 28, 70, 12)];
    
    ligne9LabelDetail.text = @"Sortie Place d'Alma";
    
    [ligne9LabelDetail sizeToFit];
    
    ligne9LabelDetail.numberOfLines = 1;
    
    ligne9LabelDetail.font = [UIFont fontWithName:@"Parisine-Italic" size:12];
    
    ligne9LabelDetail.textColor = [UIColor grayColor];
    
    [metroView addSubview:ligne9LabelDetail];
    
    // Ligne 9 bis
    
    UILabel *ligne9bisLabel = [[UILabel alloc]initWithFrame:CGRectMake(43, ligne9bis.frame.origin.y - 2, 70, 12)];
    
    ligne9bisLabel.text = @"Iéna - ";
    
    [ligne9bisLabel sizeToFit];
    
    ligne9bisLabel.numberOfLines = 1;
    
    ligne9bisLabel.font = [UIFont fontWithName:@"Parisine" size:12];
    
    [metroView addSubview:ligne9bisLabel];
    
    UILabel *ligne9bisLabelDetail = [[UILabel alloc]initWithFrame:CGRectMake(ligne9bisLabel.frame.origin.x + 34, ligne9bis.frame.origin.y, 70, 12)];
    
    ligne9bisLabelDetail.text = @"Sortie Place Iéna";
    
    [ligne9bisLabelDetail sizeToFit];
    
    ligne9bisLabelDetail.numberOfLines = 1;
    
    ligne9bisLabelDetail.font = [UIFont fontWithName:@"Parisine-Italic" size:12];
    
    ligne9bisLabelDetail.textColor = [UIColor grayColor];
    
    [metroView addSubview:ligne9bisLabelDetail];
    
    // Ligne 8
    
    UILabel *ligne8Label = [[UILabel alloc]initWithFrame:CGRectMake(43, ligne8.frame.origin.y - 2, 70, 12)];
    
    ligne8Label.text = @"École Militaire - ";
    
    [ligne8Label sizeToFit];
    
    ligne8Label.numberOfLines = 1;
    
    ligne8Label.font = [UIFont fontWithName:@"Parisine" size:12];
    
    [metroView addSubview:ligne8Label];
    
    UILabel *ligne8LabelDetail = [[UILabel alloc]initWithFrame:CGRectMake(ligne8Label.frame.origin.x + 88, ligne8Label.frame.origin.y, 70, 12)];
    
    ligne8LabelDetail.text = @"Sortie avenue Bosquet";
    
    [ligne8LabelDetail sizeToFit];
    
    ligne8LabelDetail.numberOfLines = 1;
    
    ligne8LabelDetail.font = [UIFont fontWithName:@"Parisine-Italic" size:12];
    
    ligne8LabelDetail.textColor = [UIColor grayColor];
    
    [metroView addSubview:ligne8LabelDetail];
    
    // Ligne 6
    
    UILabel *ligne6Label = [[UILabel alloc]initWithFrame:CGRectMake(43, ligne6.frame.origin.y - 2, 70, 12)];
    
    ligne6Label.text = @"Bir Hekeim - ";
    
    [ligne6Label sizeToFit];
    
    ligne6Label.numberOfLines = 1;
    
    ligne6Label.font = [UIFont fontWithName:@"Parisine" size:12];
    
    [metroView addSubview:ligne6Label];
    
    UILabel *ligne6LabelDetail = [[UILabel alloc]initWithFrame:CGRectMake(ligne6Label.frame.origin.x + 72, ligne6Label.frame.origin.y, 70, 12)];
    
    ligne6LabelDetail.text = @"Sortie boulevard de Grenelle";
    
    [ligne6LabelDetail sizeToFit];
    
    ligne6LabelDetail.numberOfLines = 1;
    
    ligne6LabelDetail.font = [UIFont fontWithName:@"Parisine-Italic" size:12];
    
    ligne6LabelDetail.textColor = [UIColor grayColor];
    
    [metroView addSubview:ligne6LabelDetail];
    
    // Cheat : image pour le texte "sur le quai"...
    
    UIImage *surleQuai = [UIImage imageNamed:@"sur-le-quais.png"];
    
    UIImageView *surleQuaiView = [[UIImageView alloc] initWithImage:surleQuai];
    
    surleQuaiView.frame = CGRectMake(15, ligne6.frame.origin.y + ligne6.frame.size.height + 15, 290, 143);
    
    [metroView addSubview:surleQuaiView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    
    
    UIButton *viewMapBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, surleQuaiView.frame.origin.y + surleQuaiView.frame.size.height, 290, 43)];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap.png"] forState:UIControlStateNormal];

    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap-hover.png"] forState:UIControlStateHighlighted];
    
    [viewMapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];

    
    [metroView addSubview:viewMapBtn];

    
}

-(void)viewRer {
    
    UIImageView *rerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rer-contenus.png"]];
    
    rerImageView.frame = CGRectMake(0, 15, 320, 72);
    
    [rerView addSubview:rerImageView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    UIImage *surleQuai = [UIImage imageNamed:@"sur-le-quais.png"];
    
    UIImageView *surleQuaiView = [[UIImageView alloc] initWithImage:surleQuai];
    
    surleQuaiView.frame = CGRectMake(15, rerImageView.frame.origin.y + rerImageView.frame.size.height, 290, 143);
    
    [rerView addSubview:surleQuaiView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    
    
    UIButton *viewMapBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, surleQuaiView.frame.origin.y + surleQuaiView.frame.size.height, 290, 43)];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap.png"] forState:UIControlStateNormal];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap-hover.png"] forState:UIControlStateHighlighted];
    
    [viewMapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    
    
    [rerView addSubview:viewMapBtn];
}

-(void)viewBus {
    
    UIImageView *busImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bus-contenus.png"]];
    
    busImageView.frame = CGRectMake(0, 15, 320, 99);
    
    [busView addSubview:busImageView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    UIImage *surleQuai = [UIImage imageNamed:@"sur-le-quais.png"];
    
    UIImageView *surleQuaiView = [[UIImageView alloc] initWithImage:surleQuai];
    
    surleQuaiView.frame = CGRectMake(15, busImageView.frame.origin.y + busImageView.frame.size.height, 290, 143);
    
    [busView addSubview:surleQuaiView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    
    
    UIButton *viewMapBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, surleQuaiView.frame.origin.y + surleQuaiView.frame.size.height, 290, 43)];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap.png"] forState:UIControlStateNormal];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap-hover.png"] forState:UIControlStateHighlighted];
    
    [viewMapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    
    
    [busView addSubview:viewMapBtn];
}

-(void)viewVelib {
    
    UIImageView *velibImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"velib-contenus.png"]];
    
    velibImageView.frame = CGRectMake(0, 15, 320, 99);
    
    [velibView addSubview:velibImageView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    UIImage *surleQuai = [UIImage imageNamed:@"sur-le-quais.png"];
    
    UIImageView *surleQuaiView = [[UIImageView alloc] initWithImage:surleQuai];
    
    surleQuaiView.frame = CGRectMake(15, velibImageView.frame.origin.y + velibImageView.frame.size.height, 290, 143);
    
    [velibView addSubview:surleQuaiView];
    
    // Cheat : image pour le texte "sur le quai"...
    
    
    
    UIButton *viewMapBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, surleQuaiView.frame.origin.y + surleQuaiView.frame.size.height, 290, 43)];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap.png"] forState:UIControlStateNormal];
    
    [viewMapBtn setImage:[UIImage imageNamed:@"btn-viewmap-hover.png"] forState:UIControlStateHighlighted];
    
    [viewMapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
    
    
    [busView addSubview:viewMapBtn];
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showMap {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
