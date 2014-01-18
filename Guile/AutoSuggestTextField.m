//
//  AutosuggestTextField.m
//  Guile
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import "AutoSuggestTextField.h"
#import <Guile/UITextField+AutoSuggestAdditions.h>

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
    // This step is required, or else you will need to call
    // updateSuggestion manually as needed.
    [self addTarget:self action:@selector(updateSuggestion) forControlEvents:UIControlEventEditingChanged];

    // This step changes the suggestion into basic text (optional)
    [self addTarget:self action:@selector(textFieldDidComplete:) forControlEvents:(UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit)];
}

- (void)textFieldDidComplete:(id)sender {
    // accept any suggestion, remove highlight
    [self acceptSuggestion];
}

@end
