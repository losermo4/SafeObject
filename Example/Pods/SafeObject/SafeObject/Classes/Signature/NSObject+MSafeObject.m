//
//  NSObject+MSafeObject.m
//  SafeObject
//
//  Created by admin on 2021/6/24.
//


#import <MSwizzle/MSwizzle.H>




@implementation NSObject (MSafeObject)
+ (void)load {
    MSwizzleInstanceMethod([self class], @selector(forwardInvocation:), [self class], @selector(safe_forwardInvocation:));
    MSwizzleInstanceMethod([self class], @selector(methodSignatureForSelector:), [self class], @selector(safe_methodSignatureForSelector:));
}
- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [self safe_methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self safe_methodSignatureForSelector:@selector(invocationFailure:)];
    }
    return signature;
}
- (void)invocationFailure:(NSString *)message {
    NSLog(@"Class %@ hasn't Method %@", [self class], message);
}
- (void)safe_forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = anInvocation.selector;
    if (![self respondsToSelector:selector]) {
        anInvocation.selector = @selector(invocationFailure:);
        NSString *message = NSStringFromSelector(selector);
        [anInvocation setArgument:&message atIndex:2];
        [anInvocation invoke];
    }else {
        [self safe_forwardInvocation:anInvocation];
    }
}
@end
