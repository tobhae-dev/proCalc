//
//  SimpleCalcViewController.m
//  proCalc3
//
//  Created by Tobias Hähnel on 26.07.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "SimpleCalcViewController.h"
#import "Parser.h"

@interface SimpleCalcViewController ()

@property (weak, nonatomic) IBOutlet UILabel *inputAndAnswerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *computationDisplay;
@property (nonatomic, getter = isUserTypingDigit) BOOL userIsTypingDigit;
@property (nonatomic, getter = isUserPressingShift) BOOL userIsPressingShift;
@property (nonatomic) double memoryContent;


@property (strong, nonatomic) IBOutlet UIView *numpadView;
@property (strong, nonatomic) IBOutlet UIButton *multiplyButton;
@property (strong, nonatomic) IBOutlet UIButton *divideButton;
@property (strong, nonatomic) IBOutlet UIButton *baseAndNaturalLogButton;
@property (strong, nonatomic) IBOutlet UIButton *percentageAndEButton;
@property (strong, nonatomic) IBOutlet UIButton *inverseAndPiButton;
@property (strong, nonatomic) IBOutlet UIButton *squareAndCubeButton;
@property (strong, nonatomic) IBOutlet UIButton *squareAndCubeRootButton;
@property (strong, nonatomic) IBOutlet UIButton *xyAndTanButton;
@property (strong, nonatomic) IBOutlet UIButton *closeBracketAndCosButton;
@property (strong, nonatomic) IBOutlet UIButton *openBracketAndSinButton;

@property (strong, nonatomic) IBOutlet UIButton *accButton;
@property (strong, nonatomic) IBOutlet UIButton *shiftButton;

@property (strong, nonatomic) IBOutlet UIButton *memoryRecallButton;
@property (strong, nonatomic) IBOutlet UIButton *memoryMinusButton;
@property (strong, nonatomic) IBOutlet UIButton *memoryPlusButton;
@property (strong, nonatomic) IBOutlet UIButton *memoryClearButton;

@end

@implementation SimpleCalcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.computationDisplay.text = @"";
}

#pragma mark - Button Layout

- (void)didRotateFromInterfaceOrientation: (UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:
     fromInterfaceOrientation];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (screenSize.height > 480.0f) {
        /*Do iPhone 5 stuff here.*/
        
        if (fromInterfaceOrientation == UIInterfaceOrientationPortrait)
        {
            //Do what you want in Landscape
            
            CGRect rect = self.numpadView.frame;
            rect.origin.x = 288;
            rect.origin.y = 52;
            rect.size.width = 280;
            rect.size.height = 200;
            self.numpadView.frame = rect;
            
            rect = self.computationDisplay.frame;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.width = 280;
            rect.size.height = 44;
            self.computationDisplay.frame = rect;
            
            rect = self.inputAndAnswerDisplay.frame;
            rect.origin.x = 0;
            rect.origin.y = 44;
            rect.size.width = 280;
            rect.size.height = 52;
            self.inputAndAnswerDisplay.frame = rect;
            
            rect = self.multiplyButton.frame;
            rect.origin.x = 505;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.multiplyButton.frame = rect;
            
            rect = self.divideButton.frame;
            rect.origin.x = 433;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.divideButton.frame = rect;
            
            rect = self.accButton.frame;
            rect.origin.x = 360;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.accButton.frame = rect;
            
            rect = self.shiftButton.frame;
            rect.origin.x = 288;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.shiftButton.frame = rect;
            
            rect = self.percentageAndEButton.frame;
            rect.origin.x = 216;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            self.percentageAndEButton.frame = rect;
            
            rect = self.baseAndNaturalLogButton.frame;
            rect.origin.x = 144;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            self.baseAndNaturalLogButton.frame = rect;
            
            rect = self.memoryRecallButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryRecallButton.frame = rect;
            
            rect = self.memoryMinusButton.frame;
            rect.origin.x = 0;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryMinusButton.frame = rect;
            
            rect = self.memoryPlusButton.frame;
            rect.origin.x = 0;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryPlusButton.frame = rect;
            
            rect = self.memoryClearButton.frame;
            rect.origin.x = 0;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryClearButton.frame = rect;
            
            rect = self.inverseAndPiButton.frame;
            rect.origin.x = 216;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            self.inverseAndPiButton.frame = rect;
            
            rect = self.squareAndCubeButton.frame;
            rect.origin.x = 144;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            self.squareAndCubeButton.frame = rect;
            
            rect = self.squareAndCubeRootButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            self.squareAndCubeRootButton.frame = rect;
            
            rect = self.xyAndTanButton.frame;
            rect.origin.x = 216;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            self.xyAndTanButton.frame = rect;
            
            rect = self.closeBracketAndCosButton.frame;
            rect.origin.x = 144;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            self.closeBracketAndCosButton.frame = rect;
            
            rect = self.openBracketAndSinButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            self.openBracketAndSinButton.frame = rect;
            
        }
        
        if (fromInterfaceOrientation != UIInterfaceOrientationPortrait)
        {
            //Do what you want in Portrait
            
            CGRect rect = self.numpadView.frame;
            rect.origin.x = 20;
            rect.origin.y = 300;
            rect.size.width = 280;
            rect.size.height = 220;
            self.numpadView.frame = rect;
            
            rect = self.computationDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 20;
            rect.size.width = 280;
            rect.size.height = 25;
            self.computationDisplay.frame = rect;
            
            rect = self.inputAndAnswerDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 45;
            rect.size.width = 280;
            rect.size.height = 38;
            self.inputAndAnswerDisplay.frame = rect;
            
            rect = self.multiplyButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            self.multiplyButton.frame = rect;
            
            rect = self.divideButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            self.divideButton.frame = rect;
            
            rect = self.accButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            self.accButton.frame = rect;
            
            rect = self.shiftButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            self.shiftButton.frame = rect;
            
            rect = self.percentageAndEButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            self.percentageAndEButton.frame = rect;
            
            rect = self.baseAndNaturalLogButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            self.baseAndNaturalLogButton.frame = rect;
            
            rect = self.memoryRecallButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryRecallButton.frame = rect;
            
            rect = self.memoryMinusButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryMinusButton.frame = rect;
            
            rect = self.memoryPlusButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryPlusButton.frame = rect;
            
            rect = self.memoryClearButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryClearButton.frame = rect;
            
            rect = self.inverseAndPiButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            self.inverseAndPiButton.frame = rect;
            
            rect = self.squareAndCubeButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            self.squareAndCubeButton.frame = rect;
            
            rect = self.squareAndCubeRootButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            self.squareAndCubeRootButton.frame = rect;
            
            rect = self.xyAndTanButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            self.xyAndTanButton.frame = rect;
            
            rect = self.closeBracketAndCosButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            self.closeBracketAndCosButton.frame = rect;
            
            rect = self.openBracketAndSinButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            self.openBracketAndSinButton.frame = rect;
        }
        
    } else {
        /*Do iPhone Classic stuff here.*/
        if (fromInterfaceOrientation == UIInterfaceOrientationPortrait)
        {
            //Do what you want in Landscape
            
            CGRect rect = self.numpadView.frame;
            rect.origin.x = 180;
            rect.origin.y = 51;
            rect.size.width = 280;
            rect.size.height = 200;
            self.numpadView.frame = rect;
            
            rect = self.computationDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 0;
            rect.size.width = 148;
            rect.size.height = 44;
            self.computationDisplay.frame = rect;
            
            rect = self.inputAndAnswerDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 44;
            rect.size.width = 148;
            rect.size.height = 52;
            self.inputAndAnswerDisplay.frame = rect;
            
            rect = self.multiplyButton.frame;
            rect.origin.x = 396;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.multiplyButton.frame = rect;
            
            rect = self.divideButton.frame;
            rect.origin.x = 324;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.divideButton.frame = rect;
            
            rect = self.accButton.frame;
            rect.origin.x = 252;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.accButton.frame = rect;
            
            rect = self.shiftButton.frame;
            rect.origin.x = 180;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.shiftButton.frame = rect;
            
            rect = self.percentageAndEButton.frame;
            rect.origin.x = 124;
            rect.origin.y = 207;
            rect.size.width = 44;
            rect.size.height = 44;
            self.percentageAndEButton.frame = rect;
            
            rect = self.baseAndNaturalLogButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 207;
            rect.size.width = 44;
            rect.size.height = 44;
            self.baseAndNaturalLogButton.frame = rect;
            
            rect = self.inverseAndPiButton.frame;
            rect.origin.x = 124;
            rect.origin.y = 155;
            rect.size.width = 44;
            rect.size.height = 44;
            self.inverseAndPiButton.frame = rect;
            
            rect = self.squareAndCubeButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 155;
            rect.size.width = 44;
            rect.size.height = 44;
            self.squareAndCubeButton.frame = rect;
            
            rect = self.squareAndCubeRootButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 155;
            rect.size.width = 44;
            rect.size.height = 44;
            self.squareAndCubeRootButton.frame = rect;
            
            rect = self.xyAndTanButton.frame;
            rect.origin.x = 124;
            rect.origin.y = 103;
            rect.size.width = 44;
            rect.size.height = 44;
            self.xyAndTanButton.frame = rect;
            
            rect = self.closeBracketAndCosButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 103;
            rect.size.width = 44;
            rect.size.height = 44;
            self.closeBracketAndCosButton.frame = rect;
            
            rect = self.openBracketAndSinButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 103;
            rect.size.width = 44;
            rect.size.height = 44;
            self.openBracketAndSinButton.frame = rect;
            
            self.memoryRecallButton.hidden = YES;
            self.memoryMinusButton.hidden = YES;
            self.memoryPlusButton.hidden = YES;
            self.memoryClearButton.hidden = YES;
            
        }
        
        if (fromInterfaceOrientation != UIInterfaceOrientationPortrait)
        {
            //Do what you want in Portrait
            
            CGRect rect = self.numpadView.frame;
            rect.origin.x = 20;
            rect.origin.y = 211;
            rect.size.width = 280;
            rect.size.height = 200;
            self.numpadView.frame = rect;
            
            rect = self.computationDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 3;
            rect.size.width = 280;
            rect.size.height = 21;
            self.computationDisplay.frame = rect;
            
            rect = self.inputAndAnswerDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 24;
            rect.size.width = 280;
            rect.size.height = 25;
            self.inputAndAnswerDisplay.frame = rect;
            
            rect = self.multiplyButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            self.multiplyButton.frame = rect;
            
            rect = self.divideButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            self.divideButton.frame = rect;
            
            rect = self.accButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            self.accButton.frame = rect;
            
            rect = self.shiftButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            self.shiftButton.frame = rect;
            
            rect = self.percentageAndEButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            self.percentageAndEButton.frame = rect;
            
            rect = self.baseAndNaturalLogButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            self.baseAndNaturalLogButton.frame = rect;
            
            rect = self.inverseAndPiButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            self.inverseAndPiButton.frame = rect;
            
            rect = self.squareAndCubeButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            self.squareAndCubeButton.frame = rect;
            
            rect = self.squareAndCubeRootButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            self.squareAndCubeRootButton.frame = rect;
            
            rect = self.xyAndTanButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            self.xyAndTanButton.frame = rect;
            
            rect = self.closeBracketAndCosButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            self.closeBracketAndCosButton.frame = rect;
            
            rect = self.openBracketAndSinButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            self.openBracketAndSinButton.frame = rect;
            
            self.memoryRecallButton.hidden = YES;
            self.memoryMinusButton.hidden = YES;
            self.memoryPlusButton.hidden = YES;
            self.memoryClearButton.hidden = YES;
        }
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Shift and ACC

- (IBAction)showAlternativeButtonTitle
{
    self.accButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.accButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.baseAndNaturalLogButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.percentageAndEButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.inverseAndPiButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.squareAndCubeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.squareAndCubeRootButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.xyAndTanButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.xyAndTanButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.closeBracketAndCosButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.closeBracketAndCosButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.openBracketAndSinButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.openBracketAndSinButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    if (!self.isUserPressingShift) {
        self.accButton.titleLabel.text = @"⬅";
        self.baseAndNaturalLogButton.titleLabel.text = @"ln";
        self.percentageAndEButton.titleLabel.text = @"e";
        self.inverseAndPiButton.titleLabel.text = @"π";
        self.squareAndCubeRootButton.titleLabel.text = @"∛";
        self.squareAndCubeButton.titleLabel.text = @"x³";
        self.openBracketAndSinButton.titleLabel.text = @"(";
        self.closeBracketAndCosButton.titleLabel.text = @")";
        self.xyAndTanButton.titleLabel.text = @"xʸ";
        
        [self.shiftButton setTitleColor:[UIColor yellowColor] forState: UIControlStateNormal];
        self.userIsPressingShift = YES;
        
    } else {
        self.accButton.titleLabel.text = @"AC/C";
        self.baseAndNaturalLogButton.titleLabel.text = @"log";
        self.percentageAndEButton.titleLabel.text = @"%";
        self.inverseAndPiButton.titleLabel.text = @"¹/x";
        self.squareAndCubeRootButton.titleLabel.text = @"√";
        self.squareAndCubeButton.titleLabel.text = @"x²";
        self.openBracketAndSinButton.titleLabel.text = @"sin";
        self.closeBracketAndCosButton.titleLabel.text = @"cos";
        self.xyAndTanButton.titleLabel.text = @"tan";
        
        [self.shiftButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        self.userIsPressingShift = NO;
    }
}

- (IBAction)clearTheDisplays:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"⬅"]) {
        NSString *expression;
        expression = self.computationDisplay.text;
        expression = [expression substringToIndex:expression.length-1];
        self.computationDisplay.text = expression;
    } else if ([sender.currentTitle isEqualToString:@"AC/C"]) {
        if ([self.inputAndAnswerDisplay.text isEqual: @"0"]) {
            self.computationDisplay.text = @"";
        }
        self.inputAndAnswerDisplay.text = @"0";
    }
}

#pragma mark - Simple Calculations

// TODO
// n-te Wurzel mit pow(double, double) aus <cmath> ,zb: 4te Wurzel aus 81 : pow(81.0, 1.0/4.0)
// Division durch 0 ?

- (IBAction)userPressedMathematicalOperation:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"×"]) {
        self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:@"*"];
    }
    else if ([sender.currentTitle isEqualToString:@"÷"]) {
        self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:@"/"];
    }
    else if ([sender.currentTitle isEqualToString:@"."]) {
        // In a floating point Number, one Comma only is allowed. Therefor, we have to check the input.
        if ([self.inputAndAnswerDisplay.text rangeOfString:@"."].location == NSNotFound) {
            self.inputAndAnswerDisplay.text = [self.inputAndAnswerDisplay.text stringByAppendingString:@"."];
            self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:@"."];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"±"]) {
        double tmp = [self.inputAndAnswerDisplay.text doubleValue] * (-1);
        self.inputAndAnswerDisplay.text = [NSString stringWithFormat:@"%f",tmp];
    }
    else if ([sender.currentTitle isEqualToString:@"x²"]) {
            self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"^2"];
    }
    else if ([sender.currentTitle isEqualToString:@"log"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"log("];
    }
    else if ([sender.currentTitle isEqualToString:@"ln"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"ln("];
    }
    else if ([sender.currentTitle isEqualToString:@"¹/x"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"1/"];
    }
    else if ([sender.currentTitle isEqualToString:@"√"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"sqrt("];
    }
    else if ([sender.currentTitle isEqualToString:@"tan"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"tan("];
    }
    else if ([sender.currentTitle isEqualToString:@"cos"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"cos("];
    }
    else if ([sender.currentTitle isEqualToString:@"sin"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"sin("];
    }
    else if ([sender.currentTitle isEqualToString:@"xʸ"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"^"];
    } else {
        self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:[sender currentTitle]];
    }
}

- (IBAction)solveExpression {
    
    double zahl;
    Parser *parser=[[Parser alloc] init];
    NSString *expression = self.computationDisplay.text;
    if([parser control:expression]){
        zahl=[parser xReplace:expression xwert:@"1"];
        if (zahl!=INFINITY) {
           self.inputAndAnswerDisplay.text=[NSString stringWithFormat:@"%f", zahl];
        }
        else{
            self.inputAndAnswerDisplay.text=[NSString stringWithFormat:@"Division durch Null"];
        }
    }else{
        self.inputAndAnswerDisplay.text=[NSString stringWithFormat:@"Die Funktion ist ungültig"];
    }
}

//- (IBAction)solveExpression {
//
//    // Weiterleitung zur Parser-Implementierung
//    //    eval(self.computationDisplay.text);
//
//    //
//    //    } else if ([self.waitingOperation isEqualToString:@"÷"]) {
//    //        if (operant != 0.0) {
//    //            operant = self.waitingOperant / operant;
//    //        } else {
//    //            NSLog(@"Fehler: Division durch Null!");
//    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Division durch Null!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    //            [alert show];
//    //            return @"Fehler";
//    //        }
//}

#pragma mark - Memory Functions

- (IBAction)userPressedMemoryOperation:(UIButton *)sender
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

@end
