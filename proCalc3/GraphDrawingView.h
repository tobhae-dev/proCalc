//
//  GraphDrawingView.h
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGraphHeight 2000       //Höhe Zeichenfläche
#define kDefaultGraphWidth 2000 //Breite Zeichenfläche
#define kStepX 20              //koordinatensystem x-Abstand
#define kStepY 20              //koordinatensystem y-Abstand
#define kOffsetX 0              //verschiebung des in X-Richung
#define kCircleRadius 2 //punktradius


#define kGraphBottom 2000
#define kGraphTop 0

#define kOffsetY 0


@interface GraphDrawingView : UIView{
}
- (void)setup:(NSString *)expr;
@end


