//
//  DDKTextViewTestCaseViewController.m
//  DDKTextViewTestCase
//
//  Created by User on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DDKTextViewTestCaseViewController.h"
#import "DDKTextViewAlignWidth.h"
#import "WordHyphParser.h"

@implementation DDKTextViewTestCaseViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* testString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"text" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    textView.textColor = [UIColor blackColor];
    textView.text = testString;
    textScroll.contentSize = CGSizeMake(320,textView.frame.size.height);
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)sliderValueChanged:(UISlider*)sender
{
    textView.font = [UIFont systemFontOfSize:sender.value];
    textScroll.contentSize = CGSizeMake(320,textView.frame.size.height);
}

@end
