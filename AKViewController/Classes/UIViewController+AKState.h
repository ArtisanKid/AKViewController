//
//  UIViewController+AKState.h
//  Pods
//
//  Created by 李翔宇 on 16/4/22.
//
//

#import <UIKit/UIKit.h>
#import "AKViewControllerStateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AKState) <AKViewControllerStateProtocol>

@property (nonatomic, assign) BOOL ak_startProgressHUD;
@property (nonatomic, strong, readonly) MBProgressHUD *ak_progressHUD;
@property (nonatomic, assign) BOOL ak_startDimProgressHUD;
@property (nonatomic, strong, readonly) MBProgressHUD *ak_dimProgressHUD;

@property (nonatomic, assign) BOOL ak_startLoadStateView;
@property (nonatomic, strong, readonly) AKLoadStateView *ak_loadStateView;

@end

NS_ASSUME_NONNULL_END
