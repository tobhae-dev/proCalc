//
//  ComplexCalculatorView.m
//  proCalc
//
//  Created by Tobias Hähnel on 04.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "ComplexCalculatorView.h"

@implementation ComplexCalculatorView

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
