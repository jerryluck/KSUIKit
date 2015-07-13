//
//  UILabelAdditions.h
//  KSLibrary
//
//  Created by jerry gao on 12-11-20.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#define KEY_ATT_TEXT_FONT               @"KEY_ATT_TEXT_FONT"
#define KEY_ATT_TEXT_COLOR              @"KEY_ATT_TEXT_COLOR"
#define KEY_ATT_TEXT_RANGE              @"KEY_ATT_TEXT_RANGE"



@interface UILabel (KS)


+ (instancetype)createLabelWithFrame:(CGRect)frame
                                text:(NSString*)text
                           textColor:(UIColor*)textColor
                                font:(UIFont*)font
                           alignment:(NSTextAlignment)alignment;

//- (NSAttributedString *)attributedString:(NSString*) HTMLText
//                            URLTextColor:(UIColor*)URLTextColor
//                                    URLs:(NSArray *__autoreleasing *)outURLs
//                               URLRanges:(NSArray *__autoreleasing *)outURLRanges;

-(CGFloat)textHeight;
-(CGFloat)textWidth;
- (CGFloat)attributeTextWidth;
- (CGFloat)attributeTextHeight;
- (void)textHeightWithSetTextLindSpace:(CGFloat)space;
- (NSMutableAttributedString*)attStrWithCharacterSpacing:(CGFloat)characterSpacing lineSpace:(CGFloat)lineSpace paramater:(NSArray*)paramaters;

@end


