//
//  Parser.h
//  proCalc
//
//  Created by Jonas on 6/13/13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <Foundation/Foundation.h>

  
@interface Parser : NSObject{
    NSString *funktion;
}
- (double) xReplace:(NSString *)expr xwert:(NSString*) zahl;
- (double) ParseExpr;
- (double) ParseFactor;
- (double) ParseTerm;
- (double) ParseNumber;
- (void) power;
- (void) cosinus;
- (void) sinus;
- (void) tangent;
- (void) percent;
- (void) root;
- (void) loga;
- (void) loga10;
-(bool) control:(NSString *)fnkt;
@end
