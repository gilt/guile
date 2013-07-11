//
//  StatusMessageManager.h
//  Guile
//
//  Created by Adam Kaplan on 5/13/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class StatusMessageLabel;

@interface StatusMessageManager : NSObject

@property (nonatomic, readonly) NSInteger defaultAnimationDuration;

// Obtain the UILabel used for displaying status messages. You may use this view
// to set a global theme for the messages by adjusting most aspects of the
// view, however there are a few properties that should not be modified. Changes
// to the frame will probably lead to unexpected results. Likewise, changes to
// alpha/opacity and transform will likely be overridden.
+ (StatusMessageLabel *)viewForCustomization;

// Hide the status bar message area if it is displayed, using the specified animation
+ (void)hideStatusBarMessage:(UIStatusBarAnimation)animation;

// Show the status base message, with several options:
// message:     The message string to display. Keep it short enough to avoid truncation
// animation:   A UIStatusBarAnimation, which adds an optional fade or slide effect
// duration:    The duration in seconds for the message to be displayed once it has
//              finished any animations. Passing 0 will display the message until a
//              call to hideStatusMessage:
// decorator:   Since UIAppearance doesn't work very well, the optional decorator block
//              will be executed just prior to displaying the message, giving you a
//              chance to customize the display for this specific message. nil to omit.
// completion:  A block which will be called immediately after the message has been
//              animated OFF the screen if a positive duration was specified. Otherwise,
//              if duration was 0, the completion block will execute once the message has
//              animated ON to the screen. Use this block to smartly display multiple
//              messages without interrupting ongoing animations. nil to omit.
+ (void)setStatusBarMessage:(NSString *)message withAnimation:(UIStatusBarAnimation)animation duration:(NSTimeInterval)duration decorator:(void (^)(StatusMessageLabel*))decorator completion:(dispatch_block_t)completion;

@end
