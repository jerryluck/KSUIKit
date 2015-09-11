

#import <Foundation/Foundation.h>

@interface KSSafeCategory : NSObject

@property(nonatomic,assign) BOOL enableCrashLogAlert; // 发送crash时弹出提示框


+(KSSafeCategory*)shareInstance;

+(void)callSafeCategory;


@end
