//
//  ViewController.h
//  proCalc
//
//  Created by Tobias Hähnel on 04.04.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *resultDisplay;
@property (weak, nonatomic) IBOutlet UILabel *computationDisplay;

@property (nonatomic, assign) BOOL userIsTypingDigit;
@property (nonatomic, assign) double waitingOperant;
@property (nonatomic, strong) NSString *waitingOperation;

- (IBAction)digitPressed:(id)sender;
- (IBAction)commaPressed:(id)sender;
- (IBAction)operationPressed:(id)sender;
- (IBAction)mc_button:(id)sender;
- (IBAction)m_plus:(id)sender;
- (IBAction)m_zeige:(id)sender;
- (IBAction)m_minus:(id)sender;



- (NSString*) performOperation: (NSString*) operation withOperant: (double) operant;

@end
