//
//  CalcViewController.m
//  proCalc3
//
//  Created by Tobias Hähnel on 26.07.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "CalcViewController.h"
#import "Parser.h"

@interface CalcViewController ()

@property (weak, nonatomic) IBOutlet UILabel *inputAndAnswerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *computationDisplay;
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

@implementation CalcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.computationDisplay.text = @"";
    self.computationDisplay.font = [UIFont fontWithName:@"Digital-7" size:26];
    self.inputAndAnswerDisplay.font = [UIFont fontWithName:@"Digital-7" size:30];
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
            
            CGRect rect = _numpadView.frame;
            rect.origin.x = 288;
            rect.origin.y = 52;
            rect.size.width = 280;
            rect.size.height = 200;
            _numpadView.frame = rect;
            
            rect = _computationDisplay.frame;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.width = 280;
            rect.size.height = 44;
            _computationDisplay.frame = rect;
            
            
            rect = _inputAndAnswerDisplay.frame;
            rect.origin.x = 0;
            rect.origin.y = 44;
            rect.size.width = 280;
            rect.size.height = 52;
            _inputAndAnswerDisplay.frame = rect;
            
            rect = _multiplyButton.frame;
            rect.origin.x = 505;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _multiplyButton.frame = rect;
            
            rect = _divideButton.frame;
            rect.origin.x = 433;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _divideButton.frame = rect;
            
            rect = _accButton.frame;
            rect.origin.x = 360;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            self.accButton.frame = rect;
            
            rect = _shiftButton.frame;
            rect.origin.x = 288;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _shiftButton.frame = rect;
            
            rect = _percentageAndEButton.frame;
            rect.origin.x = 216;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            _percentageAndEButton.frame = rect;
            
            rect = _baseAndNaturalLogButton.frame;
            rect.origin.x = 144;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            _baseAndNaturalLogButton.frame = rect;
            
            rect = _memoryRecallButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryRecallButton.frame = rect;
            
            rect = _memoryMinusButton.frame;
            rect.origin.x = 0;
            rect.origin.y = 209;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryMinusButton.frame = rect;
            
            rect = _memoryPlusButton.frame;
            rect.origin.x = 0;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryPlusButton.frame = rect;
            
            rect = self.memoryClearButton.frame;
            rect.origin.x = 0;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            self.memoryClearButton.frame = rect;
            
            rect = _inverseAndPiButton.frame;
            rect.origin.x = 216;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            _inverseAndPiButton.frame = rect;
            
            rect = _squareAndCubeButton.frame;
            rect.origin.x = 144;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            _squareAndCubeButton.frame = rect;
            
            rect = _squareAndCubeRootButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 156;
            rect.size.width = 64;
            rect.size.height = 44;
            _squareAndCubeRootButton.frame = rect;
            
            rect = _xyAndTanButton.frame;
            rect.origin.x = 216;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            _xyAndTanButton.frame = rect;
            
            rect = _closeBracketAndCosButton.frame;
            rect.origin.x = 144;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            _closeBracketAndCosButton.frame = rect;
            
            rect = _openBracketAndSinButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 104;
            rect.size.width = 64;
            rect.size.height = 44;
            _openBracketAndSinButton.frame = rect;
            
        }
        
        if (fromInterfaceOrientation != UIInterfaceOrientationPortrait)
        {
            //Do what you want in Portrait
            
            CGRect rect = _numpadView.frame;
            rect.origin.x = 20;
            rect.origin.y = 300;
            rect.size.width = 280;
            rect.size.height = 220;
            _numpadView.frame = rect;
            
            rect = _computationDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 20;
            rect.size.width = 280;
            rect.size.height = 25;
            _computationDisplay.frame = rect;
            
            rect = _inputAndAnswerDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 45;
            rect.size.width = 280;
            rect.size.height = 38;
            _inputAndAnswerDisplay.frame = rect;
            
            rect = _multiplyButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            _multiplyButton.frame = rect;
            
            rect = _divideButton.frame;
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
            _accButton.frame = rect;
            
            rect = _shiftButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            _shiftButton.frame = rect;
            
            rect = _percentageAndEButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            _percentageAndEButton.frame = rect;
            
            rect = _baseAndNaturalLogButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 247;
            rect.size.width = 64;
            rect.size.height = 44;
            _baseAndNaturalLogButton.frame = rect;
            
            rect = _memoryRecallButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryRecallButton.frame = rect;
            
            rect = _memoryMinusButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryMinusButton.frame = rect;
            
            rect = _memoryPlusButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryPlusButton.frame = rect;
            
            rect = _memoryClearButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 91;
            rect.size.width = 64;
            rect.size.height = 44;
            _memoryClearButton.frame = rect;
            
            rect = _inverseAndPiButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            _inverseAndPiButton.frame = rect;
            
            rect = _squareAndCubeButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            _squareAndCubeButton.frame = rect;
            
            rect = _squareAndCubeRootButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 195;
            rect.size.width = 64;
            rect.size.height = 44;
            _squareAndCubeRootButton.frame = rect;
            
            rect = _xyAndTanButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            _xyAndTanButton.frame = rect;
            
            rect = _closeBracketAndCosButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            _closeBracketAndCosButton.frame = rect;
            
            rect = _openBracketAndSinButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 143;
            rect.size.width = 64;
            rect.size.height = 44;
            _openBracketAndSinButton.frame = rect;
        }
        
    } else {
        /*Do iPhone Classic stuff here.*/
        if (fromInterfaceOrientation == UIInterfaceOrientationPortrait)
        {
            //Do what you want in Landscape
            
            CGRect rect = _numpadView.frame;
            rect.origin.x = 180;
            rect.origin.y = 51;
            rect.size.width = 280;
            rect.size.height = 200;
            _numpadView.frame = rect;
            
            rect = _computationDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 0;
            rect.size.width = 148;
            rect.size.height = 44;
            _computationDisplay.frame = rect;
            
            rect = _inputAndAnswerDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 44;
            rect.size.width = 148;
            rect.size.height = 52;
            _inputAndAnswerDisplay.frame = rect;
            
            rect = _multiplyButton.frame;
            rect.origin.x = 396;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _multiplyButton.frame = rect;
            
            rect = _divideButton.frame;
            rect.origin.x = 324;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _divideButton.frame = rect;
            
            rect = _accButton.frame;
            rect.origin.x = 252;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _accButton.frame = rect;
            
            rect = _shiftButton.frame;
            rect.origin.x = 180;
            rect.origin.y = 0;
            rect.size.width = 64;
            rect.size.height = 44;
            _shiftButton.frame = rect;
            
            rect = _percentageAndEButton.frame;
            rect.origin.x = 124;
            rect.origin.y = 207;
            rect.size.width = 44;
            rect.size.height = 44;
            _percentageAndEButton.frame = rect;
            
            rect = _baseAndNaturalLogButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 207;
            rect.size.width = 44;
            rect.size.height = 44;
            _baseAndNaturalLogButton.frame = rect;
            
            rect = _inverseAndPiButton.frame;
            rect.origin.x = 124;
            rect.origin.y = 155;
            rect.size.width = 44;
            rect.size.height = 44;
            _inverseAndPiButton.frame = rect;
            
            rect = _squareAndCubeButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 155;
            rect.size.width = 44;
            rect.size.height = 44;
            _squareAndCubeButton.frame = rect;
            
            rect = _squareAndCubeRootButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 155;
            rect.size.width = 44;
            rect.size.height = 44;
            _squareAndCubeRootButton.frame = rect;
            
            rect = _xyAndTanButton.frame;
            rect.origin.x = 124;
            rect.origin.y = 103;
            rect.size.width = 44;
            rect.size.height = 44;
            _xyAndTanButton.frame = rect;
            
            rect = self.closeBracketAndCosButton.frame;
            rect.origin.x = 72;
            rect.origin.y = 103;
            rect.size.width = 44;
            rect.size.height = 44;
            self.closeBracketAndCosButton.frame = rect;
            
            rect = _openBracketAndSinButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 103;
            rect.size.width = 44;
            rect.size.height = 44;
            _openBracketAndSinButton.frame = rect;
            
            _memoryRecallButton.hidden = YES;
            _memoryMinusButton.hidden = YES;
            _memoryPlusButton.hidden = YES;
            _memoryClearButton.hidden = YES;
            
        }
        
        if (fromInterfaceOrientation != UIInterfaceOrientationPortrait)
        {
            //Do what you want in Portrait
            
            CGRect rect = _numpadView.frame;
            rect.origin.x = 20;
            rect.origin.y = 211;
            rect.size.width = 280;
            rect.size.height = 200;
            _numpadView.frame = rect;
            
            rect = _computationDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 3;
            rect.size.width = 280;
            rect.size.height = 21;
            _computationDisplay.frame = rect;
            
            rect = _inputAndAnswerDisplay.frame;
            rect.origin.x = 20;
            rect.origin.y = 24;
            rect.size.width = 280;
            rect.size.height = 25;
            _inputAndAnswerDisplay.frame = rect;
            
            rect = _multiplyButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            _multiplyButton.frame = rect;
            
            rect = _divideButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            _divideButton.frame = rect;
            
            rect = _accButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            _accButton.frame = rect;
            
            rect = _shiftButton.frame;
            rect.origin.x = 236;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            _shiftButton.frame = rect;
            
            rect = _percentageAndEButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            _percentageAndEButton.frame = rect;
            
            rect = _baseAndNaturalLogButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 159;
            rect.size.width = 64;
            rect.size.height = 44;
            _baseAndNaturalLogButton.frame = rect;
            
            rect = _inverseAndPiButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            _inverseAndPiButton.frame = rect;
            
            rect = _squareAndCubeButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            _squareAndCubeButton.frame = rect;
            
            rect = _squareAndCubeRootButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 107;
            rect.size.width = 64;
            rect.size.height = 44;
            _squareAndCubeRootButton.frame = rect;
            
            rect = _xyAndTanButton.frame;
            rect.origin.x = 164;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            _xyAndTanButton.frame = rect;
            
            rect = _closeBracketAndCosButton.frame;
            rect.origin.x = 92;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            _closeBracketAndCosButton.frame = rect;
            
            rect = _openBracketAndSinButton.frame;
            rect.origin.x = 20;
            rect.origin.y = 55;
            rect.size.width = 64;
            rect.size.height = 44;
            _openBracketAndSinButton.frame = rect;
            
            _memoryRecallButton.hidden = YES;
            _memoryMinusButton.hidden = YES;
            _memoryPlusButton.hidden = YES;
            _memoryClearButton.hidden = YES;
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
    _accButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _accButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _baseAndNaturalLogButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _percentageAndEButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _inverseAndPiButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _squareAndCubeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _squareAndCubeRootButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _xyAndTanButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _xyAndTanButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _closeBracketAndCosButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _closeBracketAndCosButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _openBracketAndSinButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _openBracketAndSinButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    if (!self.isUserPressingShift) {
        //        self.accButton.titleLabel.text = @"⬅";
        [_accButton setTitle:@"⬅" forState:UIControlStateNormal];
        _baseAndNaturalLogButton.titleLabel.text = @"ln";
        _percentageAndEButton.titleLabel.text = @"e";
        _inverseAndPiButton.titleLabel.text = @"π";
        _squareAndCubeRootButton.titleLabel.text = @"∛";
        _squareAndCubeButton.titleLabel.text = @"x³";
        _openBracketAndSinButton.titleLabel.text = @"(";
        _closeBracketAndCosButton.titleLabel.text = @")";
        _xyAndTanButton.titleLabel.text = @"xʸ";
        
        [_shiftButton setTitleColor:[UIColor yellowColor] forState: UIControlStateNormal];
        
        //        if (!self.isUserPressingShift) {
        //            self.accButton.titleLabel.text = @"⬅";
        //        }
        _userIsPressingShift = YES;
        
    } else {
        //        self.accButton.titleLabel.text = @"AC/C";
        [_accButton setTitle:@"AC/C" forState:UIControlStateNormal];
        _baseAndNaturalLogButton.titleLabel.text = @"log";
        _percentageAndEButton.titleLabel.text = @"%";
        _inverseAndPiButton.titleLabel.text = @"¹/x";
        _squareAndCubeRootButton.titleLabel.text = @"√";
        _squareAndCubeButton.titleLabel.text = @"x²";
        _openBracketAndSinButton.titleLabel.text = @"sin";
        _closeBracketAndCosButton.titleLabel.text = @"cos";
        _xyAndTanButton.titleLabel.text = @"tan";
        
        [_shiftButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        _userIsPressingShift = NO;
    }
}

- (IBAction)clearTheDisplays:(UIButton *)sender
{
    if (!self.isUserPressingShift) {
        if ([self.inputAndAnswerDisplay.text isEqual: @"0"]) {
            _computationDisplay.text = @"";
        }
        _inputAndAnswerDisplay.text = @"0";
        NSLog(@"ACC");
        
    } else {
        NSString *expression;
        expression = self.computationDisplay.text;
        expression = [expression substringToIndex:expression.length-1];
        _computationDisplay.text = expression;
        NSLog(@"Pfeil");
    }
}

#pragma mark - Simple Calculations

// TODO
// n-te Wurzel mit pow(double, double) aus <cmath> ,zb: 4te Wurzel aus 81 : pow(81.0, 1.0/4.0)
// Division durch 0 ?

- (IBAction)userPressedMathematicalOperation:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"×"]) {
        _computationDisplay.text = [_computationDisplay.text stringByAppendingString:@"*"];
    }
    else if ([sender.currentTitle isEqualToString:@"÷"]) {
        _computationDisplay.text = [_computationDisplay.text stringByAppendingString:@"/"];
    }
    else if ([sender.currentTitle isEqualToString:@"."]) {
        // In a floating point Number, one Comma only is allowed. Therefor, we have to check the input.
        if ([_inputAndAnswerDisplay.text rangeOfString:@"."].location == NSNotFound) {
            _inputAndAnswerDisplay.text = [_inputAndAnswerDisplay.text stringByAppendingString:@"."];
            _computationDisplay.text = [_computationDisplay.text stringByAppendingString:@"."];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"±"]) {
        self.computationDisplay.text=[self.computationDisplay.text stringByAppendingString:@"-"];
    }
    else if ([sender.currentTitle isEqualToString:@"x²"]) {
        if(self.isUserPressingShift) {
            self.computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"³"];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"²"];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"log"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"ln("];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"log("];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"%"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"e"];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"%"];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"¹/x"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"π"];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"1/"];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"√"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"∛"];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"√"];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"tan"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"^"];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"tan("];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"cos"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@")"];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"cos("];
        }
    }
    else if ([sender.currentTitle isEqualToString:@"sin"]) {
        if(self.isUserPressingShift) {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"("];
        } else {
            _computationDisplay.text=[_computationDisplay.text stringByAppendingString:@"sin("];
        }
    } else {
        _computationDisplay.text = [_computationDisplay.text stringByAppendingString:[sender currentTitle]];
    }
    _userIsPressingShift = YES;
    [self showAlternativeButtonTitle];
}

- (IBAction)solveExpression {
    
    double zahl;
    Parser *parser=[[Parser alloc] init];
    NSString *expression = _computationDisplay.text;
    if([parser control:expression]){
        zahl=[parser xReplace:expression xwert:@"1"];
        if (zahl!=INFINITY) {
            _inputAndAnswerDisplay.text=[NSString stringWithFormat:@"%f", zahl];
        }
        else{
            _inputAndAnswerDisplay.text=[NSString stringWithFormat:@"Division durch Null"];
        }
    }else{
        _inputAndAnswerDisplay.text=[NSString stringWithFormat:@"Die Funktion ist ungültig"];
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
        _memoryContent = 0.0;
    }
    if ([sender.currentTitle isEqualToString:@"M+"]) {
        // Memory "plus" inputAndAnswerDisplay
        if ([_inputAndAnswerDisplay.text isEqualToString:@"0"]) {
            NSLog(@"inputAndAnswerDisplay.text == 0");
            _computationDisplay.text = [self.computationDisplay.text stringByAppendingString: [NSString stringWithFormat:@"(%f)", self.memoryContent]];
        } else {
            _memoryContent += [_inputAndAnswerDisplay.text doubleValue];
        }
    }
    if ([sender.currentTitle isEqualToString:@"M-"]) {
        // Memory "minus" inputAndAnswerDisplay
        if ([_inputAndAnswerDisplay.text isEqualToString:@"0"]) {
            _computationDisplay.text = [_computationDisplay.text stringByAppendingString: [NSString stringWithFormat:@"(%f)", _memoryContent]];
        } else {
            _memoryContent -= [_inputAndAnswerDisplay.text doubleValue];
        }
    }
    if ([sender.currentTitle isEqualToString:@"MR"]) {
        // Memory Recall -> Show on inputAndAnswerDisplay
        _inputAndAnswerDisplay.text = [NSString stringWithFormat:@"%f", _memoryContent];
    }
}

@end
