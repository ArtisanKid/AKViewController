//
//  AKPullRefreshView.h
//  Pods
//
//  Created by 李翔宇 on 15/1/6.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, AKPullRefreshState) {
    AKPullRefreshStateNone,
    AKPullRefreshStateNormal,
    AKPullRefreshStateReadyToRefresh,
    AKPullRefreshStateRefreshing,
    AKPullRefreshStateFinishRefresh,
    AKPullRefreshStateNoNetwork,
    AKPullRefreshStatePause //控件暂停使用
};

typedef void (^AKPullRefreshViewTriggerToRefreshBlock)();

NS_ASSUME_NONNULL_BEGIN

@interface AKPullRefreshView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIImageView *iconBackgroundImageView;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *loadActivityIndicatorView;

@property (nonatomic, assign) AKPullRefreshState state;

@property (nonatomic, strong) AKPullRefreshViewTriggerToRefreshBlock triggerToRefreshBlock;

/*!
 * 需要显式启动观察者模式
 */
- (void)startObserver;

/*!
 * 需要显式停止观察者模式
 */
- (void)stopObserver;

#pragma mark- 配置方法
- (void)setBackgroundColor:(UIColor *)color state:(AKPullRefreshState)state;
- (void)setIconImage:(UIImage *)image state:(AKPullRefreshState)state;
- (void)setTitle:(NSString *)title state:(AKPullRefreshState)state;
- (void)setTitleColor:(UIColor *)color state:(AKPullRefreshState)state;

+ (void)setBackgroundColor:(UIColor *)color state:(AKPullRefreshState)state;
+ (void)setIconBackgroundImage:(UIImage *)image;
+ (void)setIconImage:(UIImage *)image state:(AKPullRefreshState)state;
+ (void)setTitle:(NSString *)title state:(AKPullRefreshState)state;
+ (void)setTitleColor:(UIColor *)color state:(AKPullRefreshState)state;
+ (void)setTitleFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
