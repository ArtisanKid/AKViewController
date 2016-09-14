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
#import "AKSVCDisplayConfig.h"

@implementation AKTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16.f];
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
    
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - AKSVCBoundsGap() * 2;
}

#pragma mark- 私有方法
- (void)originTitleLabelConstraint {
    MASAttachKeys(self, _titleLabel)
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0.f);
        make.leading.mas_equalTo(AKSVCBoundsGap());
        make.trailing.mas_equalTo(-AKSVCBoundsGap());
    }];
}

#pragma mark- 协议方法
+ (CGFloat)AKMinimumHeightOfCell {
    return AKSVCBaseCellHeight();
}

- (void)AKDrawCell:(id)object {
    if([object isKindOfClass:[NSString class]]) {
        self.titleLabel.text = object;
    } else if([object isKindOfClass:[NSAttributedString class]]) {
        self.titleLabel.attributedText = object;
    } else if([object respondsToSelector:@selector(description)]) {
        self.titleLabel.text = [object description];
    } else {
        AKViewControllerLog(@"传入了错误类型的显示数据", object);
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
            make.top.mas_equalTo(12.f);
            make.bottom.mas_equalTo(-12.f);
            make.leading.mas_equalTo(12.f);
            make.trailing.mas_equalTo(-12.f);
        }];
    } else {
        [self originTitleLabelConstraint];
    }
}

@end
