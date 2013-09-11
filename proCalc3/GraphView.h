//
//  GraphView.h
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGraphHeight 300       //Höhe Zeichenfläche
#define kDefaultGraphWidth 900 //Breite Zeichenfläche
#define kStepX 70              //koordinatensystem x-Abstand
#define kStepY 50              //koordinatensystem y-Abstand
#define kOffsetY 10             //verschiebung des in Y-Richung
#define kOffsetX 10              //verschiebung des in X-Richung

@class GraphView;

@protocol GraphViewDataSource
- (float)YValueForXValue:(float)xValue inGraphView:(GraphView *)sender;
- (void)storeScale:(float)scale ForGraphView: (GraphView *)sender;
- (void)storeAxisOriginX:(float)x andAxisOriginY:(float)y ForGraphView: (GraphView *)sender;

@end

@interface GraphView : UIView

@property(nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;
@property(nonatomic) CGFloat scale;
@property(nonatomic) CGPoint axisOrigin;
@property(nonatomic) BOOL drawInDotMode;

- (void)setup:(NSString *)expr;
@end


