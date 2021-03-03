//
//  SSDKTextViewChainModel.m
//  SSDKCategory
//
//  Created by maxl on 2018/12/27.
//  Copyright © 2018 mob. All rights reserved.
//

#import "SSDKTextViewChainModel.h"
#define SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(SSDKMethod,SSDKParaType) SSDKCATEGORY_CHAIN_VIEWCLASS_IMPLEMENTATION(SSDKMethod,SSDKParaType, SSDKTextViewChainModel *,UITextView)

@implementation SSDKTextViewChainModel
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(delegate, id<UITextViewDelegate>);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(text, NSString *);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(font, UIFont *);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(textColor, UIColor *);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(textAlignment, NSTextAlignment);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(selectedRange, NSRange);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(editable, BOOL);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(selectable, BOOL);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(dataDetectorTypes, UIDataDetectorTypes);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(keyboardType, UIKeyboardType);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(allowsEditingTextAttributes, BOOL);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(attributedText, NSAttributedString *);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(typingAttributes, NSDictionary *);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(clearsOnInsertion, BOOL);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(textContainerInset, UIEdgeInsets);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(linkTextAttributes, NSDictionary *);
#pragma mark - UITextInputTraits -
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(autocapitalizationType, UITextAutocapitalizationType);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(autocorrectionType, UITextAutocorrectionType)
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(spellCheckingType, UITextSpellCheckingType)

SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(keyboardAppearance, UIKeyboardAppearance);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(returnKeyType, UIReturnKeyType);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(enablesReturnKeyAutomatically, BOOL);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(secureTextEntry, BOOL);
SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION(textContentType, UITextContentType);
@end
SSDKCATEGORY_VIEW_IMPLEMENTATION(UITextView, SSDKTextViewChainModel)

#undef SSDKCATEGORY_CHAIN_TEXT_IMPLEMENTATION
