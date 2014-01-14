//
//  AutosuggestTextField.h
//  Guile
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AutosuggestTextFieldDelegate <NSObject>

- (NSString *)suggestedStringForInputString:(NSString *)input;

@end

@interface AutoSuggestTextField : UITextField

@property (nonatomic, assign) id<AutosuggestTextFieldDelegate> suggestionDelegate;
@property (nonatomic) UIColor *suggestColor;

@end
