//
//  AKLoadStatusView.h
//  Pods
//
//  Created by 李翔宇 on 15/1/9.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, AKLoadState) {
    AKLoadStateNormal,       //获取数据
    AKLoadStateNoNetwork,    //网络断开
    AKLoadStateNetworkError, //网络错误
    AKLoadStateCustomError,  //自定义错误
    AKLoadStateDataLoading,  //正在加载数据
    AKLoadStateDataEmpty     //暂无数据
};

NS_ASSUME_NONNULL_BEGIN

@interface AKLoadStateView : UIView

@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;
@property (nonatomic, strong, readonly) UIButton *refreshButton;

@property (nonatomic, assign) AKLoadState state;
@property (nonatomic, strong) void (^touchUpInsideBlock)();
/**
 *  点击重新加载
 */
@property (nonatomic, assign, getter=isHideRefreshButton) BOOL hideRefreshButton;

- (void)setBackgroundColor:(UIColor *)color state:(AKLoadState)state;
- (void)setImage:(UIImage *)image state:(AKLoadState)state;

- (void)setTitle:(NSString *)title state:(AKLoadState)state;
- (void)setTitleColor:(UIColor *)color state:(AKLoadState)state;

- (void)setDetail:(NSString *)detail state:(AKLoadState)state;
- (void)setDetailColor:(UIColor *)color state:(AKLoadState)state;

- (void)setRefreshButtonColor:(UIColor *)color state:(AKLoadState)state;
- (void)setRefreshButtonTitle:(NSString *)title state:(AKLoadState)state;
- (void)setRefreshButtonTitleColor:(UIColor *)color state:(AKLoadState)state;

#pragma mark- 配置方法
+ (void)setBackgroundColor:(UIColor *)color state:(AKLoadState)state;
+ (void)setImage:(UIImage *)image state:(AKLoadState)state;

+ (void)setTitle:(NSString *)title state:(AKLoadState)state;
+ (void)setTitleColor:(UIColor *)color state:(AKLoadState)state;
+ (void)setTitleFont:(UIFont *)font;

+ (void)setDetail:(NSString *)detail state:(AKLoadState)state;
+ (void)setDetailColor:(UIColor *)color state:(AKLoadState)state;
+ (void)setDetailFont:(UIFont *)font;

+ (void)setRefreshButtonColor:(UIColor *)color state:(AKLoadState)state;
+ (void)setRefreshButtonTitle:(NSString *)title state:(AKLoadState)state;
+ (void)setRefreshButtonTitleColor:(UIColor *)color state:(AKLoadState)state;
+ (void)setRefreshButtonFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
