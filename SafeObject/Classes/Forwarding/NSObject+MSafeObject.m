//
//  NSObject+MSafeObject.m
//  SafeObject
//
//  Created by admin on 2021/6/24.
//


#import <MSwizzle/MSwizzle.H>
#import <objc/runtime.h>
#import "MSafeObject.h"


static void *kForwardingObjectKey;

@implementation NSObject (MSafeObject)

+ (void)load {
    MSwizzleInstanceMethod([self class], @selector(forwardingTargetForSelector:), [self class], @selector(safe_forwardingTargetForSelector:));
}




- (id)safe_forwardingTargetForSelector:(SEL)aSelector {
    id object = [self safe_forwardingTargetForSelector:aSelector];
    if ([[MSafeObject safeWhiteList] containsObject:[self class]] || [MSafeObject filterClass:[self class]]) {
        return object;
    }
    if (!object) {
        object = objc_getAssociatedObject(self, &kForwardingObjectKey);
        if (!object) {
            object = [MSafeObject safeObjectWithClass:[self class]];
            objc_setAssociatedObject(self, &kForwardingObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return object;
}


@end
