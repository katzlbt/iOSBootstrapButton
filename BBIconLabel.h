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

+ (void) setIconFontName:(NSString*)fontName; // ADD the TTF file to your Info.plist!
+ (void) setPadding:(unsigned int)padding;    // change the default border padding of 4 (reduces font size of icon font)

/** Set automatic translation of label text to icons.
 Example:
 + inizialize //(E.g. App Delegate or any other main class)
 {
    [BBIconLabel setTextToIconMap:[NSDictionary dictionaryWithObjectsAndKeys: FAIconRemove, "#IL1", nil]];
 }
 */
+ (void) setTextToIconMap:(NSDictionary*)map;

@end
