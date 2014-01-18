//
//  UITextField+AutoSuggestAdditions.m
//  Guile
//
//  Created by Adam Kaplan on 1/14/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import <Guile/UITextField+AutoSuggestAdditions.h>

static UIColor *DefaultSuggestedTextColor;

static NSString *SuggestedTextMarkerAttributeName = @"SuggestedTextMarkerAttribute";

static NSString *SuggestedTextMarkerAttributeValue = @"SuggestedTextMarker";

#define RANGE_NOT_FOUND NSMakeRange(NSNotFound, 0)

@implementation UITextField (AutoSuggestAdditions)

// Override point for subclasses.
- (id<AutoSuggestTextFieldDelegate>) suggestionDelegate {
    return nil;
}

// Uses the suggestionDelegate that is set.
- (void)updateSuggestion {
    [self updateSuggestion:self.suggestionDelegate];
}

// Injection point to use any suggestion delegate.
- (void)updateSuggestion:(id<AutoSuggestTextFieldDelegate>)aSuggestionDelegate {
    static dispatch_once_t onceToken; // Set the default color, only once
    dispatch_once(&onceToken, ^{ DefaultSuggestedTextColor = [UIColor grayColor]; });

    // Save the caret position so that it can be restored at the end
    UITextPosition *caretPosition = [[self selectedTextRange] start];

    // Range of characters that are definitely not suggestions. i.e. left of caret
    NSInteger caretOffset = [self offsetFromPosition:self.beginningOfDocument toPosition:caretPosition];
    NSRange acceptedRange = NSMakeRange(0, caretOffset);

    // Locate any existing suggested text and delete it
    __block NSMutableAttributedString *userInput = [self.attributedText mutableCopy];

    [self.attributedText enumerateAttribute:SuggestedTextMarkerAttributeName
                                    inRange:NSMakeRange(0, self.text.length)
                                    options:NSEnumerationReverse
                                 usingBlock:
     ^(NSString *marker, NSRange range, BOOL *stop) {

         if (marker && marker == SuggestedTextMarkerAttributeValue) {

             NSRange accepted = NSIntersectionRange(range, acceptedRange);
             if (accepted.length != 0) {
                 // unmark & revert to default formatting
                 [userInput beginEditing];
                 [userInput removeAttribute:SuggestedTextMarkerAttributeName range:accepted];
                 [userInput setAttributes:self.defaultTextAttributes range:accepted];
                 [userInput endEditing];

                 // delete beyond caret
                 NSUInteger nextLocation = NSMaxRange(accepted);
                 NSRange nextRange = NSMakeRange(nextLocation, NSMaxRange(range) - nextLocation);
                 [userInput deleteCharactersInRange:nextRange];
             }
             else {
                 [userInput deleteCharactersInRange:range];
             }
         }
     }];

    // Get the suggested text for the sanitized input
    NSString *suggestedText = [aSuggestionDelegate suggestedStringForInputString:userInput.string];

    // Color the suggested text and add a proprietary marker to allow reliable
    // detection of suggested text later.
    if (suggestedText) {
        NSDictionary *attributes = nil;

        if ([aSuggestionDelegate respondsToSelector:@selector(suggestedTextAttributes)]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:SuggestedTextMarkerAttributeValue
                                                                           forKey:SuggestedTextMarkerAttributeName];
            [dict addEntriesFromDictionary:[aSuggestionDelegate suggestedTextAttributes]];
            attributes = dict;
        }
        else if ([aSuggestionDelegate respondsToSelector:@selector(suggestedTextColor)]) {
            attributes = @{NSForegroundColorAttributeName:  [aSuggestionDelegate suggestedTextColor],
                           SuggestedTextMarkerAttributeName: SuggestedTextMarkerAttributeValue };
        }

        [userInput appendAttributedString:
         [[NSAttributedString alloc] initWithString:suggestedText attributes:attributes]];
    }

    self.attributedText = userInput;

    // typingAttributes maintains the attributes to be applied to the next typed
    // character. It automaically tracks the attributes of the last typed character.
    // Prevent the suggested text attributes from be applied to manual input.
    self.typingAttributes = self.defaultTextAttributes;

    self.selectedTextRange = [self textRangeFromPosition:caretPosition
                                              toPosition:caretPosition];
}

// This method removes all suggested text formatting, replacing it with the default
- (void)acceptSuggestion {
    NSMutableAttributedString * copy = [self.attributedText mutableCopy];
    NSRange range = NSMakeRange(0, copy.length);

    [copy beginEditing];
    [copy setAttributes:self.defaultTextAttributes range:range];
    [copy removeAttribute:SuggestedTextMarkerAttributeName range:range];
    [copy endEditing];

    self.attributedText = copy;
}

@end
