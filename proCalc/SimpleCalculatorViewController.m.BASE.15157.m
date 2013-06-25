//
//  ViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 04.04.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//
//

#import "SimpleCalculatorViewController.h"
#import "Calculator.h"


@interface SimpleCalculatorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *inputAndAnswerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *computationDisplay;
@property (nonatomic, getter = isUserTypingDigit) BOOL userIsTypingDigit;
@property (nonatomic) double memoryContent;

@end

@implementation SimpleCalculatorViewController

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"fromSimpleToGraph" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Am besten nach Splashscreen
    UIAlertView *swipeAlert = [[UIAlertView alloc] initWithTitle:@"Hinweis" message:@"Wischen Sie nach rechts um zum Plotter zu wechseln." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [swipeAlert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)memoryFunctionPressed:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"MC"]) {
        // Memory Clear
        self.memoryContent = 0.0;
    
    }
    if ([sender.currentTitle isEqualToString:@"M+"]) {
        // Memory "plus" inputAndAnswerDisplay
        self.memoryContent += [self.inputAndAnswerDisplay.text doubleValue];
        
    }
    if ([sender.currentTitle isEqualToString:@"M-"]) {
        // Memory "minus" inputAndAnswerDisplay
        self.memoryContent -= [self.inputAndAnswerDisplay.text doubleValue];
    }
    if ([sender.currentTitle isEqualToString:@"MR"]) {
        // Memory Recall -> Show on inputAndAnswerDisplay
        self.inputAndAnswerDisplay.text = [NSString stringWithFormat:@"%f", self.memoryContent];
    }
}
    

- (IBAction)clearTheDisplay:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"C"]) {
        self.inputAndAnswerDisplay.text = @"0";
    } else if ([sender.currentTitle isEqualToString:@"AC"]) {
        self.inputAndAnswerDisplay.text = @"0";
        self.computationDisplay.text = @"";
    }
}

- (IBAction)specialFunctionPressed:(UIButton *)sender
{
    self.userIsTypingDigit = NO;
    
    if ([sender.currentTitle isEqualToString:@"√x"]) {
        self.inputAndAnswerDisplay.text = [Calculator squareRoot:self.inputAndAnswerDisplay.text];
    }
    if ([sender.currentTitle isEqualToString:@"x²"]) {
        self.inputAndAnswerDisplay.text = [Calculator squared:self.inputAndAnswerDisplay.text];
    }
    if ([sender.currentTitle isEqualToString:@"log"]) {
        self.inputAndAnswerDisplay.text = [Calculator logarithm:self.inputAndAnswerDisplay.text];
    }
    if ([sender.currentTitle isEqualToString:@"÷"]) {
        self.inputAndAnswerDisplay.text = [Calculator percentage:self.inputAndAnswerDisplay.text];
    }
}

- (IBAction)addExpressionToComputationDisplay:(UIButton *)sender
{
    self.userIsTypingDigit = NO;
    self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:self.inputAndAnswerDisplay.text];
    self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:[sender currentTitle]];
    
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    if (!self.isUserTypingDigit) {
        self.inputAndAnswerDisplay.text = @"";
        self.userIsTypingDigit = YES;
    }
    self.inputAndAnswerDisplay.text = [self.inputAndAnswerDisplay.text stringByAppendingString:[sender currentTitle]];
}

- (IBAction)solveExpression {
    
    // Weiterleitung zur Parser-Implementierung
    //    eval(self.computationDisplay.text);
    
    //
    //    } else if ([self.waitingOperation isEqualToString:@"÷"]) {
    //        if (operant != 0.0) {
    //            operant = self.waitingOperant / operant;
    //        } else {
    //            NSLog(@"Fehler: Division durch Null!");
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Division durch Null!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //            [alert show];
    //            return @"Fehler";
    //        }
}

- (IBAction)period
{
    // In a floating point Number, one Comma only is allowed. Therefor, we have to check the input.
    
    if ([self.inputAndAnswerDisplay.text rangeOfString:@"."].location == NSNotFound) {
        self.inputAndAnswerDisplay.text = [self.inputAndAnswerDisplay.text stringByAppendingString:@"."];
        self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:@"."];
    }
}

- (IBAction)reverseSign {
    double tmp = [self.inputAndAnswerDisplay.text doubleValue] * (-1);
    self.inputAndAnswerDisplay.text = [NSString stringWithFormat:@"%f",tmp];
    
    // Umwandeln in Zahl und dann als -Zahl im Display ausgeben?!
}

@end