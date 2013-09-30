//
//  BButton.m
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

#import "BButton.h"
#import <CoreGraphics/CoreGraphics.h>

#if ! __has_feature(objc_arc)
#warning This file must be compiled with automatic reference counting or it will crash your App. Use -fobjc-arc flag on the single file (or convert your project to ARC).
#endif

//NSString* BButton_iconFontName = @"icomoon";
NSString* BButton_iconFontName = @"FontAwesome";
NSString* BButton_spaceBeforeIcon = @" ";
NSString* BButton_spaceAfterIcon = @" ";

NSDictionary* BButton_textToIconsMap = nil;

@interface BButton ()

@property (assign, nonatomic) CGGradientRef gradient;

- (void)setup;
+ (UIColor *)colorForButtonType:(BButtonType)type;
- (void)setGradientEnabled:(BOOL)enabled;

@end

@implementation BButton

@synthesize color;
@synthesize gradient;
@synthesize shouldShowDisabled;

UIColor* BButton_ColorPrimary = nil;
UIColor* BButton_ColorDefault = nil;
UIColor* BButton_ColorWarning = nil;
UIColor* BButton_ColorInfo = nil;
UIColor* BButton_ColorSuccess = nil;
UIColor* BButton_ColorDanger = nil;

+ (UIColor*)colorPrimary;
{
    if(BButton_ColorPrimary == nil)
        BButton_ColorPrimary = [UIColor colorWithRed:0.00f green:0.33f blue:0.80f alpha:1.00f];
    
    return BButton_ColorPrimary;
}

+ (UIColor*)colorDefault;
{
    if(BButton_ColorDefault == nil)
        BButton_ColorDefault = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
    
    return BButton_ColorDefault;
}

+ (UIColor*)colorWarning;
{
    if(BButton_ColorWarning == nil)
        BButton_ColorWarning = [UIColor colorWithRed:0.97f green:0.58f blue:0.02f alpha:1.00f];
    
    return BButton_ColorWarning;
}

+ (UIColor*)colorInfo;
{
    if(BButton_ColorInfo == nil)
        BButton_ColorInfo = [UIColor colorWithRed:0.18f green:0.59f blue:0.71f alpha:1.00f];
    
    return BButton_ColorInfo;
}

+ (UIColor*)colorSuccess;
{
    if(BButton_ColorSuccess == nil)
        BButton_ColorSuccess = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f];
    
    return BButton_ColorSuccess;
}
+ (UIColor*)colorDanger;
{
    if(BButton_ColorDanger == nil)
        BButton_ColorDanger = [UIColor colorWithRed:0.74f green:0.21f blue:0.18f alpha:1.00f];
    
    return BButton_ColorDanger;
}

+ (void) setTextToIconMap:(NSDictionary*)map
{
    BButton_textToIconsMap = map;
}

+ (void) setIconFontName:(NSString*)fontName // changes the icon font for BButton globally
{
    BButton_iconFontName = fontName;
}

+ (void) setSpacerStringBeforeIcon:(NSString*)before andAfterIcon:(NSString*)after // ADD the TTF file to your Info.plist!
{
    BButton_spaceBeforeIcon = before;
    BButton_spaceAfterIcon = after;
}

#pragma mark - Initialization
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [self setType:BButtonTypeDefault];
    self.shouldShowDisabled = NO;
}

- (id)initWithFrame:(CGRect)frame type:(BButtonType)type
{
    return [self initWithFrame:frame color:[BButton colorForButtonType:type]];
}

- (id)initWithFrame:(CGRect)frame type:(BButtonType)type icon:(NSString *)iconString fontSize:(CGFloat)fontSize
{
    return [self initWithFrame:frame
                         color:[BButton colorForButtonType:type]
                          icon:iconString
                      fontSize:fontSize];
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)aColor
{
    self = [self initWithFrame:frame];
    if(self) {
        self.color = aColor;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)aColor icon:(NSString *)iconString fontSize:(CGFloat)fontSize
{
    self = [self initWithFrame:frame color:aColor];
    if(self) {
        UIFont* f = [UIFont fontWithName:BButton_iconFontName size:fontSize];
        
#ifdef DEBUG
        if (f == nil) {
            NSLog(@"BButton Font '%@' not found! Check if font is in Info.plist.",BButton_iconFontName);
        }
#endif
        
        self.titleLabel.font = f;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:iconString forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

+ (BButton *)buttonWithOnlyIcon:(NSString *)iconString type:(BButtonType)type
{
    return [BButton buttonWithOnlyIcon:iconString
                                        color:[BButton colorForButtonType:type]];
}

+ (BButton *)buttonWithOnlyIcon:(NSString *)iconString color:(UIColor *)color
{
    return [[BButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)
                                    color:color
                                     icon:iconString
                                 fontSize:20.0f];
}

#pragma mark - Parent overrides
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(self.shouldShowDisabled)
        [self setGradientEnabled:enabled];
    
    [self setNeedsDisplay];
}

#pragma mark - Setters
- (void)setColor:(UIColor *)newColor
{
    color = newColor;
    
    if([[self class] isLightColor:newColor]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6f] forState:UIControlStateNormal];
        
        if(self.shouldShowDisabled)
            [self setTitleColor:[UIColor colorWithWhite:0.4f alpha:0.5f] forState:UIControlStateDisabled];
    }
    else {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.6f] forState:UIControlStateNormal];
        
        if(self.shouldShowDisabled)
            [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    
    if(self.shouldShowDisabled)
        [self setGradientEnabled:self.enabled];
    else
        [self setGradientEnabled:YES];
    
    [self setNeedsDisplay];
}

- (void)setShouldShowDisabled:(BOOL)show
{
    shouldShowDisabled = show;
    
    if(show) {
        if([[self class] isLightColor:self.color])
            [self setTitleColor:[UIColor colorWithWhite:0.4f alpha:0.5f] forState:UIControlStateDisabled];
        else
            [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    else {
        if([[self class] isLightColor:self.color])
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        else
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    }
}

#pragma mark - BButton
- (void)setType:(BButtonType)type
{
    self.color = [BButton colorForButtonType:type];
}

- (void)addIcon:(NSString *)iconString beforeTitle:(BOOL)before
{
    UIFont* f = [UIFont fontWithName:BButton_iconFontName
                                size:self.titleLabel.font.pointSize];
    self.titleLabel.font = f;
    
#ifdef DEBUG
    if (f == nil) {
        NSLog(@"BButton Font '%@' not found! Check if font is in Info.plist.",BButton_iconFontName);
    }
#endif
    
    if(before)
        [self setTitle:[NSString stringWithFormat:@"%@%@%@", iconString, BButton_spaceAfterIcon, self.titleLabel.text] forState:UIControlStateNormal];
    else
        [self setTitle:[NSString stringWithFormat:@"%@%@%@", self.titleLabel.text, BButton_spaceBeforeIcon, iconString] forState:UIControlStateNormal];;
}

+ (UIColor *)colorForButtonType:(BButtonType)type
{    
    switch (type) {
        case BButtonTypePrimary:
            return [BButton colorPrimary];
        case BButtonTypeInfo:
            return [BButton colorInfo];
        case BButtonTypeSuccess:
            return [BButton colorSuccess];
        case BButtonTypeWarning:
            return [BButton colorWarning];
        case BButtonTypeDanger:
            return [BButton colorDanger];
        case BButtonTypeInverse:
            return [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f];
        case BButtonTypeTwitter:
            return [UIColor colorWithRed:0.25f green:0.60f blue:1.00f alpha:1.00f];
        case BButtonTypeFacebook:
            return [UIColor colorWithRed:0.23f green:0.35f blue:0.60f alpha:1.00f];
        case BButtonTypePurple:
            return [UIColor colorWithRed:0.45f green:0.30f blue:0.75f alpha:1.00f];
        case BButtonTypeGray:
            return [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
        case BButtonTypeOrange:
            return [UIColor colorWithRed:1.0f green:0.388235294f blue:0.08627451f alpha:1.00f];
        case BButtonTypeDefault:
        default:
            return [BButton colorDefault];
    }    
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();

#ifdef DEBUG
    if(self.frame.size.height < 30)
    {
        NSLog(@"Warning button height must be set by constraint. Default height of AppleUIButton (44px) does not work. It is not transfered from InterfaceBuilder to the App, one px higher or lower works fine.");
    }
#endif
    
    UIColor *border = [[self class] darkenColor:self.color withValue:0.06f];
    
    // Shadow Declarations
    UIColor *shadow = [[self class]  lightenColor:self.color withValue:0.50f];
    CGSize shadowOffset = CGSizeMake(0.0f, 1.0f);
    CGFloat shadowBlurRadius = 2.0f;
    
    // Rounded Rectangle Drawing
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5f, 0.5f, rect.size.width-1.0f, rect.size.height-1.0f)
                                                                    cornerRadius:6.0f];
    
    CGContextSaveGState(context);
    
    [roundedRectanglePath addClip];
    
    CGContextDrawLinearGradient(context,
                                self.gradient,
                                CGPointMake(0.0f, self.highlighted ? rect.size.height - 0.5f : 0.5f),
                                CGPointMake(0.0f, self.highlighted ? 0.5f : rect.size.height - 0.5f), 0.0f);
    
    CGContextRestoreGState(context);
    
    if(!self.highlighted) {
        // Rounded Rectangle Inner Shadow
        CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
        roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
        roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1.0f, -1.0f);
        
        UIBezierPath *roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
        [roundedRectangleNegativePath appendPath: roundedRectanglePath];
        roundedRectangleNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
            CGFloat yOffset = shadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1f, xOffset), yOffset + copysign(0.1f, yOffset)),
                                        shadowBlurRadius,
                                        shadow.CGColor);
            
            [roundedRectanglePath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0.0f);
            [roundedRectangleNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [roundedRectangleNegativePath fill];
        }
        CGContextRestoreGState(context);
    }
    
    [border setStroke];
    roundedRectanglePath.lineWidth = 1.0f;
    [roundedRectanglePath stroke];
}

- (void)setGradientEnabled:(BOOL)enabled
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *topColor = enabled ? [[self class] lightenColor:self.color withValue:0.12f] : [[self class]  darkenColor:self.color withValue:0.12f];
    
    NSArray *newGradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)self.color.CGColor, nil];
    CGFloat newGradientLocations[] = {0.0f, 1.0f};
    
    gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)newGradientColors, newGradientLocations);
    CGColorSpaceRelease(colorSpace);
}

+ (UIColor *)lightenColor:(UIColor*)c withValue:(CGFloat)value
{
    int totalComponents = CGColorGetNumberOfComponents(c.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(c.CGColor);
    CGFloat newComponents[4];
    
    if(isGreyscale) {
        newComponents[0] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[1] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[2] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[3] = oldComponents[1];
    }
    else {
        newComponents[0] = oldComponents[0] + value > 1.0 ? 1.0 : oldComponents[0] + value;
        newComponents[1] = oldComponents[1] + value > 1.0 ? 1.0 : oldComponents[1] + value;
        newComponents[2] = oldComponents[2] + value > 1.0 ? 1.0 : oldComponents[2] + value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

+ (UIColor *)darkenColor:(UIColor*)c withValue:(CGFloat)value
{
    int totalComponents = CGColorGetNumberOfComponents(c.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *oldComponents = (CGFloat *)CGColorGetComponents(c.CGColor);
    CGFloat newComponents[4];
    
    if(isGreyscale) {
        newComponents[0] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[1] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[2] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[3] = oldComponents[1];
    }
    else {
        newComponents[0] = oldComponents[0] - value < 0.0 ? 0.0 : oldComponents[0] - value;
        newComponents[1] = oldComponents[1] - value < 0.0 ? 0.0 : oldComponents[1] - value;
        newComponents[2] = oldComponents[2] - value < 0.0 ? 0.0 : oldComponents[2] - value;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	//CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	//CGColorRelease(newColor);
    
    return retColor;
}

+ (BOOL)isLightColor:(UIColor*)c
{
    int totalComponents = CGColorGetNumberOfComponents(c.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat *components = (CGFloat *)CGColorGetComponents(c.CGColor);
    CGFloat sum;
    
    if(isGreyscale) {
        sum = components[0];
    }
    else {
        sum = (components[0] + components[1] + components[2]) / 3.0f;
    }
    
    return (sum > 0.8f);
}

@end

#ifdef DEBUG
void BButton_listFonts() // Add yourfont.ttf to application-info.plist with key "Fonts provided by application" then check with this function if it is included
{
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@", fontName);
        }
    }
};
#endif
