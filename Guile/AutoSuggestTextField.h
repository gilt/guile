//
//  AutosuggestTextField.h
//  Guile
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AutoSuggestTextFieldDelegate <NSObject>

- (NSString *)suggestedStringForInputString:(NSString *)input;

@end

@interface AutoSuggestTextField : UITextField

@property (nonatomic, assign) id<AutoSuggestTextFieldDelegate> suggestionDelegate;
@property (nonatomic) UIColor *suggestColor;

@end
