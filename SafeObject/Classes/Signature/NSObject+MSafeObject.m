//
//  NSObject+MSafeObject.m
//  SafeObject
//
//  Created by admin on 2021/6/24.
//


#import <MSwizzle/MSwizzle.H>
#import <objc/runtime.h>

@interface NSMethodSignature (MSafeObject)
@property (nonatomic, assign) BOOL isMSafeObjectMethodSignature;
@end
@implementation NSMethodSignature (MSafeObject)
@dynamic isMSafeObjectMethodSignature;
- (void)setIsMSafeObjectMethodSignature:(BOOL)isMSafeObjectMethodSignature {
    objc_setAssociatedObject(self, @selector(isMSafeObjectMethodSignature), @(isMSafeObjectMethodSignature), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isMSafeObjectMethodSignature {
    NSNumber *value = objc_getAssociatedObject(self, @selector(isMSafeObjectMethodSignature));
    return value.boolValue;
}
@end


@implementation NSObject (MSafeObject)
+ (void)load {
    MSwizzleInstanceMethod([self class], @selector(forwardInvocation:), [self class], @selector(safe_forwardInvocation:));
    MSwizzleInstanceMethod([self class], @selector(methodSignatureForSelector:), [self class], @selector(safe_methodSignatureForSelector:));
}
- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self safe_methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self safe_methodSignatureForSelector:@selector(safe_invocationFailure:)];
        signature.isMSafeObjectMethodSignature = YES;
    }
    return signature;
}
- (void)safe_invocationFailure:(NSString *)message {
    NSLog(@"Class %@ hasn't Method %@", [self class], message);
}
- (void)safe_forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.methodSignature.isMSafeObjectMethodSignature) {
        NSString *message = NSStringFromSelector(anInvocation.selector);
        anInvocation.selector = @selector(safe_invocationFailure:);
        [anInvocation setArgument:&message atIndex:2];
        [anInvocation invoke];
    }else {
        [self safe_forwardInvocation:anInvocation];
    }
}
@end
