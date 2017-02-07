//
//  AKScrollViewControllerStateProtocol.h
//  Pods
//
//  Created by 李翔宇 on 2017/2/7.
//
//

#import <Foundation/Foundation.h>
#import "AKPullRefreshView.h"
#import "AKPushLoadView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKScrollViewControllerStateProtocol <NSObject>

@property (nonatomic, assign) BOOL ak_startPullRefreshView;
@property (nonatomic, strong, readonly) AKPullRefreshView *ak_pullRefreshView;

@property (nonatomic, assign) BOOL ak_startPushLoadView;
@property (nonatomic, strong, readonly) AKPushLoadView *ak_pushLoadView;

@end

NS_ASSUME_NONNULL_END
