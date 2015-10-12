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

-(CGFloat)textHeight;
-(CGFloat)textWidth;
- (CGFloat)attributeTextWidth;
- (CGFloat)attributeTextHeight;
- (void)textHeightWithSetTextLindSpace:(CGFloat)space;
- (NSMutableAttributedString*)attStrWithCharacterSpacing:(CGFloat)characterSpacing lineSpace:(CGFloat)lineSpace paramater:(NSArray*)paramaters;

@end


@interface TextLayoutLabel : UILabel

{
    
@private
    
    CGFloat characterSpacing_;       //字间距
    
@private
    
    long linesSpacing_;   //行间距
    
}

@property(nonatomic,assign) CGFloat characterSpacing;

@property(nonatomic,assign)  long linesSpacing;

-(void)setCharacterSpacing:(CGFloat)characterSpacing; //外部调用设置字间距
-(void)setLinesSpacing:(long)linesSpacing;  //外部调用设置行间距

@end