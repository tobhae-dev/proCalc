//
//  ComplexCalculatorViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 20.05.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "ComplexCalculatorViewController.h"

@interface ComplexCalculatorViewController ()

@end

@implementation ComplexCalculatorViewController


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
