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

/**
 加载数据
 */
- (void)AKLoadData;

/**
 接收数据
 
 @param data NSDictionary
 */
- (void)AKReceiveData:(NSDictionary *)data;

/**
 接收通知

 @param notification NSNotification
 */
- (void)AKReceiveNotification:(NSNotification *)notification;

/**
 接收消息

 @param message NSDictionary
 */
- (void)AKReceiveMessage:(NSDictionary *)message;

@end

NS_ASSUME_NONNULL_END
