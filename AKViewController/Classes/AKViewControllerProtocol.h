//
//  AKViewControllerProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/5/9.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AKViewControllerProtocol <NSObject>

@optional

/*!
 * 加载数据
 */
- (void)AKLoadData;

/*!
 * 接收通知
 */
- (void)AKReceiveNotification:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
