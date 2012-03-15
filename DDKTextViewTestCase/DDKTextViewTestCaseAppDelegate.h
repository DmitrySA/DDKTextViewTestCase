//
//  DDKTextViewTestCaseAppDelegate.h
//  DDKTextViewTestCase
//
//  Created by User on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDKTextViewTestCaseViewController;

@interface DDKTextViewTestCaseAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DDKTextViewTestCaseViewController *viewController;

@end
