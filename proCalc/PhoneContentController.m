//
//  PhoneContentController.m
//  proCalc
//
//  Created by Tobias Hähnel on 24.06.13.
//  Copyright (c) 2013 jonatobi. All rights reserved.
//


#import "AppDelegate.h"
#import "RootViewController.h"
#import "PhoneContentController.h"

@interface PhoneContentController ()

@end

@implementation PhoneContentController

- (void)awakeFromNib
{
	// load our data from a plist file inside our app bundle
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"content_iPhone" ofType:@"plist"];
//    self.contentList = [NSArray arrayWithContentsOfFile:path];
//    self.rootViewController.contentList = self.contentList;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = (UIViewController *)self.rootViewController;
}


@end
