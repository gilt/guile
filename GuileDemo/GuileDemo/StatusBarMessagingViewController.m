//
//  StatusBarMessagingViewController.m
//  GuileDemo
//
//  Created by Adam Kaplan on 5/13/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import "StatusBarMessagingViewController.h"
#import <Guile/Guile.h>
#import <Guile/UIApplication+StatusMessage.h>

@implementation StatusBarMessagingViewController

@synthesize displayForLabel, displayForStepper, displayButton, animationSelector,
    autoDismissSwitch, messageField;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)displayForValueChanged:(UIStepper *)sender {
    displayForLabel.text = [NSString stringWithFormat:@"%.0f", sender.value];
}

- (IBAction)autoDismissSwitchToggle:(UISwitch *)sender {
    if (sender.on) {
        [[UIApplication sharedApplication] hideStatusBarMessage:[self selectedAnimation]];
        displayButton.enabled = YES;
    }
}

- (UIStatusBarAnimation)selectedAnimation {
    if (animationSelector.selectedSegmentIndex == 0) {
        return UIStatusBarAnimationSlide;
    } else if (animationSelector.selectedSegmentIndex == 1) {
        return UIStatusBarAnimationFade;
    } else {
        return UIStatusBarAnimationNone;
    }
}

- (IBAction)showStatusBarMessage:(UIControl *)sender {
    sender.enabled = NO;

    UIControl __block *button = sender;

    CGFloat duration = 0;
    if (autoDismissSwitch.on) {
        duration = displayForStepper.value;
    }

    NSLog(@"Displaying message [%@] for %f seconds", messageField.text, duration);
    [[UIApplication sharedApplication] setStatusBarMessage:messageField.text
                                             withAnimation:[self selectedAnimation]
                                                  duration:duration
                                                 decorator:^(StatusMessageLabel *label) {
                                                     //
                                                 }
                                                completion:^{
                                                    button.enabled = YES;
                                                }];
}

@end
