
#import "KSSafeCategory.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>


#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)	\
if (ERROR_VAR) {	\
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1	\
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}
#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

#if OBJC_API_VERSION >= 2
#define GetClass(obj)	object_getClass(obj)
#else
#define GetClass(obj)	(obj ? obj->isa : Nil)
#endif


#define LOG_Error {if(error)NSLog(@"%@",error.debugDescription);error = nil;}

@interface KSSafeCategory()

- (void)showAlertTitle:(NSString*)title message:(NSString*)message;

- (void)showCallStackSymbols;

@end

static KSSafeCategory *safe = nil;

@interface NSObject (JRSwizzle)

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)jr_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;

@end


@interface NSArray(KSSafeCategory)
-(id)SY_safeObjectAtIndex:(int)index;
-(id)SY_safeInitWithObjects:(const id [])objects count:(NSUInteger)cnt;
@end
@interface NSMutableArray(KSSafeCategory)
-(void)SY_safeAddObject:(id)anObject;
@end

@interface NSDictionary(KSSafeCategory)
-(id)SY_safeObjectForKey:(id)aKey;
@end
@interface NSMutableDictionary(KSSafeCategory)
-(void)SY_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end

@implementation NSArray(KSSafeCategory)
-(id)SY_safeObjectAtIndex:(int)index{
    
    @autoreleasepool {
        if(index>=0 && index < self.count)
        {
            return [self SY_safeObjectAtIndex:index];
        }
        
        
        [safe showCallStackSymbols];
        
        
        return nil;
    }
    

}
-(id)SY_safeInitWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    @autoreleasepool {
        for (int i=0; i<cnt; i++) {
            if(objects[i] == nil)
            {
                [safe showCallStackSymbols];
                
                return nil;
                
                
            }
            
            
            
        }
        
        return [self SY_safeInitWithObjects:objects count:cnt];
    }
    

}
@end

@implementation NSMutableArray(KSSafeCategory)
-(void)SY_safeAddObject:(id)anObject
{
    @autoreleasepool {
        if(anObject != nil){
            [self SY_safeAddObject:anObject];
        }
        else
        {
            [safe showCallStackSymbols];
        }
    }

}
@end

@implementation NSDictionary(KSSafeCategory)
-(id)SY_safeObjectForKey:(id)aKey
{
    if(aKey == nil)
    {
        [safe showCallStackSymbols];
        return nil;

    }
    id value = [self SY_safeObjectForKey:aKey];
//    if (value == [NSNull null]) {
//		return nil;
//	}
    return value;
}
@end

@implementation NSMutableDictionary(KSSafeCategory)
-(void)SY_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if(anObject == nil || aKey == nil)
    {
        [safe showCallStackSymbols];
        return ;
    }
    
    [self SY_safeSetObject:anObject forKey:aKey];
}
@end

@interface NSURL(KSSafeCategory)
@end;
@implementation NSURL(KSSafeCategory)
+(id)SY_safeFileURLWithPath:(NSString *)path isDirectory:(BOOL)isDir
{
    if(path == nil)
    {
        [safe showCallStackSymbols];
        return nil;
    }
    
    return [self SY_safeFileURLWithPath:path isDirectory:isDir];
}
@end
@interface NSFileManager(KSSafeCategory)

@end
@implementation NSFileManager(KSSafeCategory)
-(NSDirectoryEnumerator *)SY_safeEnumeratorAtURL:(NSURL *)url includingPropertiesForKeys:(NSArray *)keys options:(NSDirectoryEnumerationOptions)mask errorHandler:(BOOL (^)(NSURL *, NSError *))handler
{
    if(url == nil)
    {
       [safe showCallStackSymbols];
        return nil;
    }
    return [self SY_safeEnumeratorAtURL:url includingPropertiesForKeys:keys options:mask errorHandler:handler];
}
@end


@implementation NSObject (JRSwizzle)

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_ {
#if OBJC_API_VERSION >= 2
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
#else
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self className]);
#endif
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self class]);
#else
        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self className]);
#endif
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    return YES;
#else
    //	Scan for non-inherited methods.
    Method directOriginalMethod = NULL, directAlternateMethod = NULL;
    
    void *iterator = NULL;
    struct objc_method_list *mlist = class_nextMethodList(self, &iterator);
    while (mlist) {
        int method_index = 0;
        for (; method_index < mlist->method_count; method_index++) {
            if (mlist->method_list[method_index].method_name == origSel_) {
                assert(!directOriginalMethod);
                directOriginalMethod = &mlist->method_list[method_index];
            }
            if (mlist->method_list[method_index].method_name == altSel_) {
                assert(!directAlternateMethod);
                directAlternateMethod = &mlist->method_list[method_index];
            }
        }
        mlist = class_nextMethodList(self, &iterator);
    }
    
    //	If either method is inherited, copy it up to the target class to make it non-inherited.
    if (!directOriginalMethod || !directAlternateMethod) {
        Method inheritedOriginalMethod = NULL, inheritedAlternateMethod = NULL;
        if (!directOriginalMethod) {
            inheritedOriginalMethod = class_getInstanceMethod(self, origSel_);
            if (!inheritedOriginalMethod) {
                SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self className]);
                return NO;
            }
        }
        if (!directAlternateMethod) {
            inheritedAlternateMethod = class_getInstanceMethod(self, altSel_);
            if (!inheritedAlternateMethod) {
                SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self className]);
                return NO;
            }
        }
        
        int hoisted_method_count = !directOriginalMethod && !directAlternateMethod ? 2 : 1;
        struct objc_method_list *hoisted_method_list = malloc(sizeof(struct objc_method_list) + (sizeof(struct objc_method)*(hoisted_method_count-1)));
        hoisted_method_list->obsolete = NULL;	// soothe valgrind - apparently ObjC runtime accesses this value and it shows as uninitialized in valgrind
        hoisted_method_list->method_count = hoisted_method_count;
        Method hoisted_method = hoisted_method_list->method_list;
        
        if (!directOriginalMethod) {
            bcopy(inheritedOriginalMethod, hoisted_method, sizeof(struct objc_method));
            directOriginalMethod = hoisted_method++;
        }
        if (!directAlternateMethod) {
            bcopy(inheritedAlternateMethod, hoisted_method, sizeof(struct objc_method));
            directAlternateMethod = hoisted_method;
        }
        class_addMethods(self, hoisted_method_list);
    }
    
    //	Swizzle.
    IMP temp = directOriginalMethod->method_imp;
    directOriginalMethod->method_imp = directAlternateMethod->method_imp;
    directAlternateMethod->method_imp = temp;
    
    return YES;
#endif
}

+ (BOOL)jr_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_ {
    return [GetClass((id)self) jr_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

@end



@implementation KSSafeCategory


+(KSSafeCategory*)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
    
        if (!safe)
        {
            safe = [[KSSafeCategory alloc] init];
        }
    
    });
    
    return safe;
}


+(void)callSafeCategory
{
    NSError* error = nil;
    [objc_getClass("__NSPlaceholderArray") jr_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(SY_safeInitWithObjects:count:) error:&error];
    LOG_Error
    
    [objc_getClass("__NSArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(SY_safeObjectAtIndex:) error:&error];
    LOG_Error
    
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(SY_safeObjectAtIndex:) error:&error];
    LOG_Error
    [objc_getClass("__NSArrayM") jr_swizzleMethod:@selector(addObject:) withMethod:@selector(SY_safeAddObject:) error:&error];
    LOG_Error
    
    [objc_getClass("__NSDictionaryI") jr_swizzleMethod:@selector(objectForKey:) withMethod:@selector(SY_safeObjectForKey:) error:&error];
    LOG_Error
    
    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(objectForKey:) withMethod:@selector(SY_safeObjectForKey:) error:&error];
    LOG_Error
    [objc_getClass("__NSDictionaryM") jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(SY_safeSetObject:forKey:) error:&error];
    LOG_Error
    
    
    [NSURL jr_swizzleClassMethod:@selector(fileURLWithPath:isDirectory:) withClassMethod:@selector(SY_safeFileURLWithPath:isDirectory:) error:&error];
    LOG_Error
    
    [NSFileManager jr_swizzleMethod:@selector(enumeratorAtURL:includingPropertiesForKeys:options:errorHandler:) withMethod:@selector(SY_safeEnumeratorAtURL:includingPropertiesForKeys:options:errorHandler:) error:&error];
    LOG_Error
}

- (void)showCallStackSymbols
{
    NSArray *syms = [NSThread  callStackSymbols];
    if ([syms count] > 1) {
        if (safe.enableCrashLogAlert)
        {
            [safe showAlertTitle:[NSString stringWithFormat:@"[%@ %@]",[self class],NSStringFromSelector(_cmd)] message:[syms description]];
        }
    } else {
        if (safe.enableCrashLogAlert)
        {
            [safe showAlertTitle:[NSString stringWithFormat:@"%@",[self class]] message:NSStringFromSelector(_cmd)];
        }
    }
}

- (void)showAlertTitle:(NSString*)title message:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end

