//
//  BBIconLabel.m
//  BButtonDemo
//
//  Created by Thomas on 08.06.13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "BBIconLabel.h"

//NSString* BButton_iconFontName = @"icomoon";
NSString* BBIconLabel_iconFontName = @"FontAwesome";
NSDictionary* BBIconLabel_textToIconsMap = nil;
unsigned int BBIconLabel_padding = 4;

@implementation BBIconLabel

+ (void) setTextToIconMap:(NSDictionary*)map // translation of setText text to icon
{
    BBIconLabel_textToIconsMap = map;    
}

+ (void) setIconFontName:(NSString*)fontName // changes the icon font for BButton globally
{
    BBIconLabel_iconFontName = fontName;
}

+ (void) setPadding:(unsigned int)padding    // change the default border padding of 4!
{
    BBIconLabel_padding = padding;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setText:self.text];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self adjustFont];
}

- (void) adjustFont // resize every time the label changes itself
{
    int h = self.frame.size.height - BBIconLabel_padding;
    if (self.frame.size.height < 0) // frame is not ready in -awakeFromNib
        h = self.font.pointSize;
    
    UIFont* f = [UIFont fontWithName:BBIconLabel_iconFontName size:h];
    
#ifdef DEBUG
    if (f == nil)
    {
        NSLog(@"BButton Font '%@' not found! Check if font is in Info.plist.",BBIconLabel_iconFontName);
    }
#endif
    
    self.font = f;
}

- (void)setText:(NSString *)text
{
    if(BBIconLabel_textToIconsMap)
    {
        NSString* s = [BBIconLabel_textToIconsMap objectForKey:text];
        if(s != nil)
        {
            [super setText:s];
            [self adjustFont];
            return;
        }
    }
    
    [super setText:text];
}

@end
