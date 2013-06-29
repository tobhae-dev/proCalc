//
//  ZeichnerViewController.h
//  proCalc
//
//  Created by Jonas on 6/28/13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//
#import "GraphDrawingView.h"
#import <UIKit/UIKit.h>

@interface ZeichnerViewController :UIViewController <UIScrollViewDelegate> 
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet GraphDrawingView *zeichnung;
@property (weak, nonatomic) IBOutlet UITextField *gleichungsText;
@property (weak, nonatomic) IBOutlet UIButton *zeichenButton;

- (IBAction)textFieldDoneEditing:(id)sender;


@end
