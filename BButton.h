//
//  BButton.h
//
//  Created by Mathieu Bolard on 31/07/12.
//  Copyright (c) 2012 Mathieu Bolard. All rights reserved.
//
//  https://github.com/mattlawer/BButton
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice,
//  this list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
// * Neither the name of Mathieu Bolard, mattlawer nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
//  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL Mathieu Bolard BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
//  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  -----------------------------------------
//  Edited and refactored by Jesse Squires on 2 April, 2013.
//
//  http://github.com/jessesquires/BButton
//
//  http://hexedbits.com
//

#import <UIKit/UIKit.h>

typedef enum {
    BButtonTypeDefault = 1,
    BButtonTypePrimary,
    BButtonTypeInfo,
    BButtonTypeSuccess,
    BButtonTypeWarning,
    BButtonTypeDanger,
    BButtonTypeInverse,
    BButtonTypeTwitter,
    BButtonTypeFacebook,
    BButtonTypePurple,
    BButtonTypeGray,
    BButtonTypeOrange
} BButtonType;

/**
 Assign those to redefine return value of the BButton color class methods.
 Will be nil until first used by class method.
 */
extern UIColor* BButton_ColorPrimary;
extern UIColor* BButton_ColorDefault;
extern UIColor* BButton_ColorWarning;
extern UIColor* BButton_ColorInfo;
extern UIColor* BButton_ColorSuccess;
extern UIColor* BButton_ColorDanger;

/*
 1 - Add .TTF font in your application
 2 - Modify the application-info.plist file.
 3 - Add the key "Fonts provided by application" to a new row
 4 - and add each .TTF file (of font) to each line.

 Assumptions: You use only one icon font.
  [BButton setIconFontName:@"icomoon"];
 
 This class is still a hack as it does not draw the icon separately of the title text.
 The iconfont's space may interfere also with spaces in the text (use quarterspaces etc to get pretty results).
 Setting the title will replace the icon, icon and title font are related (no bold!) etc. 
 Probably we can live with that. Probably we should fix it to draw in a square area.
 
 If you want to customize further (icon+text+icon, etc.) try the raw set title method via UIControl:
 - setTitle:
    self.titleLabel.font = yourFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitle:titleOrIconOrBoth forState:UIControlStateNormal];
*/

#ifdef DEBUG
void BButton_listFonts(void); // Add yourfont.ttf to application-info.plist with key "Fonts provided by application"
#endif

@interface BButton : UIButton

@property (strong, nonatomic) UIColor *color; // can be set in InterfaceBuilder as User defined Attribute color of Type UIColor
@property (assign, nonatomic) BOOL shouldShowDisabled;
// TODO ... @property (strong, nonatomic) NSString* iconString;

+ (void) setIconFontName:(NSString*)fontName; // ADD the TTF file to your Info.plist!
+ (void) setSpacerStringBeforeIcon:(NSString*)before andAfterIcon:(NSString*)after;
    // <<< This method adjusts the space between icon and title, I recommend using either icon OR text.
    // this is the "thin-space" fix for an incompatible very wide whitespace %20 char in icomoon.
    // [BButton setSpacerStringBeforeIcon:@"\u2004\u2004" andAfterIcon:@"\u2009"]; // try also \u2003, \u2004, ... \u2009

/** Set automatic translation of label text (as set in InterfaceBuilder) to icons.
 Example:
 + inizialize //(E.g. App Delegate or any other main class)
 {
 [BButton setTextToIconMap:[NSDictionary dictionaryWithObjectsAndKeys: FAIconRemove, "#FAIconRemove#", nil]];
 }
 */
+ (void) setTextToIconMap:(NSDictionary*)map;

- (id)initWithFrame:(CGRect)frame;

- (void)setType:(BButtonType)type;
- (void)setTitle:(NSString*)titleOrIcon withFontSize:(CGFloat)fontSize;
- (void)addIcon:(NSString *)iconString beforeTitle:(BOOL)before;
  // ===> [self setTitle:[NSString stringWithFormat:@"%@%@%@", iconString, BButton_spaceAfterIcon, self.titleLabel.text]

+ (UIColor*)colorPrimary;
+ (UIColor*)colorDefault;
+ (UIColor*)colorWarning;
+ (UIColor*)colorInfo;
+ (UIColor*)colorSuccess;
+ (UIColor*)colorDanger;

@end

