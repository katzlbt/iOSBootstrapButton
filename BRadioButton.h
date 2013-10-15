//
//  BRadioButton.h
//  BButtonDemo
//
//  Created by Thomas on 15/10/2013.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "BButton.h"

@interface BRadioButton : BButton
{
    IBOutlet BRadioButton* toNextRadioButton;
            // if connected to another button the button behaves as radio-button (the connections should form a circle - last connected to first!). Control-single click (do not drag) to make connections when using autolayout.
}

@property (strong, nonatomic) UIColor* selectedColor;
@property (strong, nonatomic) UIColor* unselectedColor;

@end
