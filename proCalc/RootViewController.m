//
//  RootViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "RootViewController.h"
#import "Parser.h"
@interface RootViewController ()

@end

@implementation RootViewController



//mal x
- (IBAction)multi:(UIButton *)sender {
    
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"*"];
    
}

//AC
- (IBAction)clearTheDisplay:(UIButton *)sender
{
    self.gleichung.text=@"";
    self.ergebniss.text=@"";
    
}
- (IBAction)punkt:(id)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"."];
}
- (IBAction)potenz:(UIButton *)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"^2"];
}
- (IBAction)durch:(UIButton *)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"/"];
}

- (IBAction)loga:(UIButton *)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"log("];
}
- (IBAction)lona:(UIButton *)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"ln("];
}
- (IBAction)geteilt:(id)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"1/"];
}
//C
- (IBAction)clearlast:(UIButton *)sender
{
    NSString *gleich;
    gleich=self.gleichung.text;
    gleich=[gleich substringToIndex:gleich.length-1];
    self.gleichung.text=gleich;
    
}
- (IBAction)wurzel:(UIButton *)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"sqrt("];
}

- (IBAction)tan:(id)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"tan("];
}
- (IBAction)cos:(id)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"cos("];
}
- (IBAction)sin:(id)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"sin("];
}
- (IBAction)potenz2:(id)sender {
    self.gleichung.text=[self.gleichung.text stringByAppendingString:@"^"];
}

- (IBAction)digitPressed:(UIButton *)sender {
    
self.gleichung.text=[self.gleichung.text stringByAppendingString:[sender currentTitle]];

}

- (IBAction)solveExpression {
    
    double zahl;
    Parser *parser=[[Parser alloc] init];
    NSString *gleichung=self.gleichung.text;
    if([parser kontrolle:gleichung]){
    zahl=[parser xReplace:gleichung xwert:@"1"];
    self.ergebniss.text=[NSString stringWithFormat:@"%f", zahl];
    }else{
    self.ergebniss.text=[NSString stringWithFormat:@"Die Funktion ist ungültig"];
    }
    
 
}

@end
