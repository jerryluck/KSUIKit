//
//  NSStringAdditions.h
//  CenturyWeeklyV2
//
//  Created by jerry.gao on 12/22/11.
//  Copyright (c) 2011 KSMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//数字
#define NUM @"0123456789"
//字母
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//数字和字母
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface NSString (KS)
- (NSUInteger) indexOf:(NSString *)text;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *) stringFromMD5;
- (BOOL)isEmpty;
- (NSDate * )toDateWithFormat:(NSString*)formatStr;
- (NSComparisonResult)versionStringCompare:(NSString *)other;


- (BOOL)isLetterOrNumber;

- (BOOL)isLetter;

- (BOOL)isNumber;

- (BOOL)isEmail;

- (BOOL)isPhoneNumber;

@end
