//
//  WordHyphParser.m
//  DDKTextViewTestCase
//
//  Created by User on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WordHyphParser.h"

@implementation WordHyphParser
@synthesize parts, variantsLeft, variantsRight;

- (id)initWithWord:(NSString *)word
{
    self = [super init];
    if (self) 
    {
        NSString* RusA = @"[абвгдеёжзийклмнопрстуфхцчшщъыьэюя]";
        NSString* RusV = @"[аеёиоуыэюя]";
        NSString* RusN = @"[бвгджзклмнпрстфхцчшщ]";
        NSString* RusX = @"[йъь]";
        
        NSRegularExpression* re1 = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@)(%@%@)",RusX, RusA, RusA] options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression* re2 = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@)(%@%@)",RusV, RusV, RusA] options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression* re3 = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@%@)(%@%@)",RusV, RusN, RusN, RusV] options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression* re4 = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@%@)(%@%@)",RusN, RusV, RusN, RusV] options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression* re5 = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@%@)(%@%@%@)",RusV, RusN, RusN, RusN, RusV] options:NSRegularExpressionCaseInsensitive error:nil];
        NSRegularExpression* re6 = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(%@%@%@)(%@%@%@)",RusV, RusN, RusN, RusN, RusN, RusV] options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSString* result = [re1 stringByReplacingMatchesInString:word options:NSMatchingProgress range:NSMakeRange(0, word.length) withTemplate:@"$1 $2"];
        NSString* result1 = [re2 stringByReplacingMatchesInString:result options:NSMatchingProgress range:NSMakeRange(0, result.length) withTemplate:@"$1 $2"];
        NSString* result2 = [re3 stringByReplacingMatchesInString:result1 options:NSMatchingProgress range:NSMakeRange(0, result1.length) withTemplate:@"$1 $2"];
        NSString* result3 = [re4 stringByReplacingMatchesInString:result2 options:NSMatchingProgress range:NSMakeRange(0, result2.length) withTemplate:@"$1 $2"];
        NSString* result4 = [re5 stringByReplacingMatchesInString:result3 options:NSMatchingProgress range:NSMakeRange(0, result3.length) withTemplate:@"$1 $2"];
        NSString* result5 = [re6 stringByReplacingMatchesInString:result4 options:NSMatchingProgress range:NSMakeRange(0, result4.length) withTemplate:@"$1 $2"];
             
        NSMutableArray* a = [[NSMutableArray alloc] init];
        NSMutableArray* vl = [[NSMutableArray alloc] init];
        NSMutableArray* vr = [[NSMutableArray alloc] init];
        
        NSScanner* scanner = [NSScanner scannerWithString:result5];
        NSMutableString* lefts = [[NSMutableString alloc] init];
        while(!scanner.isAtEnd)
        {
            NSString* part;
            [scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&part];
            [lefts appendString:part];
            [vl insertObject:[NSString stringWithFormat:@"%@-",lefts] atIndex:0];
            [vr insertObject:[word stringByReplacingOccurrencesOfString:lefts withString:@""] atIndex:0];
            [a addObject:part];
        }
        // bad idea, but simple
        [vl removeObjectAtIndex:0];
        [vr removeObjectAtIndex:0];
        self.parts = a;
        self.variantsLeft = vl;
        self.variantsRight = vr;
        [vl release];
        [vr release];
        [a release];
    }
    
    return self;
}

-(void) dealloc
{
    [variantsRight release];
    [variantsLeft release];
    [parts release];
    [super dealloc];
}

@end
