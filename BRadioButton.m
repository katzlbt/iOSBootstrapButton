//
//  BRadioButton.m
//  BButtonDemo
//
//  Created by Thomas on 15/10/2013.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
/** 
 This is an attempt to replace Segmented Control with some buttons.
 Buttons MUST be connected to an action so setSelected is called.
 @TODO iOS7 TintColor still interferes with drawing style. 
 
 - (IBAction) radioClicked:sender;
 {
    NSLog(@"BRadioButton %i pressed!",[sender tag]); // assign tag in storyboard
 }
 */

#import "BRadioButton.h"

@implementation BRadioButton

- (void)setSelected:(BOOL)selected // deselect other buttons
{
    if(toNextRadioButton)
    {
        // loop through buttons until we find self again
        BRadioButton* next = toNextRadioButton;
        while(next && next != self)
        {
            if([next isSelected])
                [next setSelected:NO];
            next = next->toNextRadioButton;
        }
    }
    
    [super setSelected:selected];
    [super setHighlighted:selected];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [super sendAction:action to:target forEvent:event];
    [self setSelected:YES];
}

@end
