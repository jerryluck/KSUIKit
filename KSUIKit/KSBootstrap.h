//
//  KSBootstrap.h
//  CenturyWeekly2
//
//  Created by jerry.gao on 11-11-24.
//  Copyright (c) 2011年 KSMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/xattr.h>
#import "UIViewAdditions.h"


#define C_BLUE [UIColor colorWithRed:0.1922 green:0.0745 blue:0.3765 alpha:1]

//已购买的杂志列表
#define DK_LIST_PURCHASED_MAGAZINES     @"DK_LIST_PURCHASED_MAGAZINES"
//所有杂志列表
#define DK_LIST_ALL_MAGAZINES           @"DK_LIST_ALL_MAGAZINES"

@interface KSDataCenter : NSObject{
    NSMutableDictionary *_data;
    
}
@property(nonatomic,retain) NSString            *logString;
- (NSDictionary *) data;
- (void) setValue:(id)value forKey:(NSString *)key;
- (id) valueForKey:(NSString *)key;
- (void) removeObjectForKey:(id)aKey;
@end

@interface KSBootstrap : NSObject
+ (NSOperationQueue *) operationQueue;
+ (KSDataCenter *) dataCenter;
+ (NSString *) root;
+(NSString*)imgRoot;
+(NSString*)smallImgRoot;
+(NSString*)audioRoot;
+(NSString*)videoRoot;
+(void)start;
+ (void) end;
UIColor* str2rgb(NSString *rgb);
+ (void)notify:(NSString *)name object:(id)obj;
+ (void) notify:(NSString *)name data:(NSDictionary *)data;
+ (void) listen:(NSString *)name target:(id)target selector:(SEL)selector;
+ (void) unlisten:(id)target;
+ (void) unlisten:(NSString *)name target:(id)target;
+(BOOL)isValidateEmail:(NSString *)email;
@end
