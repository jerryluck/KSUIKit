//
//  UIUtil+KS.h
//  CenturyWeekly2
//
//  Created by jerry.gao on 11-11-27.
//  Copyright (c) 2011年 KSMobile. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Reachability.h"

typedef enum
{
    MovePositionLeft = 0,
    MovePositionRight,
    MovePositionTop,
    MovePositionBottom
}
MovePosition;

typedef enum{
	kTagImageMaskView = 100000,
	kTagCommonMaskView,
    kTagCommonMaskView1,
	kTagCommonIndicatorView,
	kTagCommonMaskView2,
    kTagCommonMaskClearView,
    kTagHubTextView,
    kTagAlert
} MaskViewTag;

@interface UIUtil : NSObject
@end

@interface UIUtil (KS)
/**
 *  NSLog内容保存到磁盘
 */
+ (void)redirectNSlogToDocumentFolderIfInSimulator;
/**
 *  开启Log打印
 */
+ (void)enableNSLog;
+ (NSInteger) currentOrientation;
+ (void)setOrientation:(UIInterfaceOrientation)orientation;
+ (void)animatedWithView:(UIView*)view degree:(CGFloat)degree duration:(NSTimeInterval)duration;
+ (void)animatedShakeView:(UIView *)view repeat:(NSInteger)count duration:(NSTimeInterval)duration;
+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration alpha:(CGFloat)alpha;
+ (void)animatedShowAndHideView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration;
+ (void)addAnimation:(UIView *)viewToAddAnimation position:(MovePosition)type to:(CGFloat)position;
+ (void)animatedHideView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)animatedHideAndShowView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration;
+ (void)animatedMoveView:(UIView *)view duration:(NSTimeInterval)duration newFrame:(CGRect)newFrame;
+ (void)animatedWinkView:(UIView *)view duration:(NSTimeInterval)duration;
+ (void)addAnimationWithShakePop:(UIView *)viewToAddAnimation;
+ (void)addAnimationPop:(UIView *)viewToAddAnimation;
+ (void)addAnimationPush:(UIView *)viewToAddAnimation;
+ (void)addAnimationShow:(UIView *)viewToAddAnimation;
+ (void)addAnimationFade:(UIView *)viewToAddAnimation;
+ (void)addAnimationClick:(UIView *)viewToAddAnimation;
+(void)addAnimationSlideDownAndUp:(UIView *)viewToAddAnimation;
+ (void)addAnimationSlideLeft:(UIView *)viewToAddAnimation to:(CGFloat)left;
/**
 *	@brief	位置不动，宽度拉长
 *
 *	@param 	viewToAddAnimation 	目标view
 *	@param 	lenght 	最终长度
 */
+(void)addAnimationwidth:(UIView *)viewToAddAnimation  endwidth:(CGFloat)lenght;
/**
 *	@brief	位置不动，高度拉长
 *
 *	@param 	viewToAddAnimation 	目标view
 *	@param 	height  最终高度
 */
+(void)addAnimationHeight:(UIView *)viewToAddAnimation  endHeight:(CGFloat)height;

+ (void)addAnimationSlideUp2:(UIView *)viewToAddAnimation;   //上移高度两倍
+ (void)addAnimationSlideDown2:(UIView *)viewToAddAnimation; //下移高度两倍
+ (void)addAnimationSlideUp:(UIView *)viewToAddAnimation;
+ (void)addAnimationSlideDown:(UIView *)viewToAddAnimation;
+ (void)addAnimationSlideLeft:(UIView *)viewToAddAnimation;
+ (void)addAnimationSlideRight:(UIView *)viewToAddAnimation;

+ (void)addAnimationWaveShake:(UIView *)viewToAddAnimation;
+ (UIImage *)snapshotScreen;
+(BOOL)checkInternetConnectionWithAction:(BOOL)hasAction;
+ (UIImage *)snapshotView:(UIView *)shotView;
+ (void)saveImageToPhotoAlbum:(UIImage *)image;
+ (UIButton *)newTextButtonWithFrame:(CGRect)frame
                               title:(NSString *)title 
                          titleColor:(UIColor *)titleColor
                         tappedColor:(UIColor *)tappedColor
                                font:(UIFont *)font
                              target:(id)target 
                              action:(SEL)selector;

+ (UIButton *)newImageButtonWithFrame:(CGRect)frame
								image:(UIImage *)image;
+ (UIButton *)createImageButtonWithFrame:(CGRect)frame 
                                   image:(UIImage *)image 
                                  target:(id)target 
                                  action:(SEL)selector;

+ (UIButton *)newImageButtonWithFrame:(CGRect)frame
								image:(UIImage *)image
							   target:(id)target 
							   action:(SEL)selector;

+ (UIButton *)newImageButtonWithFrame:(CGRect)frame
								image:(UIImage *)image
						  tappedImage:(UIImage *)tappedImage
							   target:(id)target 
							   action:(SEL)selector;

+ (UIButton *)newActionButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title
                            titleColor:(UIColor *)titleColor
                           tappedColor:(UIColor *)tappedColor
                                  font:(UIFont *)font
                                target:(id)target
                                action:(SEL)selector;

+ (UILabel *)newLabelWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font;

+ (UITextField *)newTextFieldWithFrame:(CGRect)frame
                           borderStyle:(UITextBorderStyle)borderStyle
                             textColor:(UIColor *)textColor
                       backgroundColor:(UIColor *)backgroundColor
                                  font:(UIFont *)font
                          keyboardType:(UIKeyboardType)keyboardType;

+ (void)showMsgAlertWithTitle:(NSString *)title message:(NSString *)msg;
+ (void)showMsgAlertWithDelegate:(id)delegate Title:(NSString *)title message:(NSString *)msg cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle;
+(void)showProcessIndicatorView:(UIView*)view;
+ (void)showProcessIndicator:(UIView *)imgView;
+ (void)showProcessIndicatorWithView:(UIView *)view atPoint:(CGPoint)point hasMask:(BOOL)hasMask;
+ (void)showProcessIndicatorWithView2:(UIView *)view atPoint:(CGPoint)point hasMask:(BOOL)hasMask;
+ (void)hideProcessIndicatorWithView:(UIView *)view;
+ (void)showHubWithView:(UIView *)view atPoint:(CGPoint)point Message:(NSString*)message hasMask:(BOOL)hasMask;
+(void)showHubWithView:(UIView *)view Message:(NSString*)message hidden:(BOOL)isHidden
;
+(void)setHubText:(NSString*)message;
+ (void)showGlobalMask;
+ (void)hideGlobalMask;

+ (void)showModualView;
+ (void)hideModualView;
+ (void)roundCenter:(UIView *)view;

+ (void)imageWithUrl:(NSString *)imgUrl toView:(UIView *)view;
+ (void)imageWithUrl:(NSString *)imgUrl toView:(UIView *)view resize:(CGSize)size;
+ (void)imageWithUrl:(NSString *)imgUrl toView:(UIView *)view shouldResize:(BOOL)shouldResize;
+ (void)showFadeInAnimation:(UIView*)view endAlpha:(CGFloat)alpha;
+(void)loadImageUrl:(NSString*)imgUrl savePath:(NSString*)savePath success:(void (^)(NSString*))success faild:(void (^)(NSString*))faild;

+ (CGFloat)heightOfString:(NSString*)string withFont:(UIFont*)font withWidth:(CGFloat)width;
+ (UIButton*)getBackButton;
@end


@interface ImageDataOperation : NSOperation {
	NSString *imageUrl;
	UIView *imgView;
    CGSize newSize;
    BOOL shouldResize;
}
- (id)initWithURL:(NSString *)url view:(UIView *)view;
- (id)initWithURL:(NSString *)url view:(UIView *)view resize:(CGSize)size;
- (id)initWithURL:(NSString *)url view:(UIView *)view shouldResize:(BOOL)resize;

@end





