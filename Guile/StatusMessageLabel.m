//
//  StatusMessageLabel.m
//  Guile
//
//  Created by Adam Kaplan on 5/9/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import <Guile/StatusMessageLabel.h>

#import <QuartzCore/QuartzCore.h>

@implementation StatusMessageLabel

@dynamic backgroundColor, borderColor, textColor, shadowColor, shadowOffset,
    textAlignment, lineBreakMode, font;

/******************************************************************************/
#pragma mark - UI Appearance
/******************************************************************************/

+ (id)appearance {
    static StatusMessageLabel *proxy;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxy = [[StatusMessageLabel alloc] initWithFrame:CGRectZero];
        proxy.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        proxy.font = [UIFont systemFontOfSize:12.5];
        proxy.textAlignment = NSTextAlignmentCenter;
        proxy.lineBreakMode = NSLineBreakByTruncatingTail;
    });
    return proxy;
}

+ (id)appearanceWhenContainedIn:(Class <UIAppearanceContainer>)ContainerClass, ... NS_REQUIRES_NIL_TERMINATION {
    return [StatusMessageLabel appearance];
}

/******************************************************************************/
#pragma mark - Lifecycle
/******************************************************************************/

- (id)initWithFrame:(CGRect)frame
{
    isInitializing = YES;
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    isInitializing = NO;
    return self;
}

/******************************************************************************/
#pragma mark - Setters
/******************************************************************************/

- (void)setBackgroundColor:(UIColor *)color {
    /*if (!isInitializing)*/ super.backgroundColor = color;
}

- (void)setBorderColor:(UIColor *)color {
    /*if (!isInitializing)*/ [[super layer] setBorderColor:[color CGColor]];
}

- (void)setTextColor:(UIColor *)color {
    /*if (!isInitializing)*/ super.textColor = color;
}

- (void)setShadowColor:(UIColor *)color {
    if (!isInitializing) super.shadowColor = color;
}

- (void)setShadowOffset:(CGSize)offset {
    if (!isInitializing) super.shadowOffset = offset;
}

- (void)setTextAlignment:(NSTextAlignment)alignment {
    if (!isInitializing) super.textAlignment = alignment;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    if (!isInitializing) super.lineBreakMode = lineBreakMode;
}

- (void)setFont:(UIFont *)font {
    if (!isInitializing) super.font = font;
}


@end
