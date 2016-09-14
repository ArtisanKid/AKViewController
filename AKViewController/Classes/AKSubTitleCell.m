//
//  AKSubTitleCell.m
//  Pods
//
//  Created by 李翔宇 on 15/8/18.
//
//

#import "AKSubTitleCell.h"
#import <Masonry/Masonry.h>
#import "AKSVCDisplayConfig.h"

@interface AKSubTitleCell ()

@property (nonatomic, strong) MASConstraint *subTitleLabel_centerY_constraint;/**<控件对齐约束*/
@property (nonatomic, strong) MASConstraint *subTitleLabel_bottom_constraint;/**<控件对齐约束*/

@end

@implementation AKSubTitleCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16.f];
            label.textColor = [UIColor darkGrayColor];
            [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.contentView addSubview:label];
            label;
        });
        
        _subTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14.f];
            label.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:label];
            label;
        });
        
        MASAttachKeys(self, _titleLabel, _subTitleLabel)
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(AKSVCBoundsGap());
            make.centerY.mas_equalTo(0.f);
        }];
        
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_titleLabel.mas_trailing).offset(AKSVCInnerGap());
            _subTitleLabel_centerY_constraint = make.centerY.mas_equalTo(0.f);
            _subTitleLabel_bottom_constraint = make.bottom.mas_equalTo(_titleLabel.mas_bottom);
        }];
        
        [_subTitleLabel_bottom_constraint deactivate];
    }
    return self;
}

#pragma mark- 协议方法
+ (CGFloat)AKMinimumHeightOfCell {
    return AKSVCBaseCellHeight();
}

- (void)AKDrawCell:(NSArray<NSString *> * _Nullable)object; {
    self.titleLabel.text = object.firstObject;
    self.subTitleLabel.hidden = object.count < 2;
    if(object.count < 2) {
        return;
    }
    self.subTitleLabel.text = object.lastObject;
}

#pragma mark- 公开方法
- (void)setAk_base:(AKSVCCellBaseline)base {
    if (_ak_base == base) {
        return;
    }
    
    _ak_base = base;
    switch (_ak_base) {
        case AKSVCCellBaselineCenter: {
            [self.subTitleLabel_centerY_constraint activate];
            [self.subTitleLabel_bottom_constraint deactivate];
            break;
        }  
        case AKSVCCellBaselineBottom: {
            [self.subTitleLabel_centerY_constraint deactivate];
            [self.subTitleLabel_bottom_constraint activate];
            break;
        }
        default: break;
    }
    [self layoutIfNeeded];
}

@end
