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

#pragma mark - AutoSuggestDelegate Methods

- (NSDictionary *)suggestedTextAttributes {
    // A (terrible) example of a highly attributed string
    static NSDictionary *stringAttributes;
    if (!stringAttributes) {
        stringAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                            [UIColor purpleColor], NSBackgroundColorAttributeName,
                            [UIColor whiteColor], NSForegroundColorAttributeName,
                            @.75, NSObliquenessAttributeName,
                            [UIFont fontWithName:@"Chalkduster" size:13], NSFontAttributeName,
                            nil];
    }
    return stringAttributes;
}

- (UIColor *)suggestedTextColor {
    return [UIColor blueColor];
}

- (NSString *)suggestedStringForInputString:(NSString *)input {
    // A sample which simulates email auto complete by suggesting the remaining
    // part of a domain+tld for an email fragment. Autosuggest begins when the
    // "@" is entered, and ends either on full match or a prefix mismatch.
    static NSArray *domains;
    if (!domains) {
        domains = @[@"gmail.com",
                    @"gmail.co.uk",
                    @"yahoo.com",
                    @"yahoo.cn",
                    @"hotmail.com"];
    }

    NSArray *parts = [input componentsSeparatedByString:@"@"];
    NSString *suggestion = nil;
    if (parts.count == 2) {
        NSString *domain = [parts lastObject];

        if (domain.length == 0) {
            suggestion = nil;
        }
        else {
            for (NSString *current in domains) {
                if ([current isEqualToString:domain]) {
                    suggestion = nil;
                    break;
                }
                else if ([current hasPrefix:domain]) {
                    suggestion = [current substringFromIndex:domain.length];
                    break;
                }
            }
        }
    }
    return suggestion;
}

@end
