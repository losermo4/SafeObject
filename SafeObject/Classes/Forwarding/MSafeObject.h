//
//  MSafeObject.h
//  SafeObject
//
//  Created by admin on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSafeObject : NSObject

+ (instancetype)safeObjectWithClass:(Class)cls;
+ (NSSet *)safeWhiteList;
+ (void)registerWhiteClasses:(NSArray <Class> *)clses;
+ (BOOL)filterClass:(Class)cls;

@end

NS_ASSUME_NONNULL_END
