//
//  GraphPlotterViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 20.05.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "GraphPlotterViewController.h"
#import "GraphPlotterView.h"

@interface GraphPlotterViewController ()

@property (weak, nonatomic) IBOutlet GraphPlotterView *graphPlotterView;
@property (weak, nonatomic) IBOutlet UITextField *functionField;

@end

@implementation GraphPlotterViewController

//- (void)setGraphPlotterView:(GraphPlotterView *)graphPlotterView
//{
//    
//}

- (IBAction)swipeToSimpleCalc:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"fromGraphToSpimple" sender:self];
}

- (void)setup
{
    // initialization that can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
