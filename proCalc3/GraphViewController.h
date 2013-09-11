//
//  GraphViewController.h
//  proCalc3
//
//  Created by Tobias Hähnel on 26.07.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface GraphViewController : UIViewController


//@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (weak, nonatomic) IBOutlet UITextField *gleichungsText;
@property (weak, nonatomic) IBOutlet UIButton *zeichenButton;
@property (nonatomic, strong) id program;

- (IBAction)textFieldDoneEditing:(id)sender;
- (void)refreshProgramDependancies;

@end




