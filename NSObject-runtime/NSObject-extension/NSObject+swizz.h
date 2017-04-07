//
//  NSObject+swizz.h
//  NSObject-runtime
//
//  Created by JackyLee on 2017/4/7.
//  Copyright © 2017年 Jacky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (swizz)

/**
 交换方法
 
 @param oriSEL 源方法
 */
+ (void)exchangeMethod:(SEL)oriSEL;

/**
 打印类属性列表
 */
+ (void)printIvarList;

/**
 打印类方法列表
 */
+ (void)printMethodList;

@end
