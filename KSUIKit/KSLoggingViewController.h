//
//  KSLoggingViewController.h
//  KSLoggingViewController
//
//  Created by Mike on 8/8/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

@interface KSLoggingViewController : UIViewController {
    UITextView *_textView;
    CGFloat _currentFontSize;
}

- (void)logToView:(NSString *)format, ...;

@end
