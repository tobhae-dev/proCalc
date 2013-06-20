//
//  test.m
//  proCalc
//
//  Created by Jonas on 6/13/13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "test.h"
#import "Parser.h"

@implementation test


int penis(void)
{ 
   Parser *parser=[[Parser alloc] init];
    double zahl=[parser xReplace:@"3x+1" xwert:(@"3")];
    NSLog(@"%f",zahl);

    
return EXIT_SUCCESS;
    
}
@end
