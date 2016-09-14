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

- (void)AKDrawView:(id _Nullable)object;

+ (CGSize)AKSizeOfView;
+ (CGSize)AKSizeOfViewWithObject:(id _Nullable)object;

@end

NS_ASSUME_NONNULL_END
