//
//  GraphDrawingView.m
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "GraphDrawingView.h"
#import "Parser.h"
#import "SimpleGraphViewController.h"

float data[(kDefaultGraphWidth/kStepX)*10];
float Ytext[(kGraphHeight/kStepY)*10];
float Xtext[(kDefaultGraphWidth/kStepX)*10];

@implementation GraphDrawingView

- (void)setup:(NSString *)expr
{
    double zahl;
    Parser *parser=[[Parser alloc] init];
   NSString *gleichung=expr;
    if ([parser control:gleichung] && gleichung.length>0) {
        for (int i=0; i<=kDefaultGraphWidth/kStepX*10; i++) {
            NSString *xwerte=[NSString stringWithFormat:@"%f", Xtext[i]];
            zahl=[parser xReplace:gleichung xwert:xwerte];
            data[i]=zahl;
            
        } 
    }

  
}

- (void)awakeFromNib
{
    double startY=-1*(((kGraphHeight/kStepY)+2)/2);
    double startX=-1*(((kDefaultGraphWidth/kStepX)+2)/2);
    for (int i=0; i<=kGraphHeight/kStepY*10; i++) {
        Ytext[i]=startY*-1;
        startY=startY+0.1;
    }
    for (int i=0; i<=kDefaultGraphWidth/kStepX*10; i++) {
        Xtext[i]=startX;
        startX=startX+0.1;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    //self = [super initWithFrame:frame];
    //[self setup:@"0"];
   return self;
}

// Drawing a function
- (void)drawLineGraphWithContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 1);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX,kGraphHeight/2- (kStepY * data[0]));
    for (int i = 0; i < sizeof(data); i++)
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX/10,kGraphHeight/2- (kStepY * data[i]));
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    
    /*
    for (int i = 1; i < sizeof(data) - 1; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight/2- (kStepY * data[i]);
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }*/
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    // How many lines?
    
    int howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    // Here the lines go
    for (int i = 0; i < howMany; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }
    
    int howManyHorizontal = (kGraphBottom - kGraphTop - kOffsetY) / kStepY;
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kGraphBottom - kOffsetY - i * kStepY);
        CGContextAddLineToPoint(context, kDefaultGraphWidth, kGraphBottom - kOffsetY - i * kStepY);
    }
    
    CGContextStrokePath(context);
    
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
    
    [self drawLineGraphWithContext:context];
    
    // Lableing the x-Axis of the Coordinate System
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 10, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
    for (int i = 0; i < (kGraphHeight/kStepY)*10; i=i+10)
    {
        NSString *theText = [NSString stringWithFormat:@"%4.0f", Xtext[i]];
        CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:10]];
        CGContextShowTextAtPoint(context, kOffsetX + i/10 * kStepX - labelSize.width/2-2, kGraphHeight/2+4, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);

 
    }
    
    // Lableing the Y-Axis of the Coordinate System
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    CGContextSelectFont(context, "Helvetica", 10, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
   
    for (int i = 0; i < (kDefaultGraphWidth/kStepX)*10; i=i+10)
    {
        NSString *theText = [NSString stringWithFormat:@"%4.0f", Ytext[i]];
        CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:10]];
        CGContextShowTextAtPoint(context, kDefaultGraphWidth/2 +kStepX/2, kOffsetY + i/10 * kStepY - labelSize.width/2-kStepY/2,  [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        
        
    }
}


@end
