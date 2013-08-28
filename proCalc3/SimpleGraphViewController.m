//
//  SimpleGraphViewController.m
//  proCalc3
//
//  Created by Tobias Hähnel on 26.07.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "SimpleGraphViewController.h"
#import "Parser.h"
#import "GraphDrawingView.h"

@interface SimpleGraphViewController ()

@end

@implementation SimpleGraphViewController

- (IBAction)funktionZeichnen:(id)sender {
    
    [self.zeichnung setup:self.gleichungsText.text];
    [self.zeichnung setNeedsDisplay];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.zeichnung;
}


@end
