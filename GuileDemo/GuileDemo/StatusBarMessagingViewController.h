//
//  StatusBarMessagingViewController.h
//  GuileDemo
//
//  Created by Adam Kaplan on 5/13/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

@interface StatusBarMessagingViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, readonly) IBOutlet UILabel *displayForLabel;
@property (nonatomic, readonly) IBOutlet UIStepper *displayForStepper;
@property (nonatomic, readonly) IBOutlet UIButton *displayButton;
@property (nonatomic, readonly) IBOutlet UITextField *messageField;
@property (nonatomic, readonly) IBOutlet UISegmentedControl *animationSelector;
@property (nonatomic, readonly) IBOutlet UISwitch *autoDismissSwitch;

- (IBAction)displayForValueChanged:(UIStepper *)sender;
- (IBAction)autoDismissSwitchToggle:(UISwitch *)sender;
- (IBAction)showStatusBarMessage:(UIControl *)sender;

@end
