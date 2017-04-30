//
//  AKViewController.h
//  Pods
//
//  Created by 李翔宇 on 3/2/15.
//
//

#import <UIKit/UIKit.h>
#import "AKViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKViewController : UIViewController <AKViewControllerProtocol>

/**
 是否隐藏导航栏左侧按钮，默认NO
 */
@property (nonatomic, assign, getter = isAk_backBarButtonItemHidden) BOOL ak_backBarButtonItemHidden;

@end

NS_ASSUME_NONNULL_END
