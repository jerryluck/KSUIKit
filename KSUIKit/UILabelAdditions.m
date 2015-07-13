//
//  UILabelAdditions.m
//  KSLibrary
//
//  Created by jerry gao on 12-11-20.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import "UILabelAdditions.h"
#import "UIViewAdditions.h"
#import "KSApp-Prefix.pch"




@implementation UILabel (KS)

+ (instancetype)createLabelWithFrame:(CGRect)frame
                                text:(NSString*)text
                           textColor:(UIColor*)textColor
                                font:(UIFont*)font
                           alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text?text:@"";
    label.textAlignment = alignment?alignment:NSTextAlignmentLeft;
    label.font = font?font:SYSFont(14);
    label.textColor = textColor;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
//- (NSAttributedString *)attributedString:(NSString*) HTMLText
//                            URLTextColor:(UIColor*)URLTextColor
//                                    URLs:(NSArray *__autoreleasing *)outURLs
//                               URLRanges:(NSArray *__autoreleasing *)outURLRanges
//{
//    
//    NSArray *URLs;
//    NSArray *URLRanges;
//    UIColor *color = self.textColor;
//    UIFont *font = self.font;
//    NSMutableParagraphStyle *mps = [[NSMutableParagraphStyle alloc] init];
//    NSString *str = [NSString stringWithHTMLText:HTMLText baseURL:nil URLs:&URLs URLRanges:&URLRanges];
//    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:str attributes:@
//                                      {
//                                          NSForegroundColorAttributeName : color,
//                                          NSFontAttributeName            : font,
//                                          NSParagraphStyleAttributeName  : mps,
//                                          
//                                      }];
//    [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
//        [mas addAttributes:@
//         {
//             NSForegroundColorAttributeName : URLTextColor
//         } range:[obj rangeValue]];
//    }];
//    
//    *outURLs = URLs;
//    *outURLRanges = URLRanges;
//    
//    return [mas copy];
//}


- (CGFloat)attributeTextHeight
{
    if (SYSTEM_VERSION>=7.0)
    {
        
        
        return [self.attributedText boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        
    }
    return 100;
}

- (CGFloat)attributeTextWidth
{
//    if (SYSTEM_VERSION>=7.0)
//    {
    
        
        return [self.attributedText boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
        
//    }
//    return 100;
}



-(CGFloat)textHeight
{
    


    

    if (SYSTEM_VERSION>=7.0)
    {

        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];

        return [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size.height;

    }
    
#pragma clang diagnostic push
    
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.width, MAXFLOAT) lineBreakMode:self.lineBreakMode].height;
    
#pragma clang diagnostic pop

}
-(CGFloat)textWidth
{
    if (SYSTEM_VERSION>=7)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];

        return [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size.width;

    }
#pragma clang diagnostic push
    
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

    return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.height) lineBreakMode:self.lineBreakMode].width;
    #pragma clang diagnostic pop
}



- (void)textHeightWithSetTextLindSpace:(CGFloat)space
{
//    if (SYSTEM_VERSION<6.0)
//    {
//        
//        return ;
//    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:space];//调整行间距
    paragraphStyle.alignment = self.textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
     self.attributedText = attributedString;
    
//    [self sizeToFit];
}


- (NSMutableAttributedString*)attStrWithCharacterSpacing:(CGFloat)characterSpacing lineSpace:(CGFloat)lineSpace paramater:(NSArray*)paramaters
{
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if(lineSpace>0)
    {
        [paragraphStyle setLineSpacing:lineSpace];//调整行间距
    }
    if(characterSpacing>0)
    {
        [paragraphStyle setParagraphSpacing:characterSpacing];//调整字间距
    }

    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    
    for (NSDictionary *dic in paramaters)
    {
        UIFont *font = [dic objectForKey:KEY_ATT_TEXT_FONT];
        UIColor *textColor = [dic objectForKey:KEY_ATT_TEXT_COLOR];
        NSRange range = [[dic objectForKey:KEY_ATT_TEXT_RANGE] rangeValue];
        if (textColor)
        {
            [string addAttribute:NSForegroundColorAttributeName value:textColor range:range];

        }
        if (font)
        {
            [string addAttribute:NSFontAttributeName value:font range:range];

        }

    }
    
    
    return string;
}


@end



