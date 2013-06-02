//
//  GraphPlotterView.m
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "GraphPlotterView.h"

@implementation GraphPlotterView

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
