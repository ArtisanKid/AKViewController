//
//  AKViewControllerDataStatusProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/4/1.
//
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "AKLoadStateView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKVCStateProtocol <NSObject>

@required

@property (nonatomic, assign) BOOL ak_startProgressHUD;
@property (nonatomic, strong, readonly) MBProgressHUD *ak_progressHUD;

@property (nonatomic, assign) BOOL ak_startDimProgressHUD;
@property (nonatomic, strong, readonly) MBProgressHUD *ak_dimProgressHUD;

@property (nonatomic, assign) BOOL ak_startLoadStateView;
@property (nonatomic, strong, readonly) AKLoadStateView *ak_loadStateView;

@end

NS_ASSUME_NONNULL_END
