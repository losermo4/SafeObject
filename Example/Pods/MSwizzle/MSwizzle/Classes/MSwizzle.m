//
//  MSwizzle.m
//  Expecta
//
//  Created by gaomin on 2019/3/25.
//

#import "MSwizzle.h"
#import <objc/runtime.h>

void MSwizzleInstanceMethod(Class originalCls, SEL originalSelector, Class swizzledCls, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalCls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledCls, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(originalCls,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(originalCls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


void MSwizzleClassMethod(Class originalCls, SEL originalSelector, Class swizzledCls, SEL swizzledSelector) {
    
    MSwizzleInstanceMethod(object_getClass(originalCls), originalSelector, object_getClass(swizzledCls), swizzledSelector);
    
}
