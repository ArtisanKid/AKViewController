//
//  AKPushLoadView.m
//  Pods
//
//  Created by 李翔宇 on 6/29/15.
//
//

#import "AKPushLoadView.h"
#import <Masonry/Masonry.h>
#import <KVOController/KVOController.h>
#import <Reachability/Reachability.h>

#define AKPushLoadViewLoadTriggerHeight 68.
#define AKPushLoadViewLoadHeight 60.
#define AKPushLoadViewTitleTopToTop 24.

@interface AKPushLoadView ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *backgroundColorDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *titleDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *titleColorDicM;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *loadActivityIndicatorView;

@property (nonatomic, assign) CGFloat baseContentInsetBottom;
@property (nonatomic, assign) CGFloat currentContentToBottom;

@property (nonatomic, strong) MASConstraint *loadingConstraint;
@property (nonatomic, strong) MASConstraint *normalConstraint;

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation AKPushLoadView

#pragma mark - 生命周期
- (instancetype)init {
    self = [super init];
    if (self) {        
        /**
         *  初始化赋值
         */
        _backgroundColorDicM = [[[self class] backgroundColorDicM] mutableCopy];
        _titleDicM = [[[self class] titleDicM] mutableCopy];
        _titleColorDicM = [[[self class] titleColorDicM] mutableCopy];
        
        ///////////////////////////////////
        
        self.backgroundColor = _backgroundColorDicM[@(AKPushLoadStateNormal)];
        
        UIView *containerView = ({
            UIView *container = [[UIView alloc] init];
            [self addSubview:container];
            
            _loadActivityIndicatorView = ({
                UIActivityIndicatorView *view = UIActivityIndicatorView.new;
                view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                view.hidesWhenStopped = YES;
                [container addSubview:view];
                view.hidden = YES;
                view;
            });
            
            _titleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                label.font = AKPushLoadView_TitleFont;
                label.textColor = _titleColorDicM[@(AKPushLoadStateNormal)];
                label.text = _titleDicM[@(AKPushLoadStateNormal)];
                [container addSubview:label];
                label;
            });
            
            //////////////////////////////////////////////////////////
            
            MASAttachKeys(self, _loadActivityIndicatorView, _titleLabel);
            
            [_loadActivityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0.);
                make.bottom.mas_equalTo(0.);
                make.leading.mas_equalTo(0.);
            }];
            
            [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0.);
                _normalConstraint = make.leading.mas_equalTo(0.);
                _loadingConstraint = make.leading.mas_equalTo(_loadActivityIndicatorView.mas_trailing).offset(10.);
                make.trailing.mas_equalTo(0.);
            }];
            [_loadingConstraint deactivate];
            
            container;
        });
        
        /////////////////////////////////////
        
        MASAttachKeys(self, containerView);
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0.);
            make.top.mas_equalTo(22.);
        }];
        
        ////////////////////////////////////////////////////////////////////////////////////
        
        _reachability = [Reachability reachabilityWithHostName:@"http://www.apple.com"];
        __weak typeof(self) weak_self = self;
        [_reachability setReachableBlock:^(Reachability * reachability) {
            __strong typeof(weak_self) strong_self = weak_self;
            if(strong_self.state == AKPushLoadStateNoNetwork) {
                strong_self.state = AKPushLoadStateNormal;
            }
        }];
        [_reachability setUnreachableBlock:^(Reachability * reachability) {
            __strong typeof(weak_self) strong_self = weak_self;
            if(strong_self.state == AKPushLoadStateNormal) {
                strong_self.state = AKPushLoadStateNoNetwork;
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
        _backgroundColorDicM = [@{@(AKPushLoadStateNormal) : [UIColor whiteColor],
                                  @(AKPushLoadStateReadyToLoad) : [UIColor whiteColor],
                                  @(AKPushLoadStateLoading) : [UIColor whiteColor],
                                  @(AKPushLoadStateFinishLoad) : [UIColor whiteColor],
                                  @(AKPushLoadStateNoMoreData) : [UIColor whiteColor],
                                  @(AKPushLoadStateNoNetwork) : [UIColor whiteColor],
                                  @(AKPushLoadStatePause) : [UIColor whiteColor]} mutableCopy];
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
     //控件暂停使用
    dispatch_once(&onceToken, ^{
        _titleDicM = [@{@(AKPushLoadStateNormal) : @"上拉加载",
                        @(AKPushLoadStateReadyToLoad) : @"松手加载更多",
                        @(AKPushLoadStateLoading) : @"正在加载...",
                        @(AKPushLoadStateFinishLoad) : @"加载完成",
                        @(AKPushLoadStateNoMoreData) : @"无更多内容",
                        @(AKPushLoadStateNoNetwork) : @"网络不可用",
                        @(AKPushLoadStatePause) : @"当前不可加载"} mutableCopy];
    });
    return _titleDicM;
}

+ (NSMutableDictionary *)titleColorDicM {
    static NSMutableDictionary<UIColor *, NSString *> *_titleColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _titleColorDicM = [@{@(AKPushLoadStateNormal) : [UIColor darkGrayColor],
                             @(AKPushLoadStateReadyToLoad) : [UIColor darkGrayColor],
                             @(AKPushLoadStateLoading) : [UIColor darkGrayColor],
                             @(AKPushLoadStateFinishLoad) : [UIColor darkGrayColor],
                             @(AKPushLoadStateNoMoreData) : [UIColor darkGrayColor],
                             @(AKPushLoadStateNoNetwork) : [UIColor darkGrayColor],
                             @(AKPushLoadStatePause) : [UIColor darkGrayColor]} mutableCopy];
    });
    return _titleColorDicM;
}

#pragma mark- 私有方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if(self.state == AKPushLoadStateLoading ||
           self.state == AKPushLoadStateNoMoreData ||
           self.state == AKPushLoadStateNoNetwork ||
           self.state == AKPushLoadStatePause) {
            return;
        }
        
        //contentOffset负数值表示下拉
        //contentOffset.y的初始值为originContentInsetTop的负值，比如-64.
        CGPoint contentOffset;
        [change[@"new"] getValue:&contentOffset];
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        //需要考虑一种比较恶心的情况，就是下拉之后，scrollView在回弹的过程中，触发了上拉加载条件
        //计算scrollView上拉漏出的高度
        CGFloat offsetChange = (scrollView.frame.size.height - scrollView.contentInset.bottom) - (scrollView.contentSize.height - contentOffset.y) - self.currentContentToBottom;
        
        //表示非上拉状态
        if(offsetChange <= 0) {
            return;
        }
        
        if (scrollView.isDragging) {
            //isDragging=YES表示用户还在往下拉
            if (offsetChange >= AKPushLoadViewLoadTriggerHeight) {
                self.state = AKPushLoadStateReadyToLoad;
            } else {
                self.state = AKPushLoadStateNormal;
            }
        } else {
            //isDragging=NO表示用户已经松手了
            //如果当前状态为AKPushLoadViewLoadTriggerHeight，说明已经触发过加载
            if (self.state == AKPushLoadStateReadyToLoad) {
                self.state = AKPushLoadStateLoading;
            }
        }
    } else if ([keyPath isEqualToString:@"contentInset"]) {
        //因为十分不好判断当前的contentInset变化来源于空间内部还是外部
        //所以我们规定死，必须在AKPushLoadStateNormal的情况下才能接受contentInset的变更
        //我们在后期应该改进这一点
        if (self.state != AKPushLoadStateNormal) {
            return;
        }
        
        //contentInset正数值表示内缩
        UIEdgeInsets contentInset;
        [change[@"new"] getValue:&contentInset];
        self.baseContentInsetBottom = contentInset.bottom;
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        //不管当前什么状态，只要contentSize有变化，那么总是让控件的y处在一个刚刚好的位置
        //这个位置（1）contentSize的下面
        //这个位置（2）可操作区域的最底端
        CGSize contentSize;
        [change[@"new"] getValue:&contentSize];
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        //可视化高度指的是navigationBar和tabBar之间的可操作区域
        CGFloat visualHeight = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom;
        
        //控件应该存在于视图外
        CGFloat y = 0.;
        if(visualHeight > contentSize.height) {
            y = visualHeight;
            self.currentContentToBottom = visualHeight - contentSize.height;
        } else {
            y = contentSize.height;
            self.currentContentToBottom = 0;
        }
        
        //设置控件位置
        CGRect frame = CGRectZero;
        frame.size = scrollView.frame.size;
        frame.origin.y = y;
        self.frame = frame;
    }
}

#pragma mark- 配置方法
- (void)setBackgroundColor:(UIColor *)color state:(AKPushLoadState)state {
    self.backgroundColorDicM[@(state)] = color;
    if(self.state == state) {
        self.backgroundColor = color;
    }
    
    if(state == AKPushLoadStateNormal) {
        self.backgroundColorDicM[@(AKPushLoadStateReadyToLoad)] = color;
        self.backgroundColorDicM[@(AKPushLoadStateLoading)] = color;
        self.backgroundColorDicM[@(AKPushLoadStateFinishLoad)] = color;
        self.backgroundColorDicM[@(AKPushLoadStateNoMoreData)] = color;
        self.backgroundColorDicM[@(AKPushLoadStateNoNetwork)] = color;
        self.backgroundColorDicM[@(AKPushLoadStatePause)] = color;
    }
}

- (void)setTitle:(NSString *)title state:(AKPushLoadState)state {
    self.titleDicM[@(state)] = title;
    if(self.state == state) {
        self.titleLabel.text = title;
    }
}
- (void)setTitleColor:(UIColor *)color state:(AKPushLoadState)state {
    self.titleColorDicM[@(state)] = color;
    if(self.state == state) {
        self.titleLabel.textColor = color;
    }
    
    if(state == AKPushLoadStateNormal) {
        self.titleColorDicM[@(AKPushLoadStateReadyToLoad)] = color;
        self.titleColorDicM[@(AKPushLoadStateLoading)] = color;
        self.titleColorDicM[@(AKPushLoadStateFinishLoad)] = color;
        self.titleColorDicM[@(AKPushLoadStateNoMoreData)] = color;
        self.titleColorDicM[@(AKPushLoadStateNoNetwork)] = color;
        self.titleColorDicM[@(AKPushLoadStatePause)] = color;
    }
}

+ (void)setBackgroundColor:(UIColor *)color state:(AKPushLoadState)state {
    NSMutableDictionary *backgroundColorDicM = [self backgroundColorDicM];
    
    backgroundColorDicM[@(state)] = color;
    if(state == AKPushLoadStateNormal) {
        backgroundColorDicM[@(AKPushLoadStateReadyToLoad)] = color;
        backgroundColorDicM[@(AKPushLoadStateLoading)] = color;
        backgroundColorDicM[@(AKPushLoadStateFinishLoad)] = color;
        backgroundColorDicM[@(AKPushLoadStateNoMoreData)] = color;
        backgroundColorDicM[@(AKPushLoadStateNoNetwork)] = color;
        backgroundColorDicM[@(AKPushLoadStatePause)] = color;
    }
}

+ (void)setTitle:(NSString *)title state:(AKPushLoadState)state {
    [self titleDicM][@(state)] = title;
}

+ (void)setTitleColor:(UIColor *)color state:(AKPushLoadState)state {
    NSMutableDictionary *titleColorDicM = [self titleColorDicM];
    
    titleColorDicM[@(state)] = color;
    if(state == AKPushLoadStateNormal) {
        titleColorDicM[@(AKPushLoadStateReadyToLoad)] = color;
        titleColorDicM[@(AKPushLoadStateLoading)] = color;
        titleColorDicM[@(AKPushLoadStateFinishLoad)] = color;
        titleColorDicM[@(AKPushLoadStateNoMoreData)] = color;
        titleColorDicM[@(AKPushLoadStateNoNetwork)] = color;
        titleColorDicM[@(AKPushLoadStatePause)] = color;
    }
}

UIFont *AKPushLoadView_TitleFont = nil;
+ (void)setTitleFont:(UIFont *)font {
    AKPushLoadView_TitleFont = font;
}

#pragma mark - 公开
- (void)setState:(AKPushLoadState)state {
    if (_state == state) {
        return;
    }
    
    _state = state;
    
    self.titleLabel.textColor = self.titleColorDicM[@(_state)];
    self.titleLabel.text = self.titleDicM[@(_state)];
    
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    switch (self.state) {
        case AKPushLoadStateNormal: {
            [self.loadingConstraint deactivate];
            [self.normalConstraint activate];
            
            self.loadActivityIndicatorView.hidden = YES;
            [self.loadActivityIndicatorView stopAnimating];
            
            
            [UIView animateWithDuration:.2f animations:^{
                UIEdgeInsets edgeInsets = scrollView.contentInset;
                edgeInsets.bottom = self.baseContentInsetBottom;
                scrollView.contentInset = edgeInsets;
            } completion:^(BOOL finished) {}];
            break;
        }
            
        case AKPushLoadStateReadyToLoad: { break; }
            
        case AKPushLoadStateLoading: {
            [self.normalConstraint deactivate];
            [self.loadingConstraint activate];
            
            self.loadActivityIndicatorView.hidden = NO;
            [self.loadActivityIndicatorView startAnimating];
            
            [UIView animateWithDuration:.2f animations:^{
                UIEdgeInsets edgeInsets = scrollView.contentInset;
                edgeInsets.bottom = self.baseContentInsetBottom + AKPushLoadViewLoadTriggerHeight;
                scrollView.contentInset = edgeInsets;
            } completion:^(BOOL finished) {
                !self.triggerToLoadBlock ? : self.triggerToLoadBlock();
            }];
            break;
        }
            
        case AKPushLoadStateFinishLoad: {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.state = AKPushLoadStateNormal;
            });
            break;
        }
            
        case AKPushLoadStateNoMoreData: {
            [self.loadingConstraint deactivate];
            [self.normalConstraint activate];
            
            [self.loadActivityIndicatorView stopAnimating];
            self.loadActivityIndicatorView.hidden = YES;
            
            [UIView animateWithDuration:.2f animations:^{
                UIEdgeInsets edgeInsets = scrollView.contentInset;
                edgeInsets.bottom = self.baseContentInsetBottom + AKPushLoadViewLoadTriggerHeight;
                scrollView.contentInset = edgeInsets;
            } completion:^(BOOL finished) {}];
            break;
        }
            
        case AKPushLoadStateNoNetwork: {
            [self.loadingConstraint deactivate];
            [self.normalConstraint activate];
            
            [self.loadActivityIndicatorView stopAnimating];
            self.loadActivityIndicatorView.hidden = YES;
            
            [UIView animateWithDuration:.2f animations:^{
                UIEdgeInsets edgeInsets = scrollView.contentInset;
                edgeInsets.bottom = self.baseContentInsetBottom + AKPushLoadViewLoadTriggerHeight;
                scrollView.contentInset = edgeInsets;
            } completion:^(BOOL finished) {}];
            break;
        }
            
        case AKPushLoadStatePause: { break; }
            
        default:
            break;
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
