//
//  UIDeviceAdditions.h
//  CenturyWeeklyV2
//
//  Created by jerry.gao on 2/6/12.
//  Copyright (c) 2012 KSMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define IFPGA_NAMESTRING    @"iFPGA"

#define IPHONE_1G_NAMESTRING   @"iPhone 1G"
#define IPHONE_3G_NAMESTRING   @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING   @"iPhone 3GS"
#define IPHONE_4_NAMESTRING    @"iPhone 4"
#define IPHONE_4S_NAMESTRING   @"iPhone 4S"
#define IPHONE_5_NAMESTRING    @"iPhone 5"
#define IPHONE_6_NAMESTRING   @"iPhone 6"
#define IPHONE_6p_NAMESTRING   @"iPhone 6p"

#define IPHONE_UNKNOWN_NAMESTRING  @"Unknown iPhone"

#define IPOD_1G_NAMESTRING    @"iPod touch 1G"
#define IPOD_2G_NAMESTRING    @"iPod touch 2G"
#define IPOD_3G_NAMESTRING    @"iPod touch 3G"
#define IPOD_4G_NAMESTRING    @"iPod touch 4G"
#define IPOD_UNKNOWN_NAMESTRING   @"Unknown iPod"

#define IPAD_1G_NAMESTRING    @"iPad 1G"
#define IPAD_2G_NAMESTRING    @"iPad 2G"
#define IPAD_3G_NAMESTRING    @"iPad 3G"
#define IPAD_UNKNOWN_NAMESTRING   @"Unknown iPad"

// Nano? Apple TV?
#define APPLETV_2G_NAMESTRING   @"Apple TV 2G"

#define IPOD_FAMILY_UNKNOWN_DEVICE   @"Unknown iOS device"

#define IPHONE_SIMULATOR_NAMESTRING   @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPHONE_NAMESTRING @"iPhone Simulator"
#define IPHONE_SIMULATOR_IPAD_NAMESTRING @"iPad Simulator"

typedef enum {
    UIDeviceUnknown,
    
    UIDeviceiPhoneSimulator,
    UIDeviceiPhoneSimulatoriPhone, // both regular and iPhone 4 devices
    UIDeviceiPhoneSimulatoriPad,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    UIDevice6iPhone,
    UIDevice6PlusiPhone,

    
    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    
    UIDevice1GiPad, // both regular and 3G
    UIDevice2GiPad,
    UIDevice3GiPad,
    
    
    UIDeviceAppleTV2,
    
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceIFPGA,
    
} UIDevicePlatform;


@interface UIDevice (IdentifierAddition)

/*
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */

- (NSString *) uniqueDeviceIdentifier;

/*
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */


- (NSUInteger) platformType;
- (NSString *) platformString;
- (NSString*)getCurrentIP;
- (NSString *) macaddress;
- (NSString *) uniqueGlobalDeviceIdentifier;
- (BOOL)isJailbroken;
+ (NSString*)getOSVersion;
+ (BOOL)isInChina;


@end
