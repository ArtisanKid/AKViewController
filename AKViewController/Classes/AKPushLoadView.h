//
//  AKPushLoadView.h
//  Pods
//
//  Created by 李翔宇 on 6/29/15.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, AKPushLoadState) {
    AKPushLoadStateNormal,
    AKPushLoadStateReadyToLoad,
    AKPushLoadStateLoading,
    AKPushLoadStateFinishLoad,
    AKPushLoadStateNoMoreData,
    AKPushLoadStateNoNetwork,
    AKPushLoadStatePause //控件暂停使用
};

typedef void (^AKPushLoadViewTriggerToLoadBlock)();

NS_ASSUME_NONNULL_BEGIN

@interface AKPushLoadView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *loadActivityIndicatorView;

@property (nonatomic, assign) AKPushLoadState state;

@property (nonatomic, strong) AKPushLoadViewTriggerToLoadBlock triggerToLoadBlock;

/*!
 * 需要显式启动观察者模式
 */
- (void)startObserver;

/*!
 * 需要显式停止观察者模式
 */
- (void)stopObserver;

#pragma mark- 配置方法
- (void)setBackgroundColor:(UIColor *)color state:(AKPushLoadState)state;

- (void)setTitle:(NSString *)title state:(AKPushLoadState)state;
- (void)setTitleColor:(UIColor *)color state:(AKPushLoadState)state;

+ (void)setBackgroundColor:(UIColor *)color state:(AKPushLoadState)state;

+ (void)setTitle:(NSString *)title state:(AKPushLoadState)state;
+ (void)setTitleColor:(UIColor *)color state:(AKPushLoadState)state;
+ (void)setTitleFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
