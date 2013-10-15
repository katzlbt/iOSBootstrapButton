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

#if ! __has_feature(objc_arc)
#warning This file must be compiled with automatic reference counting or it will crash your App. Use -fobjc-arc flag on the single file (or convert your project to ARC).
#endif

@implementation BRadioButton

- (void)awakeFromNib
{
    if(self.selectedColor == nil) // use key value coding in storyboard to set this color!
        self.selectedColor = [UIColor darkGrayColor];
}

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
    
    if(selected && self.selectedColor)
    {
        self.unselectedColor = self.color;
        self.color = self.selectedColor;
    }
    else
    {
        if(self.unselectedColor)
            self.color = self.unselectedColor;
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
