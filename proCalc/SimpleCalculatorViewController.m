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
#import "Parser.h"


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
    //test*******************************************************
    double zahl;
    NSString *term[30];
    NSString *wertX[30];
    NSString *korrekt;
    double soll[30];
    Parser *parser=[[Parser alloc] init];
    
    term[0]=@"cos(x)*sin(2*x-0.25)";
    wertX[0]=@"0.5";
    soll[0]=0.5981942893;
    
    term[1]=@"sin(x)";
    wertX[1]=@"0.5";
    soll[1]=0.479426;
    
    term[2]=@"2^2^2";
    wertX[2]=@"0.5";
    soll[2]=16;
    
    term[3]=@"cos(tan(sin(1))*2)";
    wertX[3]=@"0.5";
    soll[3]=-0.618697;
    
    term[4]=@"cos(0.5)*tan(sin(x))";
    wertX[4]=@"0.5";
    soll[4]=0.45623841341;
    
    term[5]=@"(x+1)^(x-3)";
    wertX[5]=@"5";
    soll[5]=36;
    
    term[6]=@"6.5^(x-3)+4*x+cos(sin(x))";
    wertX[6]=@"5";
    soll[6]=62.824401;
    
    term[7]=@"4*cos (   x)-sin(3^(x-2) )*t an(1 )";
    wertX[7]=@"5";
    soll[7]=-0.354820;
    
    term[8]=@"200*(6*x)%";
    wertX[8]=@"5";
    soll[8]=60;
    
    term[9]=@"e^x";
    wertX[9]=@"3";
    soll[9]=20.085537;
    
    term[10]=@"cos(4*x)*(e^2)+3*tan(sin(x))";
    wertX[10]=@"4";
    soll[10]=-9.909345;
    
    term[11]=@"x/0";
    wertX[11]=@"4";
    soll[11]=INFINITY;
    
    term[12]=@"sin(sin(1))";
    wertX[12]=@"4";
    soll[12]=0.745624;
    
    term[13]=@"(10%)%";
    wertX[13]=@"4";
    soll[13]=0.001;
    
    term[14]=@"cos(cos(1))";
    wertX[14]=@"4";
    soll[14]=0.857553;
    
    term[15]=@"tan(tan(tan(1)))";
    wertX[15]=@"4";
    soll[15]=-0.860840;
    
    term[16]=@"x^(x^x)";
    wertX[16]=@"2";
    soll[16]=16;
    
    term[17]=@"sqrt(sqrt(1))";
    wertX[17]=@"4";
    soll[17]=1;
    
    term[18]=@"(2^2)^(2^2)";
    wertX[18]=@"4";
    soll[18]=256;
    
    term[19]=@"sin(cos(sin(cos(x))))";
    wertX[19]=@"2";
    soll[19]=0.795239;
    
    term[20]=@"sin(tan(cos(sin(x^4+2))))";
    wertX[20]=@"8";
    soll[20]=0.584700;
    
    term[21]=@"cos(x)*cos(cos(x))";
    wertX[21]=@"1";
    soll[21]=0.463338;
   
    for(int i=0;i<=21;i++){
    if([parser kontrolle:term[i]]){
    zahl=[parser xReplace:term[i] xwert:wertX[i]]; //0.598195
        if(zahl==soll[i]){
            korrekt=@"Richtig";
        }
        else{
        korrekt=@"Falsch";
        }
        
    NSLog(@"%@=%f Soll:%f",term[i],zahl,soll[i]);
    }
    else{
        NSLog(@"'%@' ist keine Funktion",term[i]);
    }
    }
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