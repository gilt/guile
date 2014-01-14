//
//  UIApplication+StatusMessage.m
//  Guile
//
//  Created by Adam Kaplan on 5/9/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import "UIApplication+StatusMessage.h"

#import <QuartzCore/QuartzCore.h>
#import <Guile/StatusMessageManager.h>
#import <Guile/LoadableCategory.h>

MAKE_CATEGORIES_LOADABLE(UIApplication_StatusMessage);

@implementation UIApplication (StatusMessage)

- (void)setStatusBarMessage:(NSString *)message {
    [self setStatusBarMessage:message withAnimation:UIStatusBarAnimationSlide];
}

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation {
    [self setStatusBarMessage:message withAnimation:animation duration:0 completion:nil];
}

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration {
    [self setStatusBarMessage:message withAnimation:animation duration:duration completion:nil];
}

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration completion:(dispatch_block_t)completion {
    [self setStatusBarMessage:message withAnimation:animation duration:duration decorator:nil completion:completion];
}

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration decorator:(void (^)(StatusMessageLabel *))decorator {
    [self setStatusBarMessage:message withAnimation:animation duration:duration decorator:decorator completion:nil];
}

- (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration decorator:(void (^)(StatusMessageLabel *))decorator completion:(dispatch_block_t)completion {
    [StatusMessageManager setStatusBarMessage:message
                                withAnimation:animation
                                     duration:duration
                                    decorator:decorator
                                   completion:completion];
}

- (void)hideStatusBarMessage:(UIStatusBarAnimation)animation {
    [StatusMessageManager hideStatusBarMessage:animation];
}

@end
