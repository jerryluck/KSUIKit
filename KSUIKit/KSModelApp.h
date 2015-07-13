//
//  KSModelApp.h
//  KSUIKit
//
//  Created by jerry on 14/12/12.
//  Copyright (c) 2014年 jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

/***

{
    CFBundleDevelopmentRegion = en;
    CFBundleExecutable = EggBox;
    CFBundleIdentifier = "com.egg.com";
    CFBundleInfoDictionaryVersion = "6.0";
    CFBundleName = EggBox;
    CFBundlePackageType = APPL;
    CFBundleShortVersionString = "1.0";
    CFBundleSignature = "????";
    CFBundleSupportedPlatforms =     (
                                      iPhoneSimulator
                                      );
    CFBundleVersion = "1.0";
    DTPlatformName = iphonesimulator;
    DTSDKName = "iphonesimulator8.0";
    LSRequiresIPhoneOS = 1;
    UIDeviceFamily =     (
                          1,
                          2
                          );
    UILaunchStoryboardName = LaunchScreen;
    UIMainStoryboardFile = "";
    UIRequiredDeviceCapabilities =     (
                                        armv7
                                        );
    UISupportedInterfaceOrientations =     (
                                            UIInterfaceOrientationPortrait,
                                            UIInterfaceOrientationPortraitUpsideDown
                                            );
}

***/

@interface KSModelApp : NSObject

+ (NSString *)appBuild;

+ (NSString *)appVersion;

+ (NSString *)appVersionAndBuild;

+ (NSString *)appName;

+ (NSString*)appIOSSystemTypeName;

+ (NSString*)appIOSSystemVersion;

+ (NSString*)appIdentifier;

@end
