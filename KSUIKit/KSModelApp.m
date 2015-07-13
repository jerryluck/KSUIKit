//
//  KSModelApp.m
//  KSUIKit
//
//  Created by jerry on 14/12/12.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import "KSModelApp.h"

@implementation KSModelApp
+ (NSString *)appBuild
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    return [info objectForKey:@"CFBundleVersion"];
}

+ (NSString *)appVersion
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    return [info objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appVersionAndBuild
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    return [NSString stringWithFormat:@"%@ %@", [info objectForKey:@"CFBundleShortVersionString"], [info objectForKey:@"CFBundleVersion"]];
}

+ (NSString *)appName
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    return [info objectForKey:@"CFBundleName"];
}

+ (NSString*)appIdentifier
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    return [info objectForKey:@"CFBundleIdentifier"];
}

+ (NSString*)appIOSSystemVersion
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    return [info objectForKey:@"DTPlatformVersion"];
}

+ (NSString*)appIOSSystemTypeName
{
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    NSString *platformName = [info objectForKey:@"DTPlatformName"];
    return platformName;
}

@end
