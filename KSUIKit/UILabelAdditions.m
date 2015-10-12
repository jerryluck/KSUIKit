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
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
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
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
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



////////////////////////////////


@implementation TextLayoutLabel

@synthesize characterSpacing = characterSpacing_;

@synthesize linesSpacing = linesSpacing_;

-(id) initWithFrame:(CGRect)frame

{//初始化字间距、行间距
    
    if(self =[super initWithFrame:frame])
        
    {
        
        self.characterSpacing = 0.0f;
        
        self.linesSpacing = 0.0f;
        
    }
    
    return self;
    
}



-(void)setCharacterSpacing:(CGFloat)characterSpacing //外部调用设置字间距

{
    
    characterSpacing_ = characterSpacing;
    
    [self setNeedsDisplay];
}



-(void)setLinesSpacing:(long)linesSpacing  //外部调用设置行间距

{
    
    linesSpacing_ = linesSpacing;
    
    [self setNeedsDisplay];
    
}



-(void) drawTextInRect:(CGRect)requestedRect

{
    
    
    
    
    //创建AttributeString
    
    NSMutableAttributedString *string =[[NSMutableAttributedString alloc]initWithString:self.text];
    
    //设置字体及大小
    
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
    
    [string addAttribute:(id)kCTFontAttributeName value:(id)helveticaBold range:NSMakeRange(0,[string length])];
    
    //设置字间距
    
    if(self.characterSpacing)
        
    {
        
        long number = self.characterSpacing;
        
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        
        [string addAttribute:(id)kCTKernAttributeName value:(id)num range:NSMakeRange(0,[string length])];
        
        CFRelease(num);
        
    }
    
    //设置字体颜色
    
    [string addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[string length])];
    
    //创建文本对齐方式
    
    CTTextAlignment alignment = kCTLeftTextAlignment;
    
    if(self.textAlignment == NSTextAlignmentCenter)
        
    {
        
        alignment = kCTCenterTextAlignment;
        
    }
    
    if(self.textAlignment == NSTextAlignmentRight)
        
    {
        
        alignment = kCTRightTextAlignment;
        
    }
    
    CTParagraphStyleSetting alignmentStyle;
    
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
    
    alignmentStyle.valueSize = sizeof(alignment);
    
    alignmentStyle.value = &alignment;
    
    //设置文本行间距
    
    CGFloat lineSpace = self.linesSpacing;
    
    CTParagraphStyleSetting lineSpaceStyle;
    
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    
    lineSpaceStyle.value =&lineSpace;
    
    //设置文本段间距
    
    CGFloat paragraphSpacing = 5.0;
    
    CTParagraphStyleSetting paragraphSpaceStyle;
    
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    
    paragraphSpaceStyle.valueSize = sizeof(CGFloat);
    
    paragraphSpaceStyle.value = &paragraphSpacing;
    
    
    
    //创建设置数组
    
    CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings , sizeof(settings));
    
    //给文本添加设置
    
    [string addAttribute:(id)kCTParagraphStyleAttributeName value:(id)style range:NSMakeRange(0 , [string length])];
    
    //排版
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    CTFrameGetFrameAttributes(leftFrame);
    
    //翻转坐标系统（文本原来是倒的要翻转下）
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    //画出文本
    
    CTFrameDraw(leftFrame,context);
    
    //释放
    
    CGPathRelease(leftColumnPath);
    CFRelease(framesetter);
    
    CFRelease(helveticaBold);
    
    [string release];
    
    UIGraphicsPushContext(context);
    
    
    
}

@end
