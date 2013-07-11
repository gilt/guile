//
//  UIApplication+StatusMessage.h
//  Guile
//
//  Created by Adam Kaplan on 5/9/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusMessageLabel;

// This category is provided as a convienance on UIApplication. Since all other
// status bar related information and control mechanisms are located in
// UIApplication, it makes for a very natural extension.
//
// See StatusMessageManager for details on the arguments for these methods.

@interface UIApplication (StatusMessage)

- (void)setStatusBarMessage:(NSString *)message;

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation;

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration;

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration decorator:(void (^)(StatusMessageLabel *))customization;

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration decorator:(void (^)(StatusMessageLabel *))customization completion:(dispatch_block_t)completion;

- (void)hideStatusBarMessage:(UIStatusBarAnimation)animation;

@end
