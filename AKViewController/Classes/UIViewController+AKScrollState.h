//
//  UIViewController+AKScrollState.h
//  Pods
//
//  Created by 李翔宇 on 16/4/22.
//
//

#import <UIKit/UIKit.h>
#import "AKScrollViewControllerStateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class AKPullRefreshView;
@class AKPushLoadView;

@interface UIViewController (AKScrollState)<AKScrollViewControllerStateProtocol>

@property (nonatomic, assign) BOOL ak_startPullRefreshView;
@property (nonatomic, strong) AKPullRefreshView *ak_pullRefreshView;

@property (nonatomic, assign) BOOL ak_startPushLoadView;
@property (nonatomic, strong) AKPushLoadView *ak_pushLoadView;

@end

NS_ASSUME_NONNULL_END
