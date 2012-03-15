//
//  DDKTextViewTestCaseViewController.h
//  DDKTextViewTestCase
//
//  Created by User on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDKTextViewAlignWidth;
@interface DDKTextViewTestCaseViewController : UIViewController
{
@private
    IBOutlet UIScrollView* textScroll;
    IBOutlet UISlider* fontSizeSlider;
    IBOutlet DDKTextViewAlignWidth* textView;
}
@end
