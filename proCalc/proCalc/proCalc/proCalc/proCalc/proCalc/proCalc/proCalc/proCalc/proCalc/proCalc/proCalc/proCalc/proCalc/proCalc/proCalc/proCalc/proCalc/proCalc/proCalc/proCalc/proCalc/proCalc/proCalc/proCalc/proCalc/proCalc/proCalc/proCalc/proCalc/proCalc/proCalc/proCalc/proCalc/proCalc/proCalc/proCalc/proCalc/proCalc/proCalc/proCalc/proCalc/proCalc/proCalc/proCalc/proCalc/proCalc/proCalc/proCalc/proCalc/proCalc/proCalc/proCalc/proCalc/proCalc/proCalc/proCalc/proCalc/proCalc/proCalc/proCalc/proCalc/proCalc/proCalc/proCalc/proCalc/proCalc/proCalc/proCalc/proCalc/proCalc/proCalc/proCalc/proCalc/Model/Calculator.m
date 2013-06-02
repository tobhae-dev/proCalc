//
//  Calculator.m
//  proCalc
//
//  Created by Tobias Hähnel on 18.05.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "Calculator.h"
//#import "Math.h"

@implementation Calculator




+ (NSString *)squareRoot:(NSString *)fromString
{
    return [NSString stringWithFormat:@"%f",sqrt([fromString doubleValue])];
}

+ (NSString *)squared:(NSString *)fromString
{
    return [NSString stringWithFormat:@"%f",[fromString doubleValue] * [fromString doubleValue]];
}

+ (NSString *)logarithm:(NSString *)fromString
{
    return [NSString stringWithFormat:@"%f",log([fromString doubleValue])];
}

+ (NSString *)percentage:(NSString *)fromString
{
    return [NSString stringWithFormat:@"%f",[fromString doubleValue] * 0.01 ];
}


@end

