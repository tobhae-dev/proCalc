//
//  RootViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "RootViewController.h"
#import "SimpleCalculatorView.h"
#import "ComplexCalculatorView.h"
#import "GraphPlotterView.h"
#import "Calculator.h"

@interface RootViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *calcPortraitViews;
@property (nonatomic, strong) NSMutableArray *calcLandscapeViews;

@property (nonatomic) BOOL swipeWarningShouldShow;

@property (weak, nonatomic) IBOutlet UILabel *inputAndAnswerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *computationDisplay;
@property (nonatomic, getter = isUserTypingDigit) BOOL userIsTypingDigit;
@property (nonatomic) double memoryContent;

- (IBAction)changePage:(id)sender;

@end

@implementation RootViewController

@synthesize calcPortraitViews;
@synthesize calcLandscapeViews;
@synthesize scrollView;
@synthesize pageControl;

const CGFloat kPortraitViewHeight   = 440.0;
const CGFloat kPortraitViewWidth    = 320.0;
const CGFloat kLandscapeViewHeight  = 300.0;
const CGFloat kLandscapeViewWidth   = 460.0;
const NSUInteger kNumberOfPages     = 2;

#define kSwipeWarningKey @"swipeWarning"
#define kVersionKey @"version"

#define degreesToRadians(x) (M_PI * (x) / 180.0)

const CGFloat proCalcBackroundColorRed      = 51.0;
const CGFloat proCalcBackroundColorGreen    = 51.0;
const CGFloat proCalcBackroundColorBlue     = 51.0;
const CGFloat proCalcBackroundColorAlpha    = 1.0;

- (void)viewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.swipeWarningShouldShow = [defaults boolForKey:kSwipeWarningKey];
    if (self.swipeWarningShouldShow) {
        [self showSwipeReminder];
    }
    
    //    self.view.backgroundColor = [UIColor colorWithRed:proCalcBackroundColorRed green:proCalcBackroundColorGreen blue:proCalcBackroundColorBlue alpha:proCalcBackroundColorAlpha];
    
    // Initializing Scrollview
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    // Initializing PageControl
    self.pageControl.numberOfPages = kNumberOfPages;
    self.pageControl.currentPage = 0;
    
    // Initializing correspondig View-Container
    calcPortraitViews = [[NSMutableArray alloc] init];
//    [calcPortraitViews addObject: [[SimpleCalculatorView alloc] init]];
//    [calcPortraitViews addObject: [[GraphPlotterView alloc] init]];
    
    calcLandscapeViews = [[NSMutableArray alloc] init];
    [calcLandscapeViews addObject: [[ComplexCalculatorView alloc] init]];
    [calcLandscapeViews addObject: [[ComplexCalculatorView alloc] init]]; // Durch GraphPlotterLandscapeView ersetzen
    
    // Set the view due to AutoRotation 
    UIApplication *app = [UIApplication sharedApplication];
    UIInterfaceOrientation currentOrientation = app.statusBarOrientation;
    [self doLayoutForOrientation:currentOrientation];
    
    self.scroller.contentSize = CGSizeMake(kDefaultGraphWidth, kGraphHeight);
}

- (void)doLayoutForOrientation:(UIInterfaceOrientation)orientation {
        
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self layoutPortraitScrollImages];  // now place the views in serial layout within the scrollview
    } else {
        [self layoutLandscapeScrollImages];
    }
}

- (void)layoutPortraitScrollImages
{
    NSLog(@"%i", self.scrollView.subviews.count);
    
//    // remove all the subviews from our scrollview
//    for (UIView *view in self.scrollView.subviews)
//    {
//        
//        [view removeFromSuperview];
//    }
    
    NSLog(@"layoutPotrait");
    
    for (NSUInteger i = 0; i < calcPortraitViews.count; i++)
    {
        UIView *thisView = [calcPortraitViews objectAtIndex:i];
        // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
        CGRect rect = thisView.frame;
        rect.size.height = kPortraitViewHeight;
        rect.size.width = kPortraitViewWidth;
        thisView.frame = rect;
        thisView.tag = i;  // tag our views for later use when we place them in serial fashion
        [scrollView addSubview:thisView];
//         NSLog(@"x: %@",thisView);
    }

    UIView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
    // reposition all image subviews in a horizontal serial fashion
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIView class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (kPortraitViewWidth);
        }
    }
    // set the content size so it can be scrollable
    [scrollView setContentSize:CGSizeMake((kNumberOfPages * kPortraitViewWidth), [scrollView bounds].size.height)];
}

- (void)layoutLandscapeScrollImages
{
    

    
    for (NSUInteger i = 0; i < calcLandscapeViews.count; i++)
    {
        UIView *thisView = [calcLandscapeViews objectAtIndex:i];
        // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
        CGRect rect = thisView.frame;
        rect.size.height = kLandscapeViewHeight;
        rect.size.width = kLandscapeViewWidth;
        thisView.frame = rect;
        thisView.tag = i;  // tag our views for later use when we place them in serial fashion
        [scrollView addSubview:thisView];
    }
    
    UIView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
    // reposition all image subviews in a horizontal serial fashion
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIView class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (kLandscapeViewWidth);
        }
    }
    // set the content size so it can be scrollable
    [scrollView setContentSize:CGSizeMake((kNumberOfPages * kLandscapeViewWidth), [scrollView bounds].size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.bounds.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
	// update the scroll view to the appropriate page
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
}

- (IBAction)changePage:(id)sender
{
    [self gotoPage:YES];    // YES = animate
}

- (void)showSwipeReminder {
    UIAlertView *swipeAlert = [[UIAlertView alloc] initWithTitle:@"Hinweis" message:@"Wischen Sie nach rechts um zum Plotter zu wechseln." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [swipeAlert show];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:kSwipeWarningKey];
}

#pragma mark - AutoRotation

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

// NUR FÜR DEN PLOTTER, DER CALCULATOR MACHT VIEW SWAPPING

- (void)willRotationToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation duration:(NSTimeInterval)duration {
  
   [self doLayoutForOrientation:toInterfaceOrientation];
}

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
//interfaceOrientation duration:(NSTimeInterval)duration {
//    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
//        self.view = self.simpleCalculatorViewPortrait;
//        self.view.transform = CGAffineTransformIdentity;
//        self.view.transform =
//        CGAffineTransformMakeRotation(degreesToRadians(0));
//        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
//    }
//    else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//        self.view = self.complexCalculatorViewLandscape;
//        self.view.transform = CGAffineTransformIdentity;
//        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
//        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
//    }
//    else if (interfaceOrientation ==
//             UIInterfaceOrientationLandscapeRight) {
//        self.view = self.complexCalculatorViewLandscape;
//        self.view.transform = CGAffineTransformIdentity;
//        self.view.transform =
//        CGAffineTransformMakeRotation(degreesToRadians(90));
//        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
//    }
//}


#pragma mark - Mathematical ViewController Stubs

- (IBAction)memoryFunctionPressed:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"MC"]) {
        // Memory Clear
        self.memoryContent = 0.0;
        
    }
    if ([sender.currentTitle isEqualToString:@"M+"]) {
        // Memory "plus" inputAndAnswerDisplay
        self.memoryContent += [self.inputAndAnswerDisplay.text doubleValue];
        
    }
    if ([sender.currentTitle isEqualToString:@"M-"]) {
        // Memory "minus" inputAndAnswerDisplay
        self.memoryContent -= [self.inputAndAnswerDisplay.text doubleValue];
    }
    if ([sender.currentTitle isEqualToString:@"MR"]) {
        // Memory Recall -> Show on inputAndAnswerDisplay
        self.inputAndAnswerDisplay.text = [NSString stringWithFormat:@"%f", self.memoryContent];
    }
}


- (IBAction)clearTheDisplay:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"C"]) {
        self.inputAndAnswerDisplay.text = @"0";
    } else if ([sender.currentTitle isEqualToString:@"AC"]) {
        self.inputAndAnswerDisplay.text = @"0";
        self.computationDisplay.text = @"";
    }
}

- (IBAction)specialFunctionPressed:(UIButton *)sender
{
    self.userIsTypingDigit = NO;
    
    if ([sender.currentTitle isEqualToString:@"√x"]) {
        self.inputAndAnswerDisplay.text = [Calculator squareRoot:self.inputAndAnswerDisplay.text];
    }
    if ([sender.currentTitle isEqualToString:@"x²"]) {
        self.inputAndAnswerDisplay.text = [Calculator squared:self.inputAndAnswerDisplay.text];
    }
    if ([sender.currentTitle isEqualToString:@"log"]) {
        self.inputAndAnswerDisplay.text = [Calculator logarithm:self.inputAndAnswerDisplay.text];
    }
    if ([sender.currentTitle isEqualToString:@"÷"]) {
        self.inputAndAnswerDisplay.text = [Calculator percentage:self.inputAndAnswerDisplay.text];
    }
}

- (IBAction)addExpressionToComputationDisplay:(UIButton *)sender
{
    self.userIsTypingDigit = NO;
    self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:self.inputAndAnswerDisplay.text];
    self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:[sender currentTitle]];
    
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    if (!self.isUserTypingDigit) {
        self.inputAndAnswerDisplay.text = @"";
        self.userIsTypingDigit = YES;
    }
    self.inputAndAnswerDisplay.text = [self.inputAndAnswerDisplay.text stringByAppendingString:[sender currentTitle]];
}

- (IBAction)solveExpression {
    
    // Weiterleitung zur Parser-Implementierung
    //    eval(self.computationDisplay.text);
    
    //
    //    } else if ([self.waitingOperation isEqualToString:@"÷"]) {
    //        if (operant != 0.0) {
    //            operant = self.waitingOperant / operant;
    //        } else {
    //            NSLog(@"Fehler: Division durch Null!");
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Division durch Null!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //            [alert show];
    //            return @"Fehler";
    //        }
}

- (IBAction)period
{
    // In a floating point Number, one Comma only is allowed. Therefor, we have to check the input.
    
    if ([self.inputAndAnswerDisplay.text rangeOfString:@"."].location == NSNotFound) {
        self.inputAndAnswerDisplay.text = [self.inputAndAnswerDisplay.text stringByAppendingString:@"."];
        self.computationDisplay.text = [self.computationDisplay.text stringByAppendingString:@"."];
    }
}

- (IBAction)reverseSign {
    double tmp = [self.inputAndAnswerDisplay.text doubleValue] * (-1);
    self.inputAndAnswerDisplay.text = [NSString stringWithFormat:@"%f",tmp];
    
    // Umwandeln in Zahl und dann als -Zahl im Display ausgeben?!
}

@end
