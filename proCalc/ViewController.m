//
//  ViewController.m
//  proCalc
//  Push Jonas
//  Created by Tobias Hähnel on 04.04.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize resultDisplay = _resultDisplay;
@synthesize userIsTypingDigit = _userIsTypingDigit;
@synthesize waitingOperation = _waitingOperation;
@synthesize waitingOperant = _waitingOperant;
double m_wert=0;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(id)sender
{
    UIButton *button = sender;
    
    if (!self.userIsTypingDigit) {
        self.resultDisplay.text = @"";
        self.userIsTypingDigit = YES;
    }
    self.resultDisplay.text = [self.resultDisplay.text stringByAppendingString:[button currentTitle]];
    self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:[button currentTitle]];
}

- (IBAction)commaPressed:(id)sender {
    // In a floating point Number, one Comma only is allowed. Therefor, we have to check the input.
    
    if ([self.resultDisplay.text rangeOfString:@"."].location == NSNotFound) {
        self.resultDisplay.text = [self.resultDisplay.text stringByAppendingString:@"."];
        self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:@"."];
    }
}

- (IBAction)operationPressed:(id)sender
{
    UIButton *button = sender;
    
    self.userIsTypingDigit = NO;
    
    self.resultDisplay.text = [self performOperation:[button currentTitle] withOperant:[self.resultDisplay.text doubleValue]];

        
    self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:[button currentTitle]];
    
}

- (IBAction)mc_button:(id)sender {
    m_wert=0;
}

- (IBAction)m_plus:(id)sender {
    m_wert=m_wert + [self.resultDisplay.text doubleValue];
}


- (IBAction)m_zeige:(id)sender {
    self.resultDisplay.text=[NSString stringWithFormat:@"%g",m_wert];
}

- (IBAction)m_minus:(id)sender {
     m_wert=m_wert - [self.resultDisplay.text doubleValue];
}


- (NSString*) performOperation: (NSString*) operation withOperant: (double) operant
{
    if ([operation isEqualToString:@"C"]) {
        self.computationDisplay.text=@"";
        self.resultDisplay.text=@"";
        return @"";
    } else if ([operation isEqualToString:@"AC"]) {
        self.waitingOperant = 0.0;
        self.waitingOperation = nil;
        self.computationDisplay.text=@"";
        self.resultDisplay.text=@"";
        return @"0";
    } else if ([self.waitingOperation isEqualToString:@"+"]) {
        operant = self.waitingOperant + operant;
    } else if ([self.waitingOperation isEqualToString:@"-"]) {
        operant = self.waitingOperant - operant;
    } else if ([self.waitingOperation isEqualToString:@"×"]) {
        operant = self.waitingOperant * operant;
    } else if ([self.waitingOperation isEqualToString:@"x²"]) {
        operant = self.waitingOperant * self.waitingOperant;
    } else if ([self.waitingOperation isEqualToString:@"√x"]) {
        operant = sqrt(self.waitingOperant);
    } else if ([self.waitingOperation isEqualToString:@"±"]) {
        operant = self.waitingOperant*(-1);
        
    } else if ([self.waitingOperation isEqualToString:@"÷"]) {
        if (operant != 0.0) {
            operant = self.waitingOperant / operant;
        } else {
            NSLog(@"Fehler: Division durch Null!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Division durch Null!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return @"Fehler";
        }
    }
    
    self.waitingOperant = operant;
    self.waitingOperation = operation;
    return [NSString stringWithFormat:@"%g", operant];
    
}
@end
