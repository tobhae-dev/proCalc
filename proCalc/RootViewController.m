//
//  RootViewController.m
//  proCalc
//
//  Created by Tobias Hähnel on 01.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//

#import "RootViewController.h"
#import "SimpleCalculatorView.h"
#import "GraphPlotterView.h"
#import "Calculator.h"

@interface RootViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *calcViews;

@property (nonatomic) BOOL reminderDidShow; // Funktioniert nicht da ViewController anscheinend nicht mehr auf dem Heap

@property (weak, nonatomic) IBOutlet UILabel *inputAndAnswerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *computationDisplay;
@property (nonatomic, getter = isUserTypingDigit) BOOL userIsTypingDigit;
@property (nonatomic) double memoryContent;

- (IBAction)changePage:(id)sender;

@end

@implementation RootViewController

@synthesize calcViews;
@synthesize scrollView;
@synthesize pageControl;


const CGFloat kScrollObjHeight  = 440.0;
const CGFloat kScrollObjWidth   = 320.0;
const NSUInteger kNumImages     = 2;

const CGFloat proCalcBackroundColorRed      = 51.0;
const CGFloat proCalcBackroundColorGreen    = 51.0;
const CGFloat proCalcBackroundColorBlue     = 51.0;
const CGFloat proCalcBackroundColorAlpha    = 1.0;

- (void)viewDidLoad
{
    if (!self.reminderDidShow) {
        [self showSwipeReminder];
    }
    
//    self.view.backgroundColor = [UIColor colorWithRed:proCalcBackroundColorRed green:proCalcBackroundColorGreen blue:proCalcBackroundColorBlue alpha:proCalcBackroundColorAlpha];
    
    calcViews = [[NSMutableArray alloc] init];
    [calcViews addObject: [[SimpleCalculatorView alloc] init]];
    [calcViews addObject: [[GraphPlotterView alloc] init]];
    
    for (NSUInteger i = 0; i < calcViews.count; i++)
    {
        UIView *thisView = [calcViews objectAtIndex:i];
        // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
        CGRect rect = thisView.frame;
        rect.size.height = kScrollObjHeight;
        rect.size.width = kScrollObjWidth;
        thisView.frame = rect;
        thisView.tag = i;  // tag our views for later use when we place them in serial fashion
        [scrollView addSubview:thisView];
    }
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    self.pageControl.numberOfPages = kNumImages;
    self.pageControl.currentPage = 0;
    
    [self layoutScrollImages];  // now place the views in serial layout within the scrollview
}

- (void)showSwipeReminder {
    UIAlertView *swipeAlert = [[UIAlertView alloc] initWithTitle:@"Hinweis" message:@"Wischen Sie nach rechts um zum Plotter zu wechseln." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [swipeAlert show];
    self.reminderDidShow = YES;
}

- (void)layoutScrollImages
{
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
            
            curXLoc += (kScrollObjWidth);
        }
    }
    // set the content size so it can be scrollable
    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [scrollView bounds].size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
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
