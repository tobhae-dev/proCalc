//
//  ZeichnerViewController.m
//  proCalc
//
//  Created by Jonas on 6/28/13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "ZeichnerViewController.h"
#import "Parser.h"
#import "GraphDrawingView.h"

@interface ZeichnerViewController ()

@end

@implementation ZeichnerViewController
- (IBAction)funktionZeichnen:(id)sender {
   
    NSLog(@"Testausgabe");
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
