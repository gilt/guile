//
//  AutosuggestTextField.h
//  Guile
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

/**
 * This class is nothing more than a vanilla UITextField with the category
 * UITextField+AutoSuggestAdditions already mixed in and wired up.
 *
 * The class is safe to use on it's own and serves as a reference on how to
 * wire up a custom subclass of UITextField for auto suggest.
 *
 * The steps are as follows:
 *  1. Mix in UITextField+AutoSuggestAdditions.h by importing it.
 *  2. Declare a property (or a getter) for -suggestionDelegate
 *  3. Add a callback from UIControlEventEditingChanged to -updateSuggestion:
 *  4. [optional] Add other UIControl callbacks to "auto-accept" the suggestion
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Guile/AutoSuggestDelegate.h>

@interface AutoSuggestTextField : UITextField

@property (nonatomic, assign) id<AutoSuggestTextFieldDelegate> suggestionDelegate;

@end
