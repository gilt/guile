//
//  AutosuggestTextField.m
//  Guile
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import "AutoSuggestTextField.h"

#define RANGE_NOT_FOUND NSMakeRange(NSNotFound, 0)

@interface AutoSuggestTextField ()
@property (nonatomic) NSString *suggestedText;
@end

@implementation AutoSuggestTextField

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    [super awakeAfterUsingCoder:aDecoder];
    [self setup];
    return self;
}

- (void)setup {
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidComplete:) forControlEvents:(UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit)];
    _suggestColor = [UIColor grayColor];
}

- (void)textFieldDidComplete:(id)sender {
    // accept any suggestion, remove highlight
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text];
}

- (void)textFieldDidChange:(id)sender {
    // Locate any existing suggested text and delete it
    __block NSString *userInput = self.text;
    [self.attributedText enumerateAttribute:NSForegroundColorAttributeName
                                    inRange:NSMakeRange(0, self.text.length)
                                    options:0
                                 usingBlock:^(UIColor *color, NSRange range, BOOL *stop) {
                                     if (color && [color isEqual:_suggestColor]) {
                                         userInput = [userInput stringByReplacingCharactersInRange:range withString:@""];
                                     }
                                 }];

    // Get the suggested text for the clean input
    _suggestedText = [_suggestionDelegate suggestedStringForInputString:userInput];

    if (_suggestedText) {
        NSString *combined = [userInput stringByAppendingString:_suggestedText];
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:combined];

        // Color the suggested text
        [attributed addAttribute:NSForegroundColorAttributeName
                           value:_suggestColor
                           range:NSMakeRange(userInput.length, _suggestedText.length)];

        [self setAttributedText:attributed];

        // Move the caret back to the original location
        UITextPosition *caretPosition = [self positionFromPosition:self.beginningOfDocument offset:userInput.length];
        self.selectedTextRange = [self textRangeFromPosition:caretPosition
                                                  toPosition:caretPosition];
    } else {
        self.text = userInput; // ensure no highlighted text remains
    }
}

@end
