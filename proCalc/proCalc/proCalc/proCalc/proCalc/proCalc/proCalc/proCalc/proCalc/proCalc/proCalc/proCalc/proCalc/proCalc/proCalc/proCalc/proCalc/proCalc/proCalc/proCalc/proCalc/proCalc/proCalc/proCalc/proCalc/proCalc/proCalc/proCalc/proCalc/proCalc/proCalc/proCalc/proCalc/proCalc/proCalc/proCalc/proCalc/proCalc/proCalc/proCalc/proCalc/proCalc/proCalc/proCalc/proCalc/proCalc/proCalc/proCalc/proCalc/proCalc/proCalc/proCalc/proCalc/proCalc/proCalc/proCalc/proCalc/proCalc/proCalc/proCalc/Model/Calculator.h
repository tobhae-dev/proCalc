//
//  Calculator.h
//  proCalc
//
//  Created by Tobias Hähnel on 18.05.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

+ (NSString *)squareRoot:(NSString *)fromNumber;
+ (NSString *)squared:(NSString *)fromNumber;
+ (NSString *)logarithm:(NSString *)fromNumber;
+ (NSString *)percentage:(NSString *)fromString;


@end
