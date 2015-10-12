//
//  NSObjectAdditons.m
//  CenturyWeeklyV2
//
//  Created by jerry.gao on 12/30/11.
//  Copyright (c) 2011 KSMobile. All rights reserved.
//

#import "NSObjectAdditons.h"

@implementation NSObjectAdditons

@end

@implementation NSObject(KS)
+ (NSString*)toJsonString:(id)obj
{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
    
}

+ (id)objFromJsonString:(NSString*)jsonStr
{
    NSError *error = nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}
extern NSString *string(id obj){
    return [NSString stringWithFormat:@"%@",obj?:@""];
}
@end
///////////////////////////////////////////////////////////////////////////////
@implementation NSNull (KS)
- (int)intValue
{
    return 0;
}
- (int)length
{
    return 0;
}
- (NSString *)stringValue
{
    return nil;
}
- (void)removeFromSuperview
{
    
}
-(BOOL)isEmpty
{
    return YES;
}
-(NSInteger)indexOfString:(NSString*)str
{
    return -1;
}


-(BOOL)containsString:(NSString*)str
{
    return NO;
}

- (float)floatValue
{
    return 0;
}

- (NSInteger)integerValue
{
    return 0;
}

@end

///////////////////////////////////////////////////////////////////////////////
@implementation NSArray(KS)

-(NSInteger)indexOfString:(NSString*)str
{
    for (int i = 0; i<[self count]; i++)
    {
        if ([[self objectAtIndex:i] isEqualToString:str])
        {
            return i;
        }
    }
    return -1;
}
-(BOOL)containsString:(NSString*)str
{
    for (int i = 0; i<[self count]; i++)
    {
        if ([[self objectAtIndex:i] isEqualToString:str])
        {
            return YES;
        }
    }
    return NO;
}
- (BOOL)validateIndex:(NSInteger)index
{
    return index>=0 && index<=self.count-1 && self.count>0;
}

@end




