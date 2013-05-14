//
//  StatusMessageManager.m
//  Guile
//
//  Created by Adam Kaplan on 5/13/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import "StatusMessageManager.h"

#import <QuartzCore/QuartzCore.h>
#import "StatusMessageLabel.h"

static const int AnimationDuration = 3.0;

static const int AnimationStartDelay = 0.00;

// Add slight delay for aesthetics and to ensure that the UIApp animation is complete.
static const int AnimationStopDelay = 1.5;

static const CGFloat CornerRadius = 5.0; //pixels

@interface StatusMessageManager () {
    UIView *container;
    UIView *roundedCornerView;
}

@property (nonatomic, readonly) StatusMessageLabel *label;

+ (StatusMessageManager *)instance;
- (void)showWithAnimation:(UIStatusBarAnimation)animation completion:(void(^)(BOOL finished))completion;
- (void)hideWithAnimation:(UIStatusBarAnimation)animation completion:(dispatch_block_t)completion;

@end

@implementation StatusMessageManager

@synthesize label;

/******************************************************************************/
#pragma mark - Singleton Methods
/******************************************************************************/

+ (StatusMessageManager *)instance {
    static StatusMessageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[StatusMessageManager alloc] init];
    });
    return instance;
}

+ (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration decorator:(void (^)(StatusMessageLabel*))decorator completion:(dispatch_block_t)completion {

    BOOL animateMessage = animation != UIStatusBarAnimationNone;

    StatusMessageManager *manager = [self instance];

    [manager setMessage:message animated:animateMessage decorator:decorator];

    [manager showWithAnimation:animation completion:^(BOOL finished) {
        if (duration) { // Hide message after delay
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [manager hideWithAnimation:animation completion:completion];
            });
        } else {
            completion();
        }
    }];
}

+ (void)hideStatusBarMessage:(UIStatusBarAnimation)animation {
    StatusMessageManager *manager = [self instance];
    [manager hideWithAnimation:animation completion:nil];
}

+ (StatusMessageLabel *)viewForCustomization {
    return [self instance].label;
}

/******************************************************************************/
#pragma mark - Instance Methods
/******************************************************************************/

- (id)init {
    if (self = [super init]) {
        UIApplication *app = [UIApplication sharedApplication];

        // This is a clipping black box that lives under the status bar
        container = [[UIView alloc] initWithFrame:[app statusBarFrame]];
        container.backgroundColor = [UIColor blackColor];
        container.clipsToBounds = YES;
        [[app keyWindow] addSubview:container];

        // It's a real pain to round only the top corners, so intead of a custom
        // drawRect:, just clip off the bottom corners.
        CGRect cornerRounderRect = CGRectMake(0, 0, container.bounds.size.width, container.bounds.size.height + CornerRadius);
        roundedCornerView = [[UIView alloc] initWithFrame:cornerRounderRect];
        roundedCornerView.clipsToBounds = YES;
        [roundedCornerView layer].cornerRadius = CornerRadius;
        [container addSubview:roundedCornerView];

        // Finally, the label
        CGRect labelRect = CGRectOffset(container.bounds, 0, container.bounds.size.height);
        label = [[StatusMessageLabel alloc] initWithFrame:labelRect];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        label.font = [UIFont systemFontOfSize:12.5];
        label.lineBreakMode = UILineBreakModeTailTruncation;

        [roundedCornerView addSubview:label];
    }
    return self;
}

- (int)defaultAnimationDuration {
    return AnimationDuration;
}

- (void)setMessage:(NSString *)message animated:(BOOL)animated decorator:(void (^)(StatusMessageLabel*))decorator {
    if (decorator) {
        decorator(label);
    }

    if (animated) {
        [UIView animateWithDuration:1.0 animations:^{
            label.text = message;
        }];
    }
    else {
        label.text = message;
    }
}

- (void)showWithAnimation:(UIStatusBarAnimation)animation completion:(void(^)(BOOL finished))completion {
    UIApplication *app = [UIApplication sharedApplication];

    if (animation == UIStatusBarAnimationSlide) {
        label.transform = CGAffineTransformIdentity;
        label.alpha = 1;
    } else if (animation == UIStatusBarAnimationFade) {
        label.transform = CGAffineTransformMakeTranslation(0, -1 * container.bounds.size.height);
        label.alpha = 0;
    }

    if (animation != UIStatusBarAnimationNone) {
        [UIView animateWithDuration:[app statusBarOrientationAnimationDuration]  + 0.05
                              delay:AnimationStartDelay
                            options:0
                         animations:^{
                             if (animation == UIStatusBarAnimationSlide) {
                                 label.transform = CGAffineTransformMakeTranslation(0, -1 * container.bounds.size.height);
                             } else {
                                 label.alpha = 1;
                             }
                         }
                         completion:completion];
    } else {
        label.transform = CGAffineTransformMakeTranslation(0, -1 * container.bounds.size.height);
        label.alpha = 1;
        completion(YES);
    }

    [app setStatusBarHidden:YES withAnimation:animation];
}

- (void)hideWithAnimation:(UIStatusBarAnimation)animation completion:(dispatch_block_t)completion {
    UIApplication *app = [UIApplication sharedApplication];

    [app setStatusBarHidden:NO withAnimation:animation];

    if (animation != UIStatusBarAnimationNone) {
        [UIView animateWithDuration:[app statusBarOrientationAnimationDuration]
                         animations:^{
                             if (animation == UIStatusBarAnimationSlide) {
                                 label.transform = CGAffineTransformIdentity;
                             } else {
                                 label.alpha = 0;
                             }
                         }
                         completion:^(BOOL finished) {
                             // Clean up both possible post-animation states
                             label.transform = CGAffineTransformIdentity;
                             label.alpha = 0;

                             // Trigger complete callback
                             if (completion) {
                                 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimationStopDelay * NSEC_PER_SEC));
                                 dispatch_after(popTime, dispatch_get_main_queue(), completion);
                             }
                         }];
    } else { // no animation
        label.transform = CGAffineTransformIdentity;
        label.alpha = 0;
        if (completion) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimationStopDelay * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), completion);
        }
    }
}

@end
