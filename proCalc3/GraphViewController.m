//
//  GraphViewController.m
//  proCalc3
//
//  Created by Tobias Hähnel on 26.07.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "GraphViewController.h"
#import "Parser.h"
#import "GraphView.h"

@interface GraphViewController () <GraphViewDataSource>

@property (nonatomic, weak) IBOutlet GraphView *graphView;
@end

@implementation GraphViewController

@synthesize graphView = _graphView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (IBAction)funktionZeichnen:(id)sender {

    self.gleichungsText.text=[self.gleichungsText.text stringByReplacingOccurrencesOfString:@"X" withString:@"x"];
    [_graphView setup:self.gleichungsText.text];
    [_graphView setNeedsDisplay];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}


- (void)refreshProgramDependancies {
	
	// Need a program to recall scale and axis origin
	if (! self.program) return;
	
	// Need a graph view to set initial scale and axis origin
	if (! self.graphView) return;
	
	NSString *program = _gleichungsText.text;
	
	// Retrieve the scale from storage
	float scale = [[NSUserDefaults standardUserDefaults]
                   floatForKey:[@"scale." stringByAppendingString:program]];
	
	// Retrieve the x axis origin from storage
	float xAxisOrigin = [[NSUserDefaults standardUserDefaults]
                         floatForKey:[@"x." stringByAppendingString:program]];
	
	// Retrieve the y axis origin from storage
	float yAxisOrigin = [[NSUserDefaults standardUserDefaults]
                         floatForKey:[@"y." stringByAppendingString:program]];
	
	// If we have scale in storage, then set this as the scale for the graph view
	if (scale) self.graphView.scale = scale;
	
	// If we have a value for the xAxisOrigin and yAxisOrigin then set it in the graph view
	if (xAxisOrigin && yAxisOrigin) {
		
		CGPoint axisOrigin;
		
		axisOrigin.x = xAxisOrigin;
		axisOrigin.y = yAxisOrigin;
		
		self.graphView.axisOrigin = axisOrigin;
	}
	
	// Refresh the graph View
	[self.graphView setNeedsDisplay];	
}

- (void) setGraphView:(GraphView *)graphView {
	_graphView = graphView;
	self.graphView.dataSource = self;
	
	// enable pinch gesture in the GraphView using pinch: handler
	[self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                          initWithTarget:self.graphView
                                          action:@selector(pinch:)]];
	
	// enable pan gesture in the GraphView using pan: handler
	[self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                          initWithTarget:self.graphView
                                          action:@selector(pan:)]];
	
	// enable triple tap gesture in the GraphView using tripleTap: handler
	UITapGestureRecognizer *tapGestureRecognizer =
	[[UITapGestureRecognizer alloc] initWithTarget:self.graphView
                                            action:@selector(tripleTap:)];
	tapGestureRecognizer.numberOfTapsRequired = 3;
	[self.graphView addGestureRecognizer:tapGestureRecognizer];
	
	// We want to update the graphView to set the starting values for the program. In iPad mode
	// this method is called before a program is set, in which case we don't want to do anything
	[self refreshProgramDependancies];
}

- (IBAction)drawModeSwitched:(id)sender {
	self.graphView.drawInDotMode = [(UISwitch *)sender isOn];
	[self.graphView setNeedsDisplay];
}

- (void)storeScale:(float)scale ForGraphView:(GraphView *)sender {
	
	// Store the scale in user defaults
	[[NSUserDefaults standardUserDefaults]
	 setFloat:scale forKey:[@"scale." stringByAppendingString:
                            _gleichungsText.text]];
	
	// Save the scale
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)storeAxisOriginX:(float)x andAxisOriginY:(float)y ForGraphView:(GraphView *)sender {
	
	
	NSString *program = _gleichungsText.text;
	
	// Store the x axis origin in user defaults
	[[NSUserDefaults standardUserDefaults] setFloat:x
                                             forKey:[@"x." stringByAppendingString:program]];
	
	// Store the y axis origin in user defaults
	[[NSUserDefaults standardUserDefaults] setFloat:y
                                             forKey:[@"y." stringByAppendingString:program]];
	
	// Save the axis origin
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}

- (float)YValueForXValue:(float)xValue inGraphView:(GraphView *)sender {
	
	// Find the corresponding Y value by passing the x value to the calculator Brain
    
    
//	id yValue = [CalculatorBrain runProgram:self.program usingVariableValues:
//                 [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:xValue]
//                                             forKey:@"x"]];
	
//	return ((NSNumber *)yValue).floatValue;
    
    return 0;
}



//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//}



@end
