//
//  BBIconLabel.h
//  BButtonDemo
//
//  Created by Thomas on 08.06.13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Implements a self rescaling UILabel with automatic tag to icon conversion
 */
@interface BBIconLabel : UILabel

+ (void) setIconFontName:(NSString*)fontName; // DO NOT FORGET TO ADD the TTF file to your Info.plist!
+ (void) setPadding:(unsigned int)padding;    // change the default border padding of 4 (reduces font size of icon font)

/** Set automatic translation of label text (when setText is used) to icons.
    This allows setting an icon in InterfaceBuilder with little effort, by just setting the text.
 Example:
 + inizialize //(E.g. App Delegate or any other main class)
 {
    [BBIconLabel setTextToIconMap:[NSDictionary dictionaryWithObjectsAndKeys: FAIconRemove, "#FAIconRemove#", nil]];
 }
 */
+ (void) setTextToIconMap:(NSDictionary*)map;

@end
