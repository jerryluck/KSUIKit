//
//  FileManage.h
//  Open+
//
//  Created by jerry gao on 12-10-26.
//  Copyright (c) 2012年 jerry gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManage : NSObject
+(id)share;
-(BOOL)isExistFile:(NSString*)path;
-(NSString*)documentDirectory;
- (NSDictionary *)readFile:(NSString*)file;
- (void)writeFile:(NSString*)file dic:(NSDictionary*)dic;
@end
