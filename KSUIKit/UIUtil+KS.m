//
//  UIUtil+KS.m
//  CenturyWeekly2
//
//  Created by jerry.gao on 11-11-27.
//  Copyright (c) 2011年 KSMobile. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/QuartzCore.h>
#import "UIUtil+KS.h"
#import "KSBootstrap.h"
#import "KSApp-Prefix.pch"


@implementation UIUtil
@end

@implementation UIUtil (KS)

+ (void)redirectNSlogToDocumentFolderIfInSimulator
{
    if (!isSimulator)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *fileName = [NSString stringWithFormat:@"crash_%@.log",[[NSDate date] format:DATE_FULL_FORMATE]];// 注意不是NSData!
        NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
        // 先删除已经存在的文件
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        [defaultManager removeItemAtPath:logFilePath error:nil];
        
        // 将log输入到文件
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
        freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    }
    

}




+ (NSInteger) currentOrientation{

    return [[USER_DEFAULT objectForKey:@"orientation"] intValue];
}
+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    int o = UIInterfaceOrientationIsPortrait(orientation)?0:1;
    [USER_DEFAULT setObject:INTEGER(o) forKey:@"orientation"];
    [USER_DEFAULT synchronize];
}

+ (void)animatedWithView:(UIView*)view degree:(CGFloat)degree duration:(NSTimeInterval)duration
{
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:duration];
    CGFloat angle = M_PI / 180 * degree;
    [view.layer setTransform:CATransform3DRotate(view.layer.transform, angle, 0.0, 0.0, 1.0)];
    [UIView commitAnimations];


}

+ (void)animatedShakeView:(UIView *)view repeat:(NSInteger)count duration:(NSTimeInterval)duration {
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:count];
    [UIView setAnimationDuration:duration];
    
    view.transform = CGAffineTransformMakeRotation(2 * M_PI / 180);
    view.transform = CGAffineTransformMakeRotation(-2 * M_PI / 180);
    //self.transform = CGAffineTransformMakeRotation(0 * M_PI / 180);
    [UIView commitAnimations];
}

+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration {
    [self animatedShowView:view duration:duration alpha:1];
}
+ (void)animatedShowView:(UIView *)view duration:(NSTimeInterval)duration alpha:(CGFloat)alpha {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.alpha = alpha;
    [UIView commitAnimations];
}
+ (void)animatedShowAndHideView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration {
    [self animatedShowView:view duration:duration];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelay:waitDuration];
    view.alpha = 0;
    [UIView commitAnimations];
}
+ (void)animatedHideView:(UIView *)view duration:(NSTimeInterval)duration {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.alpha = 0;
    [UIView commitAnimations];
}
+ (void)animatedHideAndShowView:(UIView *)view duration:(NSTimeInterval)duration waitDuration:(NSTimeInterval)waitDuration {
    [self animatedHideView:view duration:duration];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelay:waitDuration];
    view.alpha = 1;
    [UIView commitAnimations];
}
+ (void)animatedMoveView:(UIView *)view duration:(NSTimeInterval)duration newFrame:(CGRect)newFrame {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.frame = newFrame;
    [UIView commitAnimations];
}
+ (void)animatedWinkView:(UIView *)view duration:(NSTimeInterval)duration {
    view.alpha = 0;    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatCount:1000];
    [UIView setAnimationRepeatAutoreverses:YES];
    view.alpha = 1;
    [UIView commitAnimations];
}
+ (void)addAnimationPop:(UIView *)viewToAddAnimation {
    [viewToAddAnimation setTransform:CGAffineTransformMakeScale(0.9,0.9)];
    [UIView animateWithDuration:0.25 animations:^{
        [viewToAddAnimation setTransform:CGAffineTransformMakeScale(1,1)];
    }];
}
+ (void)addAnimationPush:(UIView *)viewToAddAnimation {
    [viewToAddAnimation setTransform:CGAffineTransformMakeScale(1,1)];
    [UIView animateWithDuration:0.25 animations:^{
        [viewToAddAnimation setTransform:CGAffineTransformMakeScale(0.9,0.9)];
    }];
}
+ (void)addAnimationWithShakePop:(UIView *)viewToAddAnimation
{
    [viewToAddAnimation setTransform:CGAffineTransformMakeScale(0.1,0.1)];
    [UIView animateWithDuration:0.25 animations:^{
        [viewToAddAnimation setTransform:CGAffineTransformMakeScale(1.2,1.2)];

    }];
    double delayInSeconds = 0.25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.2 animations:^{
            [viewToAddAnimation setTransform:CGAffineTransformMakeScale(1,1)];
            
        }];
    });
}
+ (void)addAnimationShow:(UIView *)viewToAddAnimation{
	viewToAddAnimation.alpha = 0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.alpha = 1;
	[UIView commitAnimations];
}

+ (void)addAnimationFade:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.alpha = 0;
	[UIView commitAnimations];
}

+ (void)addAnimationClick:(UIView *)viewToAddAnimation{
	viewToAddAnimation.alpha = 0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.alpha = 1;
	[UIView commitAnimations];
}
+(void)addAnimationwidth:(UIView *)viewToAddAnimation  endwidth:(CGFloat)lenght
{
    CGFloat originalX = viewToAddAnimation.left;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    CGRect rect = viewToAddAnimation.bounds;
    rect.size.width = lenght;
    viewToAddAnimation.bounds = rect;
    viewToAddAnimation.left = originalX;
    [UIView commitAnimations];
}
+(void)addAnimationHeight:(UIView *)viewToAddAnimation  endHeight:(CGFloat)height
{
    CGFloat originalY = viewToAddAnimation.top;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    CGRect rect = viewToAddAnimation.bounds;
    rect.size.height = height;
    viewToAddAnimation.bounds = rect;
    viewToAddAnimation.top = originalY;
    [UIView commitAnimations];
}
+ (void)addAnimation:(UIView *)viewToAddAnimation position:(MovePosition)type to:(CGFloat)position
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    switch (type) {
        case MovePositionLeft:
            viewToAddAnimation.left = position;
            break;
        case MovePositionRight:
            viewToAddAnimation.right = position;
            break;
        case MovePositionTop:
            viewToAddAnimation.top = position;
            break;
        case MovePositionBottom:
            viewToAddAnimation.bottom = position;
            break;
        default:
            break;
    }
	
	[UIView commitAnimations];
}

+ (void)addAnimationSlideUp2:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x, viewToAddAnimation.center.y-viewToAddAnimation.frame.size.height*2);
	[UIView commitAnimations];
}

+ (void)addAnimationSlideDown2:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x, viewToAddAnimation.center.y+viewToAddAnimation.frame.size.height*2);
	[UIView commitAnimations];
}

+ (void)addAnimationSlideUp:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x, viewToAddAnimation.center.y-viewToAddAnimation.frame.size.height);
	[UIView commitAnimations];
}

+ (void)addAnimationSlideDown:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x, viewToAddAnimation.center.y+viewToAddAnimation.frame.size.height);
	[UIView commitAnimations];
}
+(void)addAnimationSlideDownAndUp:(UIView *)viewToAddAnimation
{
    viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x, viewToAddAnimation.center.y+viewToAddAnimation.frame.size.height);
    [UIUtil addAnimationSlideUp:viewToAddAnimation];
}
+ (void)addAnimationSlideLeft:(UIView *)viewToAddAnimation to:(CGFloat)left
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.left = left;
	[UIView commitAnimations];
}
+ (void)addAnimationSlideLeft:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x-viewToAddAnimation.frame.size.width, viewToAddAnimation.center.y);
	[UIView commitAnimations];
}

+ (void)addAnimationSlideRight:(UIView *)viewToAddAnimation{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	viewToAddAnimation.center = CGPointMake(viewToAddAnimation.center.x+viewToAddAnimation.frame.size.width, viewToAddAnimation.center.y);
	[UIView commitAnimations];
}

+ (void)addAnimationWaveShake:(UIView *)viewToAddAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];    
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    [viewToAddAnimation.layer addAnimation:animation forKey:@"popup"];
}

//+ (UIImage *)snapshotScreen {
//    // Create a graphics context with the target size
//    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
//    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
//    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
//    if (NULL != UIGraphicsBeginImageContextWithOptions)
//        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
//    else
//        UIGraphicsBeginImageContext(imageSize);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // Iterate over every window from back to front
//    for (UIWindow *window in [[UIApplication sharedApplication] windows]) 
//    {
//        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
//        {
//            // -renderInContext: renders in the coordinate space of the layer,
//            // so we must first apply the layer's geometry to the graphics context
//            CGContextSaveGState(context);
//            // Center the context around the window's anchor point
//            CGContextTranslateCTM(context, [window center].x, [window center].y);
//            // Apply the window's transform about the anchor point
//            CGContextConcatCTM(context, [window transform]);
//            // Offset by the portion of the bounds left of and above the anchor point
//            CGContextTranslateCTM(context,
//                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
//                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
//            
//            // Render the layer hierarchy to the current context
//            [[window layer] renderInContext:context];
//            
//            // Restore the context
//            CGContextRestoreGState(context);
//        }
//    }
//    
//    // Retrieve the screenshot image
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return image;
//}
//
+ (UIImage *)snapshotView:(UIView *)shotView {
    UIGraphicsBeginImageContext(shotView.bounds.size);
    [shotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (void)saveImageToPhotoAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}
+(BOOL)checkInternetConnectionWithAction:(BOOL)hasAction
{
    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
        ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable))
    {
        if (hasAction)
        {

//            [MBHUDView hudWithBody:@"No network!" type:MBAlertViewHUDTypeExclamationMark hidesAfter:2 show:YES];
            [UIUtil showMsgAlertWithTitle:NSLocalizedString(@"confirm", nil) message:@"无法连接到网络"];
        }

        return NO;
    }
    return YES;
}
//+ (CGFloat)heightOfString:(NSString*)string withFont:(UIFont*)font withWidth:(CGFloat)width
//{
//    NO_WARNING_BEGIN
//    CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(width,100000) lineBreakMode:NSLineBreakByWordWrapping];
//    return size.height;
//    NO_WARNING_end
//}

+ (UIButton*)getBackButton
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0,0,43,43);
    btn.imageEdgeInsets = UIEdgeInsetsMake((43-31)/2, (43-31)/2, (43-31)/2,(43-31)/2);
    return btn;
}


#pragma mark - UI Elements/Components Factory
+ (UIButton *)newTextButtonWithFrame:(CGRect)frame
                               title:(NSString *)title 
                          titleColor:(UIColor *)titleColor
                         tappedColor:(UIColor *)tappedColor
                                font:(UIFont *)font
                              target:(id)target 
                              action:(SEL)selector{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.backgroundColor = [UIColor clearColor];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (tappedColor)
    {
        [button setTitleColor:tappedColor forState:UIControlStateHighlighted];
    }
	button.titleLabel.font = font?font:[UIFont systemFontOfSize:16];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	return button;
}
+ (UIButton *)createImageButtonWithFrame:(CGRect)frame 
                                   image:(UIImage*)image
                                  target:(id)target 
                                  action:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	return button;
}
+ (UIButton *)newImageButtonWithFrame:(CGRect)frame
								image:(UIImage *)image{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.backgroundColor = [UIColor clearColor];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	return button;
}

+ (UIButton *)newImageButtonWithFrame:(CGRect)frame
								image:(UIImage *)image
							   target:(id)target 
							   action:(SEL)selector{
    return [UIUtil newImageButtonWithFrame:frame image:image tappedImage:image target:target action:selector];
}

+ (UIButton *)newImageSwitchButtonWithFrame:(CGRect)frame
								image:(UIImage *)image
						  tappedImage:(UIImage *)tappedImage
							   target:(id)target 
							   action:(SEL)selector{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.backgroundColor = [UIColor clearColor];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setBackgroundImage:tappedImage forState:UIControlStateHighlighted];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
	return button;
}

+ (UIButton *)newImageButtonWithFrame:(CGRect)frame
								image:(UIImage *)image
						  tappedImage:(UIImage *)tappedImage
							   target:(id)target 
							   action:(SEL)selector{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setBackgroundImage:tappedImage forState:UIControlStateHighlighted];
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	return button;
}

+ (UIButton *)newActionButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title 
                            titleColor:(UIColor *)titleColor
                           tappedColor:(UIColor *)tappedColor
                                  font:(UIFont *)font
                                target:(id)target 
                                action:(SEL)selector{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.backgroundColor = [UIColor clearColor];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:titleColor forState:UIControlStateNormal];
	[button setTitleColor:tappedColor forState:UIControlStateHighlighted];
	button.titleLabel.font = font;
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundImage:[[UIImage imageNamed:@"btnLogin.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateNormal];
	[button setBackgroundImage:[[UIImage imageNamed:@"btnLogin.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0] forState:UIControlStateHighlighted];
	
	return button;
}

+ (UILabel *)newLabelWithFrame:(CGRect)frame
                          text:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.text = text;
	label.textColor = textColor;
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = NSTextAlignmentLeft;
	label.font = font;
    return label;
}

+ (UITextField *)newTextFieldWithFrame:(CGRect)frame
                           borderStyle:(UITextBorderStyle)borderStyle
                             textColor:(UIColor *)textColor
                       backgroundColor:(UIColor *)backgroundColor
                                  font:(UIFont *)font
                          keyboardType:(UIKeyboardType)keyboardType{
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	textField.borderStyle = borderStyle;
	textField.textColor = textColor;
	textField.font = font;
	textField.backgroundColor = backgroundColor;
	textField.keyboardType = keyboardType;
	
	textField.returnKeyType = UIReturnKeyDefault;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.leftViewMode = UITextFieldViewModeNever;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_textField_red.png"]];
	textField.leftView = imageView;
	[imageView release];
	
	return textField;
}
#pragma mark - 提示框
+ (void)showMsgAlertWithTitle:(NSString *)title message:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = kTagAlert;
    [alert show];
    [alert release];

}
+ (void)showMsgAlertWithDelegate:(id)delegate Title:(NSString *)title message:(NSString *)msg cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg  delegate:delegate cancelButtonTitle:cancelButtonTitle?:@"OK" otherButtonTitles:otherButtonTitle, nil];
    alert.tag = kTagAlert;
    [alert show];
    [alert release];
    
}
+(void)showProcessIndicatorView:(UIView*)view
{
    UIImageView *maskView = [[UIImageView alloc] initWithFrame:view.bounds];
    maskView.tag = kTagCommonMaskView;
    maskView.center = CGPointMake(view.width/2, view.height/2);
	[view addSubview:maskView];
	[maskView release];
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	indicator.center = CGPointMake(maskView.width/2, maskView.height/2);
	[maskView addSubview:indicator];
	[indicator release];
	[indicator startAnimating];

}
+ (void)showProcessIndicator:(UIView *)imgView{
	UIView *maskView = [[UIView alloc] initWithFrame:imgView.bounds];
    maskView.tag = kTagCommonMaskView;
	maskView.backgroundColor = [UIColor clearColor];  //[UIColor colorWithWhite:0 alpha:0.7];
	//maskView.tag = kTagImageMaskView;
	[imgView addSubview:maskView];
	[maskView release];
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.center = maskView.center;
	[maskView addSubview:indicator];
	[indicator release];
	[indicator startAnimating];
}
+ (void)showFadeInAnimation:(UIView*)view endAlpha:(CGFloat)alpha
{
    view.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    view.alpha = alpha;
    [UIView commitAnimations];
}
+ (void)showProcessIndicatorWithView:(UIView *)view atPoint:(CGPoint)point hasMask:(BOOL)hasMask{
	if( hasMask )
    {
		UIView *maskView = [[UIView alloc] initWithFrame:view.bounds];
		maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		maskView.tag = kTagCommonMaskView;
		[view addSubview:maskView];
		[maskView release];
	}
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
	indicator.center = point;
	indicator.tag = kTagCommonIndicatorView;
	[view addSubview:indicator];
	[indicator release];
	[indicator startAnimating];
}

+ (void)showProcessIndicatorWithView2:(UIView *)view atPoint:(CGPoint)point hasMask:(BOOL)hasMask{
    int MaskWidth = 100;
    int MaskHeight = 100;
	if( hasMask )
    {
		UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake((view.bounds.size.width - MaskWidth)/2, (view.bounds.size.height - MaskHeight)/2, MaskWidth, MaskHeight)];
        maskView.layer.masksToBounds = YES;
        maskView.layer.cornerRadius = 6.0;
        maskView.layer.borderWidth = 1.0;
		maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		maskView.tag = kTagCommonMaskView;
		[view addSubview:maskView];
		[maskView release];
	}
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
	indicator.center = point;
	indicator.tag = kTagCommonIndicatorView;
	[view addSubview:indicator];
	[indicator release];
    
    //add a clear color view
    UIView* clearView = [[UIView alloc] initWithFrame:view.bounds];
    clearView.backgroundColor = [UIColor clearColor];
    clearView.tag = kTagCommonMaskClearView;
    [clearView setUserInteractionEnabled:NO];
    [view addSubview:clearView];
    [clearView release];
    [view bringSubviewToFront:clearView];
    
	[indicator startAnimating];
}

+(void)showHubWithView:(UIView *)view atPoint:(CGPoint)point Message:(NSString*)message hasMask:(BOOL)hasMask
{

    UIView *maskView = [[UIView alloc] initWithFrame:view.bounds];
    maskView.backgroundColor = !hasMask?[UIColor clearColor]:[UIColor colorWithWhite:0 alpha:0.5];
    maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    maskView.tag = kTagCommonMaskView;
    maskView.alpha = hasMask?0.5:0;
    [view addSubview:maskView];
    [maskView release];

    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    messageLabel.layer.cornerRadius = 6.0;
    messageLabel.clipsToBounds = YES;
    messageLabel.backgroundColor = [UIColor blackColor];
    messageLabel.alpha = 0.7;
    messageLabel.numberOfLines = 0;
    messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    messageLabel.font = [UIFont boldSystemFontOfSize:16];
    messageLabel.text = message;
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.tag = kTagHubTextView;
    
    CGSize size = CGSizeZero;
    
    if (SYSTEM_VERSION>=7)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:messageLabel.font,NSFontAttributeName,nil];
        
        size = [message boundingRectWithSize:CGSizeMake(view.width/4, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        
    }
    else
    {
#pragma clang diagnostic push
        
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        size = [message sizeWithFont:messageLabel.font constrainedToSize:CGSizeMake(view.width/4, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];

#pragma clang diagnostic pop
    }


    
    messageLabel.size = CGSizeMake(size.width+40, size.height+40);
    messageLabel.center = view.center;
    [maskView addSubview:messageLabel];
    [messageLabel release];
    [UIUtil addAnimationShow:maskView];
    

}

+(void)showHubWithView:(UIView *)view Message:(NSString*)message hidden:(BOOL)isHidden
{
    
    [UIUtil showHubWithView:view atPoint:view.center Message:message hasMask:NO];
    if (isHidden)
    {
        UIView *maskView = [view viewWithTag:kTagCommonMaskView];

        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIUtil addAnimationFade:maskView];
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [UIUtil hideProcessIndicatorWithView:view];

            });
        });
    }
}
+(void)setHubText:(NSString*)message
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UILabel *messageLabel = (UILabel*)[window viewWithTag:kTagHubTextView];
    messageLabel.text = message;
    CGSize size = CGSizeZero;
    if (SYSTEM_VERSION>=7)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:messageLabel.font,NSFontAttributeName,nil];
        
        size = [message boundingRectWithSize:CGSizeMake(window.width/4, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        
    }
    else
    {
#pragma clang diagnostic push
        
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
size = [message sizeWithFont:messageLabel.font constrainedToSize:CGSizeMake(window.width/4, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
//    CGSize size = [message sizeWithFont:messageLabel.font constrainedToSize:CGSizeMake(window.width/4, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    messageLabel.size = CGSizeMake(size.width+40, size.height+40);
}
+ (void)hideProcessIndicatorWithView:(UIView *)view{
	UIView *maskView = [view viewWithTag:kTagCommonMaskView];
	if( maskView != nil ){
		[maskView removeFromSuperview];

	}
	UIView *indicator = [view viewWithTag:kTagCommonIndicatorView];
	if( indicator != nil ){
		[indicator removeFromSuperview];
	}
    
    UIView *clear = [view viewWithTag:kTagCommonMaskClearView];
    if(clear != nil){
        [clear removeFromSuperview];
    }
    
    UIView *hub = [view viewWithTag:kTagHubTextView];
    if(hub != nil)
    {
        [hub removeFromSuperview];
    }
}

+ (void)showGlobalMask{
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	UIView *maskView = [[UIView alloc] initWithFrame:window.bounds];
	maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	maskView.tag = kTagCommonMaskView2;
	[window addSubview:maskView];
	[maskView release];
}

+ (void)hideGlobalMask{
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	UIView *maskView = [window viewWithTag:kTagCommonMaskView2];
	if( maskView != nil ){
		[maskView removeFromSuperview];
	}
}

+ (void)showModualView{
	//UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	UIViewController *maskViewController = [[UIViewController alloc] init];
	UIView *maskView = [[UIView alloc] initWithFrame:window.bounds];
	maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
	maskView.tag = kTagCommonMaskView2;
	[maskViewController.view addSubview:maskView];
	[maskView release];
//    [window.rootViewController presentModalViewController:maskViewController animated:NO];
    [window.rootViewController presentViewController:maskViewController animated:NO completion:^{}];//兼容SDK6.0  jerry.gao
}

+ (void)hideModualView{
    
   // UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    [window.rootViewController  dismissModalViewControllerAnimated:NO];
    [window.rootViewController  dismissViewControllerAnimated:NO completion:^{}];//兼容SDK6.0  jerry.gao
}

+ (void)roundCenter:(UIView *)view{
	view.center = CGPointMake(round(view.center.x), round(view.center.y));
}

//#pragma mark - image downloader
//+ (void)imageWithUrl:(NSString *)imgUrl toView:(UIView *)view {
//    [self imageWithUrl:imgUrl toView:view shouldResize:NO];
//}
//+ (void)imageWithUrl:(NSString *)imgUrl toView:(UIView *)view resize:(CGSize)size {
//    if (imgUrl == nil || view == nil) {
//        return;
//    }
//    NSOperationQueue *operationQueue = [[[NSOperationQueue alloc] init] autorelease];
//    ImageDataOperation *imgDataOperation = [[ImageDataOperation alloc] initWithURL:imgUrl view:view resize:size];
//    [operationQueue addOperation:imgDataOperation];
//    [imgDataOperation release];
//}
//+ (void)imageWithUrl:(NSString *)imgUrl toView:(UIView *)view shouldResize:(BOOL)shouldResize {
//    if (imgUrl == nil || view == nil) {
//        return;
//    }
//    NSOperationQueue *operationQueue = [[[NSOperationQueue alloc] init] autorelease];
//    ImageDataOperation *imgDataOperation = [[ImageDataOperation alloc] initWithURL:imgUrl view:view shouldResize:shouldResize];
//    [operationQueue addOperation:imgDataOperation];
//    [imgDataOperation release];
//}
//+(void)loadImageUrl:(NSString*)imgUrl savePath:(NSString*)savePath success:(void (^)(NSString*))success faild:(void (^)(NSString*))faild
//{
//    __block NSString *url = [imgUrl retain];
//    __block NSString *path = [savePath retain];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        
//        NSLog(@"%@",url);
//        
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        if (data)
//        {
//            [data writeToFile:path atomically:YES];
//            if (success)
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    success(path);
//
//                });
//            }
//            [url release];
//        }
//        else
//        {
//            if (faild)
//            {
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    faild(path);
//                    
//                });
//            }
//            [path release];
//        }
//        
//    });
//    
//    
//}


@end



///////////////////////////////////////////////////////////////////////
// 远程异步下载图片
//
///////////////////////////////////////////////////////////////////////
//@implementation ImageDataOperation                                                                                            

//- (id)initWithURL:(NSString *)url view:(UIView *)view{
//    self = [super init];
//	if (self) {
//		imageUrl = [url retain];
//		imgView = [view retain];
//        shouldResize = NO;
//	}
//	return self;
//}
//- (id)initWithURL:(NSString *)url view:(UIView *)view resize:(CGSize)size{
//    self = [super init];
//	if (self) {
//		imageUrl = [url retain];
//		imgView = [view retain];
//        newSize = size;
//        shouldResize = YES;
//	}
//	return self;
//}
//- (id)initWithURL:(NSString *)url view:(UIView *)view shouldResize:(BOOL)resize{
//    self = [self initWithURL:url view:view];
//    if (self) {
//        shouldResize = resize;
//        if (shouldResize) {
//            newSize = CGSizeMake(view.frame.size.width, view.frame.size.height);
//            IF_IOS4_OR_GREATER( newSize = CGSizeMake(view.frame.size.width*2, view.frame.size.height*2););
//        }
//    }
//    return self;
//}
//- (void)main {
//	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//	[(NSObject *)[UIUtil class] performSelectorOnMainThread:@selector(showProcessIndicator:) withObject:imgView waitUntilDone:YES];	
//    
//	//UIImage *image = (UIImage *)[[DataEnv sharedDataEnv].imageCacheDict objectForKey:imageUrl];
//    UIImage *image = [UIImage imageWithContentsOfFile:[DataUtil urlToPah:imageUrl]];
//	if( !image ){
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//        image = [UIImage imageWithData:data];
//		if (image) {
//			//[[DataEnv sharedDataEnv].imageCacheDict setObject:image forKey:imageUrl];
//            //[DataUtil saveImageToDisk:image fullPath:[DataUtil urlToPah:imageUrl]];
//            //创建目录
//            NSString *fullpath = [DataUtil urlToPah:imageUrl];
//            NSString *directory = [fullpath substringToIndex:(int)([fullpath rangeOfString:@"/" options:NSBackwardsSearch].location) ];
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            if (![fileManager fileExistsAtPath:directory]) {
//                [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
//            }
//            //保存数据
//            [data writeToFile:fullpath atomically:YES];
//		}
//	}
//    if (shouldResize) {
//        NSString *thumbPath = [DataUtil urlToPah:imageUrl size:newSize];
//        UIImage *thumb = [UIImage imageWithContentsOfFile:thumbPath];
//        if (!thumb) {
//            thumb = [image cropCenterAndScaleToSize:newSize];
//            [DataUtil saveImageToDisk:thumb fullPath:thumbPath];
//        }
//        image = thumb;
//    }
//	if( [imgView isKindOfClass:[UIButton class]] ){
//		UIButton *imgBtn = (UIButton *)imgView;
//		if (image) {
//			[imgBtn setBackgroundImage:image forState:UIControlStateNormal];
//			[imgBtn setBackgroundImage:image forState:UIControlStateHighlighted];
//		}
//	}else if ([imgView isKindOfClass:[UIImageView class]]) {
//		UIImageView *iView = (UIImageView *)imgView;
//		iView.image = image;
//	}
//	[(NSObject *)[UIUtil class] performSelectorOnMainThread:@selector(hideProcessIndicatorWithView:) withObject:imgView waitUntilDone:YES];
//	[pool release];
//}
//- (void)dealloc {
//	[imgView release];
//	[imageUrl release];
//	[super dealloc];
//}

//@end




