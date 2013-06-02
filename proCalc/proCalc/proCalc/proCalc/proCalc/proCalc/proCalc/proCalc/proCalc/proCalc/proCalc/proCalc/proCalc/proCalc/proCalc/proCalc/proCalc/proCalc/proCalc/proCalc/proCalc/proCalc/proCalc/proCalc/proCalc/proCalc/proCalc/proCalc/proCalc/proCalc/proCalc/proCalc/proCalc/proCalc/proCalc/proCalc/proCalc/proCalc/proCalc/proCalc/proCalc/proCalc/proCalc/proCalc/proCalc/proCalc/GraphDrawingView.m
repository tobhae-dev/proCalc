//
//  GraphDrawingView.m
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "GraphDrawingView.h"

@implementation GraphDrawingView

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



- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

@end
