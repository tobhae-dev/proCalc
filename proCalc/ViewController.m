//
//  ViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 04.04.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize resultDisplay = _resultDisplay;
@synthesize userIsTypingDigit = _userIsTypingDigit;
@synthesize waitingOperation = _waitingOperation;
@synthesize waitingOperant = _waitingOperant;


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
}

- (IBAction)commaPressed:(id)sender {
    // In a floating point Number, one Comma only is allowed. Therefor, we have to check the input.
    
    if ([self.resultDisplay.text rangeOfString:@"."].location == NSNotFound) {
        self.resultDisplay.text = [self.resultDisplay.text stringByAppendingString:@"."];
    }
}

- (IBAction)operationPressed:(id)sender
{
    UIButton *button = sender;
    
    self.userIsTypingDigit = NO;
    self.resultDisplay.text = [self performOperation:[button currentTitle] withOperant:[self.resultDisplay.text doubleValue]];
}

- (NSString*) performOperation: (NSString*) operation withOperant: (double) operant
{
    if ([operation isEqualToString:@"C"]) {
        return @"";
    } else if ([operation isEqualToString:@"AC"]) {
        self.waitingOperant = 0.0;
        self.waitingOperation = nil;
        return @"";
    } else if ([self.waitingOperation isEqualToString:@"+"]) {
        operant = self.waitingOperant + operant;
    } else if ([self.waitingOperation isEqualToString:@"-"]) {
        operant = self.waitingOperant - operant;
    } else if ([self.waitingOperation isEqualToString:@"×"]) {
        operant = self.waitingOperant * operant;
    } else if ([self.waitingOperation isEqualToString:@"÷"]) {
        if (operant != 0.0) {
            operant = self.waitingOperant / operant;
        } else {
            NSLog(@"Fehler: Division durch Null!");
            return @"Fehler";
        }
    }
    
    self.waitingOperant = operant;
    self.waitingOperation = operation;
    return [NSString stringWithFormat:@"%g", operant];
    
}
@end
