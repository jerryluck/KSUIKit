//
//  DateUtil.m
//  centuryweekly
//
//  Created by jinjian on 10-12-26.
//  Copyright 2010 caixin. All rights reserved.
//

#import "DateUtil.h"
#import "KSApp-Prefix.pch"

@implementation DateUtil

+ (NSString *)monthFromTimeIntervalSince1970:(NSTimeInterval)seconds {
	return [DateUtil strFromTimeIntervalSince1970:seconds format:@"M"];
}
+ (NSString *)strFromDate:(NSDate *)date format:(NSString *)fmt {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:fmt];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	
	return str;
}
+ (NSString *)strFromTimeIntervalSince1970:(NSTimeInterval)seconds format:(NSString *)fmt {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:fmt];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	
	return str;
}
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)fmt {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fmt];
    NSDate *date ;
    @try {
        date = [formatter dateFromString:string];
    }
    @catch (NSException *exception) {
        date = [NSDate date];
    }
    @finally {
        [formatter release];
    }
    
    return date;
}
+(int)getDayByDate:(NSDate*)date
{
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
//	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return [comps day];
}
+(int)getYearByDate:(NSDate*)date
{
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
//	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
	NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return [comps year];
}
+(NSTimeInterval)getTimeIntervalByDate:(NSDate*)date
{
    return [date timeIntervalSince1970];
}
+(BOOL)isLaunchApplicationThreeDays:(NSMutableArray*)days
{    
    if ([days count]<3 || !days)
    {
        return NO;
    }
    NSTimeInterval firstDay = [DateUtil getTimeIntervalByDate:[days objectAtIndex:0]];
    NSTimeInterval secondDay = [DateUtil getTimeIntervalByDate:[days objectAtIndex:1]];
    NSTimeInterval thirdDay = [DateUtil getTimeIntervalByDate:[days objectAtIndex:2]];
    NSTimeInterval maxNum = MAX(MAX(firstDay, secondDay),thirdDay); 
    NSTimeInterval minNum = MIN(MIN(firstDay, secondDay),thirdDay);
    NSLog(@"%f %f %f",firstDay,secondDay,thirdDay);
    return maxNum-minNum <= 86400*3?YES:NO;
}
+(void)addDate
{
//    if ([USER_DEFAULT objectForKey:@"marked"]) 
//    {
//        return;
//    }
    NSMutableArray *days = [[NSMutableArray alloc] initWithArray:[USER_DEFAULT objectForKey:@"days"]];
//    if (!days) 
//    {
//        days = [[NSMutableArray alloc] initWithCapacity:3];
//    }
    if ([days count]>=3)
    {
        [days removeObjectAtIndex:0];
    }
    [days addObject:[NSDate date]];
    [USER_DEFAULT setObject:days forKey:@"days"];
    
    BOOL isShowMark = [DateUtil isLaunchApplicationThreeDays:days];
    [USER_DEFAULT setBool:isShowMark forKey:@"mark"];
    [days release];
    [USER_DEFAULT synchronize];
    
}

@end
