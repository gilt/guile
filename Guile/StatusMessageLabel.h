//
//  StatusMessageLabel.h
//  Guile
//
//  Created by Adam Kaplan on 5/9/13.
//  Copyright (c) 2013 Gilt Groupe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusMessageLabel : UILabel <UIAppearanceContainer> {
    BOOL isInitializing;
}

/* These are properties that can be customized using the UIAppearance proxy.
 * For documentation, reference UILabel.
 */
@property (nonatomic) UIColor            *backgroundColor   UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor            *borderColor       UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor            *textColor         UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor            *shadowColor       UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGSize             shadowOffset       UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSTextAlignment    textAlignment      UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSLineBreakMode    lineBreakMode      UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIFont             *font              UI_APPEARANCE_SELECTOR;

@end
