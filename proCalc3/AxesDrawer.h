//
//  AxisDrawer.h
//  proCalc3
//
//  Created by Tobias Hähnel on 08.09.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AxesDrawer : NSObject

+ (void)drawAxesInRect:(CGRect)bounds
         originAtPoint:(CGPoint)axisOrigin
                 scale:(CGFloat)pointsPerUnit;

@end
