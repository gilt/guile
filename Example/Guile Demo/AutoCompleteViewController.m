	//
//  AutoCompleteViewController.m
//  Guile Demo
//
//  Created by Adam Kaplan on 1/13/14.
//  Copyright (c) 2014 Gilt Groupe. All rights reserved.
//

#import "AutoCompleteViewController.h"

@implementation AutoCompleteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    _textField.suggestionDelegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"range is %@", NSStringFromRange(range));
    return YES;
}

- (NSString *)suggestedStringForInputString:(NSString *)input {
    NSArray *parts = [input componentsSeparatedByString:@"@"];
    NSString *suggestion = nil;

    if (parts.count == 2) {
        NSString *suggest = @"gmail.com";
        NSString *domain = [parts lastObject];

        if (domain.length == 0) {
            suggestion = suggest;
        }
        else if ([domain isEqualToString:suggest]) {
            suggestion = nil;
        }
        else if ([suggest hasPrefix:domain]) {
            suggestion = [suggest substringFromIndex:domain.length];
        }
    }
    return suggestion;
}

@end
