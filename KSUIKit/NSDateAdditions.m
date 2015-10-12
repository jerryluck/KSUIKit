//
//  NSDateAdditions.m
//  CenturyWeekly_iPhone
//
//  Created by jerry gao on 12-12-1.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import "NSDateAdditions.h"
#import "KSApp-Prefix.pch"

@implementation NSDate (KS)

#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")

//获取当前日期，时间
+(NSDate *)getCurrentDate
{
    NSDate *now = [NSDate date];
    return now;
}

- (NSDate*)dateWithFormat:(NSString*)format
{
    return [[self toStringWithFormat:format] toDateWithFormat:format];
}

//将日期转换为字符串（日期，时间）
+(NSString *)getDateStringFromDate:(NSDate *)date
{
    NSInteger location = 0;
    NSString *timeStr = @"";
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [formatter setDateFormat:@"HH:mm:a"];
    NSString *ampm = [[[formatter stringFromDate:date] componentsSeparatedByString:@":"] objectAtIndex:2];
    timeStr = [formatter stringFromDate:date];
    NSRange range = [timeStr rangeOfString:[NSString stringWithFormat:@":%@",ampm]];
    location = range.location;
    NSString *string = [timeStr substringToIndex:location];
    timeStr = [NSString stringWithFormat:@"%@ %@",ampm,string];
    
    
    NSString *dateStr = @"";
    NSDateFormatter *Dformatter = [[[NSDateFormatter alloc] init] autorelease];
    [Dformatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [Dformatter setDateFormat:DATE_FORMATE_MID_LINE];
    dateStr = [Dformatter stringFromDate:date];
    //    NSLog(@"%@", [NSString stringWithFormat:@"%@  %@",dateStr,timeStr]);
    return [NSString stringWithFormat:@"%@  %@",dateStr,timeStr];
}




//计算两个日期之间的差距，过了多少天。。
+(NSInteger)getDateToDateDays:(NSDate *)date withSaveDate:(NSDate *)saveDate
{
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags =  NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:date  toDate:saveDate  options:0];
    NSInteger diffDay   = [ cps day ];
    [chineseClendar release];
    return diffDay;
}
+(NSUInteger)currentMonthDays
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

//例：NSDate *lastDate = [self getSaveDate];//saveDate通过将NSDate转换为NSString来保存
//currentDate = [NSDate date];
//NSInteger day = [DateHelper getDateToDateDays:currentDate withSaveDate: lastDate];



-(NSString*)format:(NSString*)formatStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: formatStr];
    NSString *dateString = [formatter stringFromDate:self];
    [formatter release];
    return dateString;
}

//日期转字符串
-(NSString*)toStringWithFormat:(NSString*)formatStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: formatStr?formatStr:kDEFAULT_DATE_TIME_FORMAT];
    NSString *dateString = [formatter stringFromDate:self];
    [formatter release];
    return dateString;
}


//字符串转日期
+ (NSDate * )stringToDate: (NSString * )string
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: kDEFAULT_DATE_TIME_FORMAT];
    [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];

    NSDate *date = [formatter dateFromString :string];
    [formatter release];
    return date;
}

//日期加减
-(NSDate*)add:(NSInteger)count type:(dateType)type
{
    //获得日历对象
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //通过日历对象获得日期组件对象NSDateComponents
//    NSUInteger units = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//    NSDateComponents *components = [calender components:units fromDate:self];
//    NSInteger year = 0;
//    NSInteger month = 0;
//    NSInteger day = 0;
//    NSInteger hour = 0;
//    NSInteger minute = 0;
//    NSInteger sec = 0;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    switch (type)
    {
        case dateTypeYear:
        {
//            year = year + count;
            [components setYear:count];
        }
            break;
        case dateTypeMonth:
        {
//            month = month + count;
            [components setMonth:count];
        }

            break;
        case dateTypeDay:
        {
//            day = day + count;
            [components setDay:count];
        }

            break;
            
        case dateTypeWeek:
        {
            //            day = day + count;
            [components setWeekOfYear:count];
        }
            
            break;
        case dateTypeHour:
        {
//            hour = hour + count;
            [components setHour:count];
        }

            break;
        case dateTypeMinute:
        {
//            minute = minute + count;
            [components setMinute:count];
        }

            break;
        case dateTypeSecond:
        {
//            sec = sec + count;
            [components setSecond:count];
        }

            break;
        default:
            break;
    }
//    NSString *newDateStr = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld %ld:%ld:%ld",(long)year,(long)month,(long)day,(long)hour,(long)minute,(long)sec];
//    [components setYear:year];
//    [components setMonth:month];
//    [components setDay:day];
//    [components setHour:hour];
//    [components setMinute:minute];
//    [components setSecond:sec];
    NSDate *newDate = [calender dateByAddingComponents:components toDate:self options:0];
//    NSDate *newDate = [NSDate stringToDate:newDateStr];
    return newDate;
    
}
//获得星期几
-(NSString*)getWeekDay
{
    return [self format:@"EE"];
}
//今年的第几周
-(NSInteger)getWeek
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekOfYear fromDate:self];
    
    NSInteger weekday = [weekdayComponents weekOfYear];
    return weekday;
}
//这个月的第几周
-(NSInteger)getWeekDayOrdinal
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekdayOrdinal  fromDate:self];
    
    NSInteger weekday = [weekdayComponents weekOfMonth];
    return weekday;
}
//计算距离某一天还有多少时间
-(NSInteger)diffTimeWithDate:(NSDate*)otherDate dateType:(dateType)type
{

    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    
    NSUInteger unitFlags =
    
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:self  toDate:otherDate  options:0];
    
    NSInteger diffHour = [cps hour];
    
    NSInteger diffMin    = [cps minute];
    
    NSInteger diffSec   = [cps second];
    
    NSInteger diffDay   = [cps day];
    
    NSInteger diffMon  = [cps month];
    
    NSInteger diffYear = [cps year];
        [chineseClendar release];
    switch (type)
    {
        case dateTypeYear:
            return diffYear;
            break;
        case dateTypeMonth:
            return diffMon;
            break;
        case dateTypeDay:
            return diffDay;
            break;
        case dateTypeHour:
            return diffHour;
            break;
        case dateTypeMinute:
            return diffMin;
            break;
        case dateTypeSecond:
            return diffSec;
            break;
        default:
            return 0;
            break;
    }
    

    

}
@end
