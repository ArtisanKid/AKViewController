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
- (void)AKDrawCell:(id _Nullable)object;

+ (CGFloat)AKHeightOfCell;
+ (CGFloat)AKHeightOfCellWithObject:(id _Nullable)object;

//Cell在使用自动高度的时候，最小高度
+ (CGFloat)AKMinimumHeightOfCell;

@end

NS_ASSUME_NONNULL_END
