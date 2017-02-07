//
//  AKTableViewCellProtocol.h
//  Pods
//
//  Created by 李翔宇 on 15/5/4.
//
//

#import <Foundation/Foundation.h>
#import "AKViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewCellProtocol<AKViewProtocol>

@optional

/**
 计算UITableViewCell在指定对象下的高度，object可以为nil

 @param object cell对应类型对象
 @return cell在object下的高度
 */
+ (CGFloat)AKHeightOfContent:(id _Nullable)object;

/**
 UITableViewCell最小高度，与内容无关

 @return 最小高度
 */
+ (CGFloat)AKMinimumHeight;

@end

NS_ASSUME_NONNULL_END
