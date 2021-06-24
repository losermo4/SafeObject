//
//  MSwizzle.h
//  Expecta
//
//  Created by gaomin on 2019/3/25.
//

#import <Foundation/Foundation.h>


extern void MSwizzleInstanceMethod(Class originalCls, SEL originalSelector, Class swizzledCls, SEL swizzledSelector);

extern void MSwizzleClassMethod(Class originalCls, SEL originalSelector, Class swizzledCls, SEL swizzledSelector);
