//
//  GraphView.h
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>


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


