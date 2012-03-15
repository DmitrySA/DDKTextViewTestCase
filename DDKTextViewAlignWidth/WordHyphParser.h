//
//  WordHyphParser.h
//  DDKTextViewTestCase
//
//  Created by User on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordHyphParser : NSObject
{
@private
    NSArray* parts;
    NSArray* variantsLeft;
    NSArray* variantsRight;
}

@property (nonatomic, retain) NSArray* parts;
@property (nonatomic, retain) NSArray* variantsLeft;
@property (nonatomic, retain) NSArray* variantsRight;

-(id) initWithWord:(NSString*)word;

@end
