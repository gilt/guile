//
//  UITextField+AutoSuggestAdditions.h
//  Guile
//
//  Created by Adam Kaplan on 1/14/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Guile/AutoSuggestDelegate.h>

/**
 * This category mixes the -updateSuggestion: into a UITextField instance.
 * It drives the auto-suggest feature by appending the suggested text after
 * the input text.
 *
 * The actual auto-suggest text used is the responsability of the suggestionDelegate.
 * This delegate responds to -suggestedStringForInputString: with the suggested
 * text to use. It can also optionally control how the suggested text is displayed
 * by responding to either -suggestedTextColor or -suggestedTextAttributes.
 *
 * A repsonse to -suggestedTextAttributes takes precidence over -suggestedTextColor.
 * However -suggestedTextColor provides a simple interface to change only the
 * color of the suggested text. This is probably the more commonly used. By default
 * if none of the callbacks are implemented, a light gray text color is used.
 *
 * See: AutoSuggestTextField
 */
@interface UITextField (AutoSuggestAdditions)

- (id<AutoSuggestTextFieldDelegate>) suggestionDelegate;

- (void)updateSuggestion;

- (void)updateSuggestion:(id<AutoSuggestTextFieldDelegate>)aSuggestionDelegate;

// Accepts the suggestion, meaning that the text will no longer be decorated
// differently. Replaces attributes on the attributed suggestion text by with
// the formatting from the character prior to the suggestion.
- (void)acceptSuggestion;

@end
