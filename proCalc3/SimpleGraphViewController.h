//
//  SimpleGraphViewController.h
//  proCalc3
//
//  Created by Tobias Hähnel on 26.07.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphDrawingView.h"

@interface SimpleGraphViewController : UIViewController <UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet GraphDrawingView *zeichnung;
@property (weak, nonatomic) IBOutlet UITextField *gleichungsText;
@property (weak, nonatomic) IBOutlet UIButton *zeichenButton;

- (IBAction)textFieldDoneEditing:(id)sender;

@end




