//
//  MSafeObject.m
//  SafeObject
//
//  Created by admin on 2021/6/24.
//

#import "MSafeObject.h"



static NSMutableSet *safeObjectWhiteList;
static NSMutableSet *filterStrings;


static void safeObjectInitialize(void) {
    safeObjectWhiteList = [NSMutableSet new];
    [safeObjectWhiteList addObject:[MSafeObject class]];
    filterStrings = [NSMutableSet setWithObjects:@"_NS", @"__NS" ,@"Proxy", nil];
}



@interface MSafeObject ()
@property (nonatomic, strong) Class cls;
@end

@implementation MSafeObject

+ (void)initialize {
    safeObjectInitialize();
}


+ (instancetype)safeObjectWithClass:(Class)cls {
    return [[self alloc] initWithClass:cls];
}

- (instancetype)initWithClass:(Class)cls {
    self = [super init];
    if (self) {
        self.cls = cls;
    }
    return self;
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self methodSignatureForSelector:@selector(invocationFailure:)];
    }
    return signature;
}

- (void)invocationFailure:(NSString *)message {
    NSLog(@"%@ 没有 %@ 的实现", self.cls, message);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = anInvocation.selector;
    if (![self respondsToSelector:selector]) {
        anInvocation.selector = @selector(invocationFailure:);
        NSString *message = NSStringFromSelector(selector);
        [anInvocation setArgument:&message atIndex:2];
        [anInvocation invoke];
    }else {
        [super forwardInvocation:anInvocation];
    }
}

+ (NSSet *)safeWhiteList {
    return safeObjectWhiteList.copy;
}

+ (void)registerWhiteClasses:(NSArray<Class> *)clses {
    [safeObjectWhiteList addObjectsFromArray:clses];
}


+ (BOOL)filterClass:(Class)cls {
    NSString *name = NSStringFromClass(cls);
    for (NSString *filter in filterStrings.copy) {
        if ([name containsString:filter]) {
            return YES;
        }
    }
    return NO;
}

@end
