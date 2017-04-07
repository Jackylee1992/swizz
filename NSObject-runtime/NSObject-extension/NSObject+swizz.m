//
//  NSObject+swizz.m
//  NSObject-runtime
//
//  Created by JackyLee on 2017/4/7.
//  Copyright © 2017年 Jacky Lee. All rights reserved.
//

#import "NSObject+swizz.h"
#import <objc/runtime.h>

/**
 编码值      |  含意
 ----------- | -------------
 c          |  代表char类型
 i          |  代表int类型
 s          |  代表short类型
 l          |  代表long类型，在64位处理器上也是按照32位处理
 q          |  代表long long类型
 C          |  代表unsigned char类型
 I          |  代表unsigned int类型
 S          |  代表unsigned short类型
 L          |  代表unsigned long类型
 Q          |  代表unsigned long long类型
 f          |  代表float类型
 d          |  代表double类型
 B          |  代表C++中的bool或者C99中的_Bool
 v          |  代表void类型
 *          |  代表char *类型
 @          |  代表对象类型
 \#          |  代表类对象 (Class)
 :          |  代表方法selector (SEL)
 [arraytype]|  代表array
 {name=type...}| 代表结构体
 (name=type...)| 代表union
 bnum          | A bitfieldofnumbits
 ^type        | A pointertotype
 ?            | An unknowntype (amongotherthings, thiscodeisusedforfunctionpointers)
 
 */


@implementation NSObject (swizz)

+ (void)exchangeMethod:(SEL)oriSEL {
    Method oriMethod = class_getInstanceMethod([self class], oriSEL);
    Method newMethod = class_getInstanceMethod([self class], NSSelectorFromString([@"xy_" stringByAppendingString:NSStringFromSelector(oriSEL)]));
    method_exchangeImplementations(oriMethod, newMethod);
}

+ (void)printIvarList {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"ivar: %s class: %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
}

+ (void)printMethodList {
    unsigned int count = 0;
    Method *methods = class_copyMethodList(self, &count);
    for (int i = 0; i < count; i++) {
        // 方法名
        Method method = methods[i];
        const char * mName = sel_getName(method_getName(method));
        
        // 参数
        unsigned int argCount = method_getNumberOfArguments(method);
        NSMutableString *arguStr = [NSMutableString string];
        for (int j = 2; j < argCount; j++) {
            [arguStr appendFormat:@"参数%zd %s ", j-1, method_copyArgumentType(method, j)];
        }
        
        // 返回值
        const char *returnType = method_copyReturnType(method);
        
        NSLog(@"方法: %s (%@) return: %s ", mName, arguStr, returnType);
    }
}



@end
