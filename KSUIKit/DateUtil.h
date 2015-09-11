//
//  DateUtil.h
//  centuryweekly
//
//  Created by jinjian on 10-12-26.
//  Copyright 2010 caixin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateUtil : NSObject {

}
+ (NSString *)monthFromTimeIntervalSince1970:(NSTimeInterval)seconds;
+ (NSString *)strFromTimeIntervalSince1970:(NSTimeInterval)seconds format:(NSString *)format;
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)fmt;
+ (NSString *)strFromDate:(NSDate *)date format:(NSString *)fmt;
+ (void)addDate;
+(int)getYearByDate:(NSDate*)date;
@end
