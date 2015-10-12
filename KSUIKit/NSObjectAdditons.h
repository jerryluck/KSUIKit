//
//  NSObjectAdditons.h
//  CenturyWeeklyV2
//
//  Created by jerry.gao on 12/30/11.
//  Copyright (c) 2011 KSMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObjectAdditons : NSObject

@end
@interface NSObject(KS)
+ (NSString*)toJsonString:(id)obj;
+ (id)objFromJsonString:(NSString*)jsonStr;
extern NSString *string(id obj);
@end
///////////////////////////////////////////////////////////////////////////////
@interface NSNull (KS)
- (int)intValue;
- (int)length;
- (NSString *)stringValue;
- (void)removeFromSuperview;
- (BOOL)isEmpty;
-(NSInteger)indexOfString:(NSString*)str;
-(BOOL)containsString:(NSString*)str;
@end
///////////////////////////////////////////////////////////////////////////////
@interface NSArray(KS)
-(NSInteger)indexOfString:(NSString*)str;
-(BOOL)containsString:(NSString*)str;
- (BOOL)validateIndex:(NSInteger)index;
@end