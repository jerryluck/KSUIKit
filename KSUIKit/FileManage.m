//
//  FileManage.m
//  Open+
//
//  Created by jerry gao on 12-10-26.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import "FileManage.h"

static FileManage *_fileMagnage=nil;
@implementation FileManage
+(id)share
{
    if (!_fileMagnage)
    {
        _fileMagnage = [[FileManage alloc] init];
    }
    return _fileMagnage;
}
-(NSString*)documentDirectory
{
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
}
-(BOOL)isExistFile:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        return YES;
    }
    return NO;
}
- (void)writeFile:(NSString*)file dic:(NSDictionary*)dic
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径

    NSString* DocumentDirectory = [self documentDirectory];
    //3、更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[DocumentDirectory stringByExpandingTildeInPath]];
    //4、创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    //    [fileManager removeItemAtPath:@“username” error:nil];
    NSString *path = [DocumentDirectory stringByAppendingPathComponent:file];
    //5、创建数据缓冲区
    //    NSMutableData  *writer = [[NSMutableData alloc] init];
    //6、将字符串添加到缓冲中
    //    [writer appendData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    //7、将其他数据添加到缓冲中
    //将缓冲的数据写入到文件中
    [dic writeToFile:path atomically:YES];
    //    [writer release];
}


- (NSDictionary *)readFile:(NSString*)file
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取路径
    NSString *documentsDirectory = [self documentDirectory];
    
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //获取文件路劲
    NSString* path = [documentsDirectory stringByAppendingPathComponent:file];
    return [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
    
    
}
@end
