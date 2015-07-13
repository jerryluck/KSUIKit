//
//  NSDateAdditions.h
//  CenturyWeekly_iPhone
//
//  Created by jerry gao on 12-12-1.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    dateTypeYear = 100,
    dateTypeMonth,
    dateTypeWeek,
    dateTypeDay,
    dateTypeHour,
    dateTypeMinute,
    dateTypeSecond
} dateType;

@interface NSDate (KS)
- (NSDate*)dateWithFormat:(NSString*)format;
-(NSString*)format:(NSString*)formatStr;
-(NSString*)getWeekDay;
+(NSUInteger)currentMonthDays;
-(NSString*)toStringWithFormat:(NSString*)formatStr;
+(NSDate *)getCurrentDate;
+(NSString *)getDateStringFromDate:(NSDate *)date;
+(NSInteger)getDateToDateDays:(NSDate *)date withSaveDate:(NSDate *)saveDate;
//+ (NSString * )dateToString: (NSDate * )date;
+(NSDate * )stringToDate:(NSString * )string;
-(NSDate*)add:(NSInteger)count type:(dateType)type;
-(NSInteger)diffTimeWithDate:(NSDate*)otherDate dateType:(dateType)type;
@end
