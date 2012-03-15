//
//  DDKTextViewAlignWidth.h
//  QUO
//
//  Created by User on 8/12/11.
//  Copyright 2011 RedMadRobot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDKTextViewAlignWidth : UIControl
{
@private
    NSString* text;
    NSMutableArray* words;
    UIFont* font;
    UIColor* textColor;
    CGFloat singleSpaceWidth;
    BOOL useHyphenation;
}

@property (nonatomic, retain) UIColor* textColor;
@property (nonatomic, retain) NSString* text;
@property (nonatomic, retain) NSMutableArray* words;
@property (nonatomic, retain) UIFont* font;
@end
