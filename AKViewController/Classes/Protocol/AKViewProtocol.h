//
//  AKViewProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/9/13.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AKViewProtocol <NSObject>

@optional

/**
 使用object来绘制UIView，object可以为nil
 
 @param object view对应类型对象
 */
- (void)AKDrawContent:(id _Nullable)object;

/**
 计算UIView在指定对象下的大小，object可以为nil

 @param object view对应类型对象
 @return view在object下的大小
 */
+ (CGSize)AKSizeOfContent:(id _Nullable)object;

/**
 UIView最小大小，与内容无关
 
 @return 最小大小
 */
+ (CGSize)AKMinimumSize;

@end

NS_ASSUME_NONNULL_END
