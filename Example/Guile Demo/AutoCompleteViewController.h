//
//  AutoCompleteViewController.h
//  Guile Demo
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Guile/AutoSuggestTextField.h>

@interface AutoCompleteViewController : UIViewController <AutosuggestTextFieldDelegate>

@property (nonatomic) IBOutlet AutoSuggestTextField *textField;

@end
