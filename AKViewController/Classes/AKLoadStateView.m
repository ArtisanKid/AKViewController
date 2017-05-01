//
//  AKLoadStateView.m
//  Pods
//
//  Created by 李翔宇 on 15/1/9.
//
//

#import "AKLoadStateView.h"
#import <Masonry/Masonry.h>

@interface AKLoadStateView ()

//@{@(state), imageName}
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *backgroundColorDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *imageDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *titleDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *titleColorDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *detailDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *detailColorDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *refreshButtonTitleDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *refreshButtonTitleColorDicM;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIColor *> *refreshButtonColorDicM;

@property (nonatomic, strong, readwrite) UIImageView *iconImageView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *detailLabel;
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong, readwrite) UIButton *refreshButton;
@property (nonatomic, strong) MASConstraint *refreshButton_height_constraint;

@end

@implementation AKLoadStateView

#pragma mark - 生命周期
- (instancetype)init {
    self = [super init];
    if (self) {
        
        /**
         *  初始化赋值
         */
        _backgroundColorDicM = [[AKLoadStateView backgroundColorDicM] mutableCopy];
        _imageDicM = [[AKLoadStateView imageDicM] mutableCopy];
        _titleDicM = [[AKLoadStateView titleDicM] mutableCopy];
        _titleColorDicM = [[AKLoadStateView titleColorDicM] mutableCopy];
        _detailDicM = [[AKLoadStateView detailDicM] mutableCopy];
        _detailColorDicM = [[AKLoadStateView detailColorDicM] mutableCopy];
        _refreshButtonColorDicM = [[AKLoadStateView refreshButtonColorDicM] mutableCopy];
        _refreshButtonTitleDicM = [[AKLoadStateView refreshButtonTitleDicM] mutableCopy];
        _refreshButtonTitleColorDicM = [[AKLoadStateView refreshButtonTitleColorDicM] mutableCopy];
        
        //UI Layout
        
        self.backgroundColor = _backgroundColorDicM[@(AKLoadStateNormal)];
        
        _iconImageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.image = [UIImage imageNamed:_imageDicM[@(AKLoadStateNormal)]];
            [self addSubview:imageView];
            imageView;
        });
        
        _activityIndicatorView = ({
            UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] init];
            view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            view.backgroundColor = [UIColor clearColor];
            view.hidesWhenStopped = NO;
            view.hidden = YES;
            [self addSubview:view];
            view;
        });
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = _titleColorDicM[@(AKLoadStateNormal)];
            label.font = AKLoadStateView_TitleFont;
            label.text = _titleDicM[@(AKLoadStateNormal)];
            [self addSubview:label];
            label;
        });
        
        _detailLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
            label.numberOfLines = 0;
            label.lineBreakMode = NSLineBreakByTruncatingTail;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = _detailColorDicM[@(AKLoadStateNormal)];
            label.font = AKLoadStateView_TitleFont;
            label.text = _detailDicM[@(AKLoadStateNormal)];
            [self addSubview:label];
            label;
        });
        
        _refreshButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = _refreshButtonColorDicM[@(AKLoadStateNormal)];
            [button setTitleColor:_refreshButtonTitleColorDicM[@(AKLoadStateNormal)] forState:UIControlStateNormal];
            [button setTitle:_refreshButtonTitleDicM[@(AKLoadStateNormal)] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(refreshButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            UIEdgeInsets insets = button.contentEdgeInsets;
            insets.left = 16.;
            insets.right = 16.;
            button.contentEdgeInsets = insets;
            
            [self addSubview:button];
            button;
        });
        
        UIView *topView = [[UIView alloc] init];
        [self addSubview:topView];
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        
        //Constraints
        
        MASAttachKeys(self, topView, _iconImageView, _activityIndicatorView, _titleLabel, _detailLabel, _refreshButton, bottomView)
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0.);
            make.height.mas_greaterThanOrEqualTo(64.).priorityHigh();
        }];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0.);
            make.top.mas_equalTo(topView.mas_bottom);
        }];
        
        [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_iconImageView);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_iconImageView.mas_bottom).offset(40.);
            make.leading.mas_equalTo(16.);
            make.trailing.mas_equalTo(-16.);
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10.);
            make.leading.mas_equalTo(16.);
            make.trailing.mas_equalTo(-16.);
        }];
        
        [_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            _refreshButton_height_constraint = make.height.mas_equalTo(44.);
            make.centerX.mas_equalTo(0.);
            make.top.mas_equalTo(_detailLabel.mas_bottom).offset(22.);
            make.leading.mas_greaterThanOrEqualTo(44.);
            make.trailing.mas_lessThanOrEqualTo(-44.);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(topView).priorityHigh();
            make.top.mas_equalTo(_refreshButton.mas_bottom);
            make.bottom.mas_equalTo(0.);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTap:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        self.hidden = YES;
        _state = AKLoadStateNormal;
    }
    return self;
}

#pragma mark- 属性方法
- (NSMutableDictionary *)backgroundColorDicM {
    if(!_backgroundColorDicM) {
        _backgroundColorDicM = [NSMutableDictionary dictionary];
    };
    return _backgroundColorDicM;
}

- (NSMutableDictionary *)imageDicM {
    if(!_imageDicM) {
        _imageDicM = [NSMutableDictionary dictionary];
    }
    return _imageDicM;
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

- (NSMutableDictionary *)detailDicM {
    if(!_detailDicM) {
        _detailDicM = [NSMutableDictionary dictionary];
    }
    return _detailDicM;
}

- (NSMutableDictionary *)detailColorDicM {
    if(!_detailColorDicM) {
        _detailColorDicM = [NSMutableDictionary dictionary];
    }
    return _detailColorDicM;
}

- (NSMutableDictionary *)refreshButtonColorDicM {
    if(!_refreshButtonColorDicM) {
        _refreshButtonColorDicM = [NSMutableDictionary dictionary];
    };
    return _refreshButtonColorDicM;
}

- (NSMutableDictionary *)refreshButtonTitleDicM {
    if(!_refreshButtonTitleDicM) {
        _refreshButtonTitleDicM = [NSMutableDictionary dictionary];
    };
    return _refreshButtonTitleDicM;
}

- (NSMutableDictionary *)refreshButtonTitleColorDicM {
    if(!_refreshButtonTitleColorDicM) {
        _refreshButtonTitleColorDicM = [NSMutableDictionary dictionary];
    };
    return _refreshButtonTitleColorDicM;
}

+ (NSMutableDictionary *)backgroundColorDicM {
    static NSMutableDictionary<NSNumber *, NSString *> *_backgroundColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _backgroundColorDicM = [@{@(AKLoadStateNormal) : [UIColor whiteColor],
                                  @(AKLoadStateNoNetwork) : [UIColor whiteColor],
                                  @(AKLoadStateNetworkError) : [UIColor whiteColor],
                                  @(AKLoadStateCustomError) : [UIColor whiteColor],
                                  @(AKLoadStateDataEmpty) : [UIColor whiteColor],
                                  @(AKLoadStateDataLoading) : [UIColor whiteColor]} mutableCopy];
    });
    return _backgroundColorDicM;
}

+ (NSMutableDictionary *)imageDicM {
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
        _titleDicM = [@{@(AKLoadStateNoNetwork) : @"没有网络，点击重新加载",
                        @(AKLoadStateNetworkError) : @"网络错误，点击重新加载",
                        @(AKLoadStateCustomError) : @"错误",
                        @(AKLoadStateDataEmpty) : @"暂无数据",
                        @(AKLoadStateDataLoading) : @"正在加载..."} mutableCopy];
    });
    return _titleDicM;
}

+ (NSMutableDictionary *)titleColorDicM {
    static NSMutableDictionary<UIColor *, NSString *> *_titleColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _titleColorDicM = [@{@(AKLoadStateNormal) : [UIColor darkGrayColor],
                             @(AKLoadStateNoNetwork) : [UIColor darkGrayColor],
                             @(AKLoadStateNetworkError) : [UIColor darkGrayColor],
                             @(AKLoadStateCustomError) : [UIColor darkGrayColor],
                             @(AKLoadStateDataEmpty) : [UIColor darkGrayColor],
                             @(AKLoadStateDataLoading) : [UIColor darkGrayColor]} mutableCopy];
    });
    return _titleColorDicM;
}

+ (NSMutableDictionary *)detailDicM {
    static NSMutableDictionary<NSNumber *, NSString *> *_detailDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _detailDicM = [NSMutableDictionary dictionary];
    });
    return _detailDicM;
}

+ (NSMutableDictionary *)detailColorDicM {
    static NSMutableDictionary<UIColor *, NSString *> *_detailColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _detailColorDicM = [@{@(AKLoadStateNormal) : [UIColor grayColor],
                              @(AKLoadStateNoNetwork) : [UIColor grayColor],
                              @(AKLoadStateNetworkError) : [UIColor grayColor],
                              @(AKLoadStateCustomError) : [UIColor grayColor],
                              @(AKLoadStateDataEmpty) : [UIColor grayColor],
                              @(AKLoadStateDataLoading) : [UIColor grayColor]} mutableCopy];
    });
    return _detailColorDicM;
}

+ (NSMutableDictionary *)refreshButtonColorDicM {
    static NSMutableDictionary<UIColor *, NSString *> *_refreshButtonColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _refreshButtonColorDicM = [@{@(AKLoadStateNormal) : [UIColor blueColor],
                                     @(AKLoadStateNoNetwork) : [UIColor blueColor],
                                     @(AKLoadStateNetworkError) : [UIColor blueColor],
                                     @(AKLoadStateCustomError) : [UIColor blueColor],
                                     @(AKLoadStateDataEmpty) : [UIColor blueColor],
                                     @(AKLoadStateDataLoading) : [UIColor blueColor]} mutableCopy];
    });
    return _refreshButtonColorDicM;
}

+ (NSMutableDictionary *)refreshButtonTitleDicM {
    static NSMutableDictionary<NSNumber *, NSString *> *_refreshButtonTitleDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _refreshButtonTitleDicM = [@{@(AKLoadStateNoNetwork) : @"重新加载",
                                     @(AKLoadStateNetworkError) : @"重新加载",
                                     @(AKLoadStateCustomError) : @"重新加载",
                                     @(AKLoadStateDataEmpty) : @"重新加载",
                                     @(AKLoadStateDataLoading) : @"正在加载..."} mutableCopy];
    });
    return _refreshButtonTitleDicM;
}

+ (NSMutableDictionary *)refreshButtonTitleColorDicM {
    static NSMutableDictionary<UIColor *, NSString *> *_refreshButtonTitleColorDicM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _refreshButtonTitleColorDicM = [@{@(AKLoadStateNormal) : [UIColor whiteColor],
                                          @(AKLoadStateNoNetwork) : [UIColor whiteColor],
                                          @(AKLoadStateNetworkError) : [UIColor whiteColor],
                                          @(AKLoadStateCustomError) : [UIColor whiteColor],
                                          @(AKLoadStateDataEmpty) : [UIColor whiteColor],
                                          @(AKLoadStateDataLoading) : [UIColor whiteColor]} mutableCopy];
    });
    return _refreshButtonTitleColorDicM;
}

#pragma mark- 私有方法
- (void)selfTap:(UITapGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            break;
        }
        case UIGestureRecognizerStateEnded: {
            !self.touchUpInsideBlock ? : self.touchUpInsideBlock();
            break;
        }
        default: break;
    }
}

- (void)refreshButtonTouchUpInside:(UIButton *)sender {
    !self.touchUpInsideBlock ? : self.touchUpInsideBlock();
}

#pragma mark - 属性方法

- (void)setState:(AKLoadState)state {
    if(_state == state) {
        return;
    }
    
    [self willChangeValueForKey:@"state"];
    _state = state;
    [self didChangeValueForKey:@"state"];
    
    [self.superview bringSubviewToFront:self];
    self.hidden = NO;
    
    switch (_state) {
        case AKLoadStateNoNetwork:
        case AKLoadStateNetworkError:
        case AKLoadStateCustomError:
        case AKLoadStateDataEmpty: {
            self.backgroundColor = self.backgroundColorDicM[@(_state)];
            
            [self.activityIndicatorView stopAnimating];
            self.activityIndicatorView.hidden = YES;
            
            self.iconImageView.image = [UIImage imageNamed:self.imageDicM[@(_state)]];
            self.iconImageView.hidden = NO;
            
            self.titleLabel.text = self.titleDicM[@(_state)];//@"错误";
            self.detailLabel.text = self.detailDicM[@(_state)];
            
            if(!self.isHideRefreshButton) {
                self.refreshButton.backgroundColor = self.refreshButtonColorDicM[@(_state)];
                [self.refreshButton setTitle:self.refreshButtonTitleDicM[@(_state)] forState:UIControlStateNormal];
                [self.refreshButton setTitleColor:self.refreshButtonTitleColorDicM[@(_state)] forState:UIControlStateNormal];
            }
            break;
        }
        case AKLoadStateDataLoading: {
            [self.activityIndicatorView startAnimating];
            self.activityIndicatorView.hidden = NO;
            
            self.iconImageView.hidden = YES;
            
            self.titleLabel.text = self.titleDicM[@(_state)];
            self.detailLabel.text = self.detailDicM[@(_state)];//@"正在加载...";
            
            if(!self.isHideRefreshButton) {
                self.refreshButton.backgroundColor = self.refreshButtonColorDicM[@(_state)];
                [self.refreshButton setTitle:self.refreshButtonTitleDicM[@(_state)] forState:UIControlStateNormal];
                [self.refreshButton setTitleColor:self.refreshButtonTitleColorDicM[@(_state)] forState:UIControlStateNormal];
            }
            break;
        }
        case AKLoadStateNormal: {
            self.hidden = YES;
            break;
        }    
        default: break;
    }
}

- (UIButton *)refreshButton {
    if(self.isHideRefreshButton) {
        return nil;
    }
    return _refreshButton;
}

- (void)setHideRefreshButton:(BOOL)hide {
    if(_hideRefreshButton == hide) {
        return;
    }
    
    _hideRefreshButton = hide;
    if(_hideRefreshButton) {
        self.refreshButton_height_constraint.offset = 0.;
    } else {
        self.refreshButton_height_constraint.offset = 44.;
    }
    [self layoutIfNeeded];
}

#pragma mark- 配置方法
- (void)setBackgroundColor:(UIColor *)color state:(AKLoadState)state {
    self.backgroundColorDicM[@(state)] = color;
    if(self.state == state) {
        self.backgroundColor = color;
    }
}
- (void)setImage:(NSString *)image state:(AKLoadState)state {
    self.imageDicM[@(state)] = image;
    if(self.state == state) {
        self.iconImageView.image = [UIImage imageNamed:image];
    }
}

- (void)setTitle:(NSString *)title state:(AKLoadState)state {
    self.titleDicM[@(state)] = title;
    if(self.state == state) {
        self.titleLabel.text = title;
    }
}
- (void)setTitleColor:(UIColor *)color state:(AKLoadState)state {
    self.titleColorDicM[@(state)] = color;
    if(self.state == state) {
        self.titleLabel.textColor = color;
    }
}

- (void)setDetail:(NSString *)detail state:(AKLoadState)state {
    self.detailDicM[@(state)] = detail;
    if(self.state == state) {
        self.detailLabel.text = detail;
    }
}
- (void)setDetailColor:(UIColor *)color state:(AKLoadState)state {
    self.detailColorDicM[@(state)] = color;
    if(self.state == state) {
        self.detailLabel.textColor = color;
    }
}

- (void)setRefreshButtonColor:(UIColor *)color state:(AKLoadState)state {
    self.refreshButtonColorDicM[@(state)] = color;
    if(self.state == state) {
        self.refreshButton.backgroundColor = color;
    }
}
- (void)setRefreshButtonTitle:(NSString *)title state:(AKLoadState)state {
    self.refreshButtonTitleDicM[@(state)] = title;
    if(self.state == state) {
        [self.refreshButton setTitle:title forState:UIControlStateNormal];
    }
}
- (void)setRefreshButtonTitleColor:(UIColor *)color state:(AKLoadState)state {
    self.refreshButtonTitleColorDicM[@(state)] = color;
    if(self.state == state) {
        [self.refreshButton setTitleColor:color forState:UIControlStateNormal];
    }
}

+ (void)setBackgroundColor:(UIColor *)color state:(AKLoadState)state {
    [self backgroundColorDicM][@(state)] = color;
}

+ (void)setImage:(UIImage *)image state:(AKLoadState)state {
    [self imageDicM][@(state)] = image;
}

+ (void)setTitle:(NSString *)title state:(AKLoadState)state {
    [self titleDicM][@(state)] = title;
}

+ (void)setTitleColor:(UIColor *)color state:(AKLoadState)state {
    [self titleColorDicM][@(state)] = color;
}

UIFont *AKLoadStateView_TitleFont = nil;
+ (void)setTitleFont:(UIFont *)font {
    AKLoadStateView_TitleFont = font;
}

+ (void)setDetail:(NSString *)detail state:(AKLoadState)state {
    [self detailDicM][@(state)] = detail;
}

+ (void)setDetailColor:(UIColor *)color state:(AKLoadState)state {
    [self detailColorDicM][@(state)] = color;
}

UIFont *AKLoadStateView_DetailFont = nil;
+ (void)setDetailFont:(UIFont *)font {
    AKLoadStateView_DetailFont = font;
}

+ (void)setRefreshButtonColor:(UIColor *)color state:(AKLoadState)state {
    [self refreshButtonColorDicM][@(state)] = color;
}

+ (void)setRefreshButtonTitle:(NSString *)title state:(AKLoadState)state {
    [self refreshButtonTitleDicM][@(state)] = title;
}

+ (void)setRefreshButtonTitleColor:(UIColor *)color state:(AKLoadState)state {
    [self refreshButtonTitleColorDicM][@(state)] = color;
}

UIFont *AKLoadStateView_RefreshButtonFont = nil;
+ (void)setRefreshButtonFont:(UIFont *)font {
    AKLoadStateView_RefreshButtonFont = font;
}

@end
