//
//  GraphPlotterView.h
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphDrawingView.h"

@interface GraphPlotterView : UIView

@property (weak, nonatomic) IBOutlet GraphDrawingView *graphDrawingView;
@property (weak, nonatomic) IBOutlet UITextField *functionField;

@end
