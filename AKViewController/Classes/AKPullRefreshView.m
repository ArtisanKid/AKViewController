//
//  AKPullRefreshView.m
//  Pods
//
//  Created by 李翔宇 on 15/1/6.
//
//

#import "AKPullRefreshView.h"
#import <libkern/OSAtomic.h>
#import <Masonry/Masonry.h>
#import <KVOController/KVOController.h>
#import <Reachability/Reachability.h>

#define AKPullRefreshViewRefreshTriggerHeight 68.
#define AKPullRefreshViewRefreshHeight 60.
#define AKPullRefreshViewTitleBottomToBottom 24.

@interface AKPullRefreshView ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *backgroundColorDicM;
@property (nonatomic, strong) NSString *iconBackgroundImage;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIImage *> *iconImageDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *titleDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *titleColorDicM;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UIImageView *iconBackgroundImageView;
@property (nonatomic, strong, readwrite) UIImageView *iconImageView;
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *loadActivityIndicatorView;

@property (nonatomic, assign) CGFloat baseContentInsetTop;//初始状态的ContentInset.Top
@property (nonatomic, assign) CGFloat iconFullRate;//热气球填充速率

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation AKPullRefreshView

#pragma mark - 生命周期
- (instancetype)init {
    self = [super init];
    if (self) {
        /**
         *  初始化赋值
         */
        _backgroundColorDicM = [[[self class] backgroundColorDicM] mutableCopy];
        _iconImageDicM = [[[self class] iconImageDicM] mutableCopy];
        _titleDicM = [[[self class] titleDicM] mutableCopy];
        _titleColorDicM = [[[self class] titleColorDicM] mutableCopy];
        
        ///////////////////////////////////
        
        self.backgroundColor = _backgroundColorDicM[@(AKPullRefreshStateNormal)];
        
        UIView *containerView = ({
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            
            //icon大小为27*22
            
            _iconBackgroundImageView = [[UIImageView alloc] init];
            _iconBackgroundImageView.image = AKPullRefreshView_IconBackgroundImage;
            [view addSubview:_iconBackgroundImageView];
            
            _iconImageView = [[UIImageView alloc] init];
            _iconImageView.image = [UIImage imageNamed:_iconImageDicM[@(AKPullRefreshStateNormal)]];
            _iconImageView.contentMode = UIViewContentModeBottom;
            _iconImageView.clipsToBounds = YES;
            [view addSubview:_iconImageView];
            
            _loadActivityIndicatorView = [[UIActivityIndicatorView alloc] init];
            _loadActivityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            _loadActivityIndicatorView.hidesWhenStopped = YES;
            [view addSubview:_loadActivityIndicatorView];
            _loadActivityIndicatorView.hidden = YES;
            
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.font = AKPullRefreshView_TitleFont;
            _titleLabel.textColor = _titleColorDicM[@(AKPullRefreshStateNormal)];
            _titleLabel.text = _titleDicM[@(AKPullRefreshStateNormal)];
            [view addSubview:_titleLabel];
            
            MASAttachKeys(self, _iconBackgroundImageView, _iconImageView, _titleLabel, _loadActivityIndicatorView);
            
            [_iconBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(27.).priorityHigh();
                make.height.mas_equalTo(22.).priorityHigh();
                make.top.mas_equalTo(0.);
                make.bottom.mas_equalTo(0.);
                make.leading.mas_equalTo(0.);
            }];
            
            [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(27.);
                make.height.mas_equalTo(0.);
                make.centerX.mas_equalTo(_iconBackgroundImageView);
                make.bottom.mas_equalTo(0.);
            }];
            
            [_loadActivityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(_iconBackgroundImageView);
            }];
            
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0.);
                make.leading.mas_equalTo(_iconBackgroundImageView.mas_trailing).offset(10.);
                make.trailing.mas_equalTo(0.);
            }];
            
            view;
        }); 
        
        /////////////////////////////////////
        
        MASAttachKeys(self, containerView);
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0.);
            make.bottom.mas_equalTo(-18.);
        }];
        
        /////////////////////////////////////
        
        //图标填充速率。从文字显示出来开始填充icon
        _iconFullRate = 22. / (AKPullRefreshViewRefreshTriggerHeight - AKPullRefreshViewTitleBottomToBottom);
        
        _reachability = [Reachability reachabilityWithHostName:@"http://www.apple.com"];
        __weak typeof(self) weak_self = self;
        [_reachability setReachableBlock:^(Reachability * reachability) {
            __strong typeof(weak_self) strong_self = weak_self;
            if(strong_self.state == AKPullRefreshStateNoNetwork) {
                strong_self.state = AKPullRefreshStateNormal;
            }
        }];
        [_reachability setUnreachableBlock:^(Reachability * reachability) {
            __strong typeof(weak_self) strong_self = weak_self;
            if(strong_self.state == AKPullRefreshStateNormal) {
                strong_self.state = AKPullRefreshStateNoNetwork;
            }
        }];
        [_reachability startNotifier];
    }
    return self;
}

#pragma mark - 属性方法
- (NSMutableDictionary *)backgroundColorDicM {
    if(!_backgroundColorDicM) {
        _backgroundColorDicM = [NSMutableDictionary dictionary];
    };
    return _backgroundColorDicM;
}

- (NSMutableDictionary *)iconImageDicM {
    if(!_iconImageDicM) {
        _iconImageDicM = [NSMutableDictionary dictionary];
    }
    return _iconImageDicM;
}

- (NSMutableDictionary *)titleDicM {
    if(!_titleDicM) {
        _titleDicM = [NSMutableDictionary dictionary];
    }
    return _titleDicM;
}

- (NSMutableDictionary *)titleColorDicM {
    if(!_titleColorDicM) {
        _titleColorDicM = [NSMutableDictionary dictionary];
    }
    return _titleColorDicM;
}

+ (NSMutableDictionary *)backgroundColorDicM {
    static NSMutableDictionary<NSNumber *, NSString *> *_backgroundColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _backgroundColorDicM = [@{@(AKPullRefreshStateNormal) : [UIColor whiteColor],
                                  @(AKPullRefreshStateReadyToRefresh) : [UIColor whiteColor],
                                  @(AKPullRefreshStateRefreshing) : [UIColor whiteColor],
                                  @(AKPullRefreshStateFinishRefresh) : [UIColor whiteColor],
                                  @(AKPullRefreshStateNoNetwork) : [UIColor whiteColor],
                                  @(AKPullRefreshStatePause) : [UIColor whiteColor]} mutableCopy];
    });
    return _backgroundColorDicM;
}

+ (NSMutableDictionary *)iconImageDicM {
    static NSMutableDictionary<NSNumber *, NSString *> *_imageDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageDicM = [NSMutableDictionary dictionary];
    });
    return _imageDicM;
}

+ (NSMutableDictionary *)titleDicM {
    static NSMutableDictionary<NSNumber *, NSString *> *_titleDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _titleDicM = [@{@(AKPullRefreshStateNormal) : @"下拉刷新",
                        @(AKPullRefreshStateReadyToRefresh) : @"释放刷新",
                        @(AKPullRefreshStateRefreshing) : @"正在刷新...",
                        @(AKPullRefreshStateFinishRefresh) : @"刷新完成",
                        @(AKPullRefreshStateNoNetwork) : @"网络不可用",
                        @(AKPullRefreshStatePause) : @"当前不可刷新"} mutableCopy];
    });
    return _titleDicM;
}

+ (NSMutableDictionary *)titleColorDicM {
    static NSMutableDictionary<UIColor *, NSString *> *_titleColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _titleColorDicM = [@{@(AKPullRefreshStateNormal) : [UIColor darkGrayColor],
                             @(AKPullRefreshStateReadyToRefresh) : [UIColor darkGrayColor],
                             @(AKPullRefreshStateRefreshing) : [UIColor darkGrayColor],
                             @(AKPullRefreshStateFinishRefresh) : [UIColor darkGrayColor],
                             @(AKPullRefreshStateNoNetwork) : [UIColor darkGrayColor],
                             @(AKPullRefreshStatePause) : [UIColor darkGrayColor]} mutableCopy];
    });
    return _titleColorDicM;
}

#pragma mark- 私有方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.state == AKPullRefreshStateRefreshing ||
            self.state == AKPullRefreshStateNoNetwork ||
            self.state == AKPullRefreshStatePause) {
            return;
        }
        
        //contentOffset负数值表示下拉
        //contentOffset.y的初始值为baseContentInsetTop的负值，比如-64.
        CGPoint contentOffset;
        [change[@"new"] getValue:&contentOffset];
        
        //计算scrollView下拉漏出的高度
        CGFloat offsetChange = (- contentOffset.y) - self.baseContentInsetTop;
        
        //表示非下拉状态
        if(offsetChange <= 0) {
            return;
        }
        
        if (offsetChange >= AKPullRefreshViewTitleBottomToBottom) {
            //当前设定为露出文字开始填充热气球
            CGRect frame = self.iconImageView.frame;
            frame.origin.y = (frame.origin.y + frame.size.height) - (offsetChange - AKPullRefreshViewTitleBottomToBottom) * self.iconFullRate;
            frame.size.height = (offsetChange - AKPullRefreshViewTitleBottomToBottom) * _iconFullRate;
            if(frame.size.height <= 22.) {
                self.iconImageView.frame = frame;
            }
        }
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        if (scrollView.isTracking) {
            //isDragging=YES表示用户还在往下拉
            if (offsetChange >= AKPullRefreshViewRefreshTriggerHeight) {
                self.iconImageView.frame = self.iconBackgroundImageView.frame;
                self.state = AKPullRefreshStateReadyToRefresh;
            } else {
                self.state = AKPullRefreshStateNormal;
            }
        } else {
            //isDragging=NO表示用户已经松手了
            //如果当前状态为AKPullRefreshStateReadyToRefresh，说明已经触发过刷新
            if (self.state == AKPullRefreshStateReadyToRefresh) {
                self.state = AKPullRefreshStateRefreshing;
            }
        }
        
        if(scrollView.isDragging) {
            if (self.state == AKPullRefreshStateNone) {
                self.state = AKPullRefreshStateNormal;
            }
        }
    } else if ([keyPath isEqualToString:@"contentInset"]) {
        if (self.state != AKPullRefreshStateNone) {
            return;
        }
        
        //contentInset正数值表示内缩
        UIEdgeInsets contentInset;
        [change[@"new"] getValue:&contentInset];
        self.baseContentInsetTop = contentInset.top;
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        
        //不管当前什么状态，只要contentSize有变化，那么总是让控件的y处在一个刚刚好的位置
        CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
        CGRect frame = CGRectMake(0., -screenHeight, CGRectGetWidth([UIScreen mainScreen].bounds), screenHeight);
        self.frame = frame;
    }
}

#pragma mark- 配置方法
- (void)setBackgroundColor:(UIColor *)color state:(AKPullRefreshState)state {
    self.backgroundColorDicM[@(state)] = color;
    if(self.state == state) {
        self.backgroundColor = color;
    }
    
    if(state == AKPullRefreshStateNormal) {
        self.backgroundColorDicM[@(AKPullRefreshStateReadyToRefresh)] = color;
        self.backgroundColorDicM[@(AKPullRefreshStateRefreshing)] = color;
        self.backgroundColorDicM[@(AKPullRefreshStateFinishRefresh)] = color;
        self.backgroundColorDicM[@(AKPullRefreshStateNoNetwork)] = color;
        self.backgroundColorDicM[@(AKPullRefreshStatePause)] = color;
    }
}
- (void)setIconImage:(UIImage *)image state:(AKPullRefreshState)state {
    self.iconImageDicM[@(state)] = image;
    if(self.state == state) {
        self.iconImageView.image = image;
    }
}

- (void)setTitle:(NSString *)title state:(AKPullRefreshState)state {
    self.titleDicM[@(state)] = title;
    if(self.state == state) {
        self.titleLabel.text = title;
    }
}
- (void)setTitleColor:(UIColor *)color state:(AKPullRefreshState)state {
    self.titleColorDicM[@(state)] = color;
    if(self.state == state) {
        self.titleLabel.textColor = color;
    }
    
    if(state == AKPullRefreshStateNormal) {
        self.titleColorDicM[@(AKPullRefreshStateReadyToRefresh)] = color;
        self.titleColorDicM[@(AKPullRefreshStateRefreshing)] = color;
        self.titleColorDicM[@(AKPullRefreshStateFinishRefresh)] = color;
        self.titleColorDicM[@(AKPullRefreshStateNoNetwork)] = color;
        self.titleColorDicM[@(AKPullRefreshStatePause)] = color;
    }
}

+ (void)setBackgroundColor:(UIColor *)color state:(AKPullRefreshState)state {
    NSMutableDictionary *backgroundColorDicM = [self backgroundColorDicM];
    
    backgroundColorDicM[@(state)] = color;
    if(state == AKPullRefreshStateNormal) {
        backgroundColorDicM[@(AKPullRefreshStateReadyToRefresh)] = color;
        backgroundColorDicM[@(AKPullRefreshStateRefreshing)] = color;
        backgroundColorDicM[@(AKPullRefreshStateFinishRefresh)] = color;
        backgroundColorDicM[@(AKPullRefreshStateNoNetwork)] = color;
        backgroundColorDicM[@(AKPullRefreshStatePause)] = color;
    }
}

UIImage *AKPullRefreshView_IconBackgroundImage = nil;
+ (void)setIconBackgroundImage:(UIImage *)image {
    AKPullRefreshView_IconBackgroundImage = image;
}

+ (void)setImage:(NSString *)imageName state:(AKPullRefreshState)state {
    NSMutableDictionary *iconImageDicM = [self iconImageDicM];
    
    iconImageDicM[@(state)] = imageName;
    if(state == AKPullRefreshStateNormal) {
        iconImageDicM[@(AKPullRefreshStateReadyToRefresh)] = imageName;
        iconImageDicM[@(AKPullRefreshStateRefreshing)] = imageName;
        iconImageDicM[@(AKPullRefreshStateFinishRefresh)] = imageName;
        iconImageDicM[@(AKPullRefreshStateNoNetwork)] = imageName;
        iconImageDicM[@(AKPullRefreshStatePause)] = imageName;
    }
}

+ (void)setTitle:(NSString *)title state:(AKPullRefreshState)state {
    [self titleDicM][@(state)] = title;
}

+ (void)setTitleColor:(UIColor *)color state:(AKPullRefreshState)state {
    NSMutableDictionary *titleColorDicM = [self titleColorDicM];
    
    titleColorDicM[@(state)] = color;
    if(state == AKPullRefreshStateNormal) {
        titleColorDicM[@(AKPullRefreshStateReadyToRefresh)] = color;
        titleColorDicM[@(AKPullRefreshStateRefreshing)] = color;
        titleColorDicM[@(AKPullRefreshStateFinishRefresh)] = color;
        titleColorDicM[@(AKPullRefreshStateNoNetwork)] = color;
        titleColorDicM[@(AKPullRefreshStatePause)] = color;
    }
}

UIFont *AKPullRefreshView_TitleFont = nil;
+ (void)setTitleFont:(UIFont *)font {
    AKPullRefreshView_TitleFont = font;
}

#pragma mark - 公开
- (void)setState:(AKPullRefreshState)state {
    if(_state == state) {
        return;
    }
    
    _state = state;
    
    //处理内容变更
    self.iconImageView.image = self.iconImageDicM[@(_state)];
    self.titleLabel.textColor = self.titleColorDicM[@(_state)];
    self.titleLabel.text = self.titleDicM[@(_state)];
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    
    switch (_state) {
        case AKPullRefreshStateNormal: {
            self.iconBackgroundImageView.hidden = NO;
            self.iconImageView.hidden = NO;
            [self.loadActivityIndicatorView stopAnimating];
            self.loadActivityIndicatorView.hidden = YES;
            
            [UIView animateWithDuration:.2f animations:^{
                UIEdgeInsets insets = scrollView.contentInset;
                insets.top = self.baseContentInsetTop;
                scrollView.contentInset = insets;
            } completion:^(BOOL finished) {}];
            break;
        }
            
        case AKPullRefreshStateReadyToRefresh: { break; }
            
        case AKPullRefreshStateRefreshing: {
            self.iconBackgroundImageView.hidden = YES;
            self.iconImageView.hidden = YES;
            self.loadActivityIndicatorView.hidden = NO;
            [self.loadActivityIndicatorView startAnimating];
            
            UIEdgeInsets insets = scrollView.contentInset;
            insets.top = fabs(scrollView.contentOffset.y);
            scrollView.contentInset = insets;
            
            [UIView animateWithDuration:.35f animations:^{
                UIEdgeInsets insets = scrollView.contentInset;
                insets.top = self.baseContentInsetTop + AKPullRefreshViewRefreshHeight;
                scrollView.contentInset = insets;
                
            } completion:^(BOOL finished) {
                !self.triggerToRefreshBlock ? : self.triggerToRefreshBlock();
            }];
            break;
        }
            
        case AKPullRefreshStateFinishRefresh: {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.state = AKPullRefreshStateNormal;
            });
            break;
        }
            
        case AKPullRefreshStatePause: { break; }
        case AKPullRefreshStateNoNetwork: { break; }
            
        default: break;
    }
}

- (void)startObserver {
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    [self.KVOController observe:scrollView keyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.KVOController observe:scrollView keyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
    [self.KVOController observe:scrollView keyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)stopObserver {
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    [self.KVOController unobserve:scrollView keyPath:@"contentOffset"];
    [self.KVOController unobserve:scrollView keyPath:@"contentInset"];
    [self.KVOController unobserve:scrollView keyPath:@"contentSize"];
}

@end
