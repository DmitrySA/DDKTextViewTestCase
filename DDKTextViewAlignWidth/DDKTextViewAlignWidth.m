//
//  DDKTextViewAlignWidth.m
//  QUO
//
//  Created by User on 8/12/11.
//  Copyright 2011 RedMadRobot LLC. All rights reserved.
//

#import "DDKTextViewAlignWidth.h"
#import "WordHyphParser.h"

@interface DDKTextViewAlignWidth(Private)
-(void) internalInit;
-(void) realignControls;
-(void) updateWords;
-(void) addLineLabels:(NSArray*)words withFixedSpace:(CGFloat)space startFrom:(CGPoint)point;
@end

@implementation DDKTextViewAlignWidth
@synthesize text, words, font, textColor;

-(void) dealloc
{
    [textColor release];
    [font release];
    [words release];
    [text release];
    [super dealloc];
}

-(void) setText:(NSString *)val
{
    [val retain];
    [text release];
    text = val;
    [self updateWords];
    [self realignControls];
}

-(void) setTextColor:(UIColor *)val
{
    [val retain];
    [textColor release];
    textColor = val;
    
    //change all subvew's textColor property
    for(UILabel* l in self.subviews)
    {
        l.textColor = textColor;
    }
}
-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self realignControls];
}

-(void) setFont:(UIFont *)val
{
    [val retain];
    [font release];
    font = val;
    CGSize sz = [@" " sizeWithFont:font];
    singleSpaceWidth = sz.width;
    [self realignControls];
}

-(void) internalInit
{
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:14.0f];   
    useHyphenation = NO;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self internalInit];
    }
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self internalInit];
    }
    return self;
}
-(id) init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self internalInit];
    }
    return self;
}



-(void) updateWords
{
    
    NSScanner *scanner = [NSScanner scannerWithString:text];
    NSMutableArray* a = [[NSMutableArray alloc] init];
    while(!scanner.isAtEnd)
    {
        NSString* word;
        [scanner scanUpToCharactersFromSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] intoString:&word];
        [a addObject:word];
    }
    self.words = a;
    [a release];
    
}

-(void) addLineLabels:(NSArray*)lineWords withFixedSpace:(CGFloat)space startFrom:(CGPoint)point
{
    CGPoint pt = point;
    for(NSString* word in lineWords)
    {
        CGSize sz = [word sizeWithFont:font];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(pt.x, pt.y, sz.width, sz.height)];
        label.font = font;
        label.opaque = self.opaque;
        label.backgroundColor = self.backgroundColor;
        label.textColor = textColor;
        label.text = word;
        [self addSubview:label];
        [label release];
        
        pt.x += sz.width + singleSpaceWidth + space;
    }
}

-(void) removeAllLabels
{
    for(UIView* v in self.subviews)
        [v removeFromSuperview];
}

-(void) realignControls
{
    if(!text)
        return;
    
    CGFloat wd = self.frame.size.width;
    
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    
    [self removeAllLabels];
    
    CGSize wordSz = CGSizeZero;
    NSMutableArray* line = [[NSMutableArray alloc] init];
    
    for(NSString* word in words)
    {
        wordSz = [word sizeWithFont:font];
        if(currentX + wordSz.width > wd)
        {
            // try Hyphenation
            if(useHyphenation)
            {
                WordHyphParser* hyp = [[WordHyphParser alloc] initWithWord:word];
                NSString* rightPart = nil;
                if([hyp.parts count] > 1)
                {
                    
                    NSUInteger index = 0;
                    for(NSString* stEnd in hyp.variantsLeft)
                    {
                        // has hyphenation parts
                        CGSize endSz = [stEnd sizeWithFont:font];
                        
                        if(currentX + endSz.width <= wd)
                        {
                            currentX+= endSz.width;                
                            [line addObject:stEnd];
                            rightPart = [hyp.variantsRight objectAtIndex:index];
                            break;
                        }
                        ++index;
                    }
                }
                if(rightPart)
                {
                    word = rightPart;
                    wordSz = [word sizeWithFont:font];
                }
                [hyp release];
            }
            // new line here
            // line array contains all row words
            CGFloat fixedSpace = (wd - currentX)/(CGFloat)([line count] - 1);
            //
            [self addLineLabels:line withFixedSpace:fixedSpace startFrom:CGPointMake(0, currentY)];
            [line removeAllObjects];
            
            
            currentX = 0;
            currentY += wordSz.height; 
        }
        [line addObject:word];
        currentX += wordSz.width + singleSpaceWidth; // minimum 1 space between words
    }
    if([line count])
    {
        [self addLineLabels:line withFixedSpace:singleSpaceWidth startFrom:CGPointMake(0, currentY)];
        currentY += wordSz.height; //
    }
    
    [line release];
    CGRect f = self.frame;
    f.size.height = currentY;
    super.frame = f; // why super? cause no recursion
    
}

@end
