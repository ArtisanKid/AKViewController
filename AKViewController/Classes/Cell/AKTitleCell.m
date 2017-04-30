//
//  AKTitleCell.m
//  Pods
//
//  Created by 李翔宇 on 15/8/18.
//
//

#import "AKTitleCell.h"
#import <Masonry/Masonry.h>
#import "AKViewControllerMacro.h"
#import "AKViewControllerDisplayConfig.h"

@implementation AKTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16.];
            label.textColor = [UIColor darkGrayColor];
            label.numberOfLines = 0;
            [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
            [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.contentView addSubview:label];
            label;
        });
        
        [self originTitleLabelConstraint];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - AKViewControllerBoundsGap() * 2;
}

#pragma mark- 私有方法
- (void)originTitleLabelConstraint {
    MASAttachKeys(self, self.titleLabel)
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0.);
        make.leading.mas_equalTo(AKViewControllerBoundsGap());
        make.trailing.mas_equalTo(-AKViewControllerBoundsGap());
    }];
}

#pragma mark- 协议方法
+ (CGFloat)AKMinimumHeight {
    return AKViewControllerBaseCellHeight();
}

//NSString 或者 NSAttributedString，或者相应description方法的对象
- (void)AKDrawContent:(id)object {
    if([object isKindOfClass:[NSString class]]) {
        self.titleLabel.text = object;
    } else if([object isKindOfClass:[NSAttributedString class]]) {
        self.titleLabel.attributedText = object;
    } else if([object respondsToSelector:@selector(description)]) {
        self.titleLabel.text = [object description];
    } else {
        AKViewControllerLog(@"传入了错误类型的显示数据\n%@", object);
    }
}

#pragma mark- 公共方法
- (void)setAk_autoNumberOfLine:(BOOL)ak_auto {
    if(_ak_autoNumberOfLine == ak_auto) {
        return;
    }
    
    _ak_autoNumberOfLine = ak_auto;
    if(_ak_autoNumberOfLine) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12.);
            make.bottom.mas_equalTo(-12.);
            make.leading.mas_equalTo(12.);
            make.trailing.mas_equalTo(-12.);
        }];
    } else {
        [self originTitleLabelConstraint];
    }
}

@end
