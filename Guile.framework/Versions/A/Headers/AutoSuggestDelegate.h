//
//  AutoSuggestDelegate.h
//  Guile
//
//  Created by Adam Kaplan on 1/14/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AutoSuggestTextFieldDelegate <NSObject>

@required

// Return a suggestion to complete the input string.
// For example, if an email is expected, and input is "adam@gma"
// the return value might be "il.com" to provide "adam@gmail.com"
// Return nil for no suggestion.
- (NSString *)suggestedStringForInputString:(NSString *)input;

@optional

// The color to use for suggested text
// Not called if -suggestedTextAttributes is implemented
- (UIColor *)suggestedTextColor;

// Implementing this method will cause suggestedTextColor to not be called.
// The style/layout attributes to apply to the suggested text. The attributes can
// be found in the documentation for NSAttributedString.
- (NSDictionary *)suggestedTextAttributes;

@end
