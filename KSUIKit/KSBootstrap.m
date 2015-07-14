//
//  KSBootstrap.m
//  CenturyWeekly2
//
//  Created by jerry.gao on 11-11-24.
//  Copyright (c) 2011年 KSMobile. All rights reserved.
//

#import "KSBootstrap.h"
#import "KSApp_Config.h"

static KSDataCenter * _dataCenter;
@implementation KSDataCenter
- (id) init{
    if(self=[super init]){
        _data = [[NSMutableDictionary alloc] initWithCapacity:10];
        _logString = [[NSString alloc] init];
    }
    return self;
}
-(void)setLogString:(NSString *)logString
{
    NSString *oldStr = [[NSString alloc] initWithString:_logString];
    [_logString release];
    _logString = [[oldStr stringByAppendingFormat:@"\n%@",logString] retain];
    [oldStr release];
}
- (NSDictionary *) data{
    return [[_data copy] autorelease];
}
- (void) setValue:(id)value forKey:(NSString *)key{
    if(value==nil){
        [self removeObjectForKey:key];
    }
    [_data setValue:value forKey:key];
}

- (void) removeObjectForKey:(id)aKey{
    [_data removeObjectForKey:aKey];
}

- (id) valueForKey:(NSString *)key{
    return [_data valueForKey:key];
}

- (void) dealloc{
    [_data release];
    [super dealloc];
}
@end

static NSOperationQueue *_threadedQueue;
#pragma mark -
#pragma mark KSBootstrap
@implementation KSBootstrap
UIColor* str2rgb(NSString* rgb){
    if ([rgb isKindOfClass:[NSNull class]]||rgb == nil)
    {
        return nil;
    }
    unsigned int r, g, b;
    CGFloat p = 10;
    [[NSScanner scannerWithString:[rgb substringWithRange:NSMakeRange(1, 2)]]scanHexInt:&r];
    [[NSScanner scannerWithString:[rgb substringWithRange:NSMakeRange(3, 2)]]scanHexInt:&g];
    [[NSScanner scannerWithString:[rgb substringWithRange:NSMakeRange(5, 2)]]scanHexInt:&b];
    if (rgb.length>7)
    {
        p = [[rgb substringWithRange:NSMakeRange(7, 1)] intValue]*.1;
    }
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:p];
}
+ (NSOperationQueue *) operationQueue{
    if(_threadedQueue==nil){
        _threadedQueue = [[NSOperationQueue alloc] init];
        _threadedQueue.maxConcurrentOperationCount = 1;
    }
    return _threadedQueue;
}
#pragma mark - FileManager
+ (NSString *) root
{
    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Documents"]];
}
+(NSString*)imgRoot
{
    return STR_FORMAT(@"%@/img",[KSBootstrap root]);
}
+(NSString*)smallImgRoot
{
    return STR_FORMAT(@"%@/smallImg",[KSBootstrap root]);
}
+(NSString*)videoRoot
{
    return STR_FORMAT(@"%@/video",[KSBootstrap root]);
}
+(NSString*)audioRoot
{
    return STR_FORMAT(@"%@/audio",[KSBootstrap root]);
}
+(void)start
{

    
//    if (![FILE_DEFAULT fileExistsAtPath:[KSBootstrap root]])
//    {
//        [FILE_DEFAULT createDirectoryAtPath:[KSBootstrap root] withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    if (![FILE_DEFAULT fileExistsAtPath:[KSDB dbFile]])
//    {
//        [FILE_DEFAULT copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"sqlite" ofType:@"rdb"] toPath:[KSDB dbFile] error:nil];
//    }
//    
//    NSString *imgFile = [KSBootstrap imgRoot];
//    if (![KSBootstrap isExistFile:imgFile])
//    {
//        [FILE_DEFAULT createDirectoryAtPath:imgFile withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    NSString *smallImgFile = [KSBootstrap smallImgRoot];
//    if (![KSBootstrap isExistFile:smallImgFile])
//    {
//        [FILE_DEFAULT createDirectoryAtPath:smallImgFile withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    NSString *audioFile = [KSBootstrap audioRoot];
//    if (![KSBootstrap isExistFile:audioFile])
//    {
//        [FILE_DEFAULT createDirectoryAtPath:audioFile withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
    NSString *videoFile = [KSBootstrap videoRoot];
    if (![KSBootstrap isExistFile:videoFile])
    {
        [FILE_DEFAULT createDirectoryAtPath:videoFile withIntermediateDirectories:YES attributes:nil error:nil];
    }

//    [KSDB createTabel];


}


+(BOOL)isExistFile:(NSString*)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (KSDataCenter *) dataCenter{
    if(_dataCenter==nil){
        _dataCenter = [[KSDataCenter alloc] init];
    }
    return _dataCenter;
}


//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+ (void) end{
    [_dataCenter release];
    [_threadedQueue release];
}
#pragma mark - Notification

+ (void)notify:(NSString *)name object:(id)obj{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:nil];
}

+ (void)notify:(NSString *)name data:(NSDictionary *)data{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:data];
}

+ (void)listen:(NSString *)name target:(id)target selector:(SEL)selector{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:name object:nil];
}

+ (void)unlisten:(id)target{
    [[NSNotificationCenter defaultCenter] removeObserver:target];
}

+ (void)unlisten:(NSString *)name target:(id)target{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:name object:nil];
}
@end
