//
//  AKViewController.h
//  Pods
//
//  Created by 李翔宇 on 3/2/15.
//
//

#import <UIKit/UIKit.h>
#import "AKViewControllerProtocol.h"
#import "UIViewController+AKState.h"

@interface AKViewController : UIViewController <AKViewControllerProtocol>

@property (nonatomic, strong) NSString *ak_backBarButtonItemImage;
@property (nonatomic, strong) NSString *ak_closeBarButtonItemImage;

/*!
 * 是否隐藏导航栏左侧按钮，默认NO
 */
@property (nonatomic, assign, getter = isAk_hideBackBarButtonItem) BOOL ak_hideBackBarButtonItem;

#pragma mark- 配置方法
+ (void)setAk_backgroundColor:(UIColor *)color;
+ (void)setAk_backBarButtonItemImage:(NSString *)imageName;
+ (void)setAk_closeBarButtonItemImage:(NSString *)imageName;

@end
