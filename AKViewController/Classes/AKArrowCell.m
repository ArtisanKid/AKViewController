//
//  AKArrowCell.m
//  Pods
//
//  Created by 李翔宇 on 15/11/30.
//
//

#import "AKArrowCell.h"
#import <Masonry/Masonry.h>
#import "AKSVCDisplayConfig.h"

@interface AKArrowCell ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *subTitleLabel;

@end

@implementation AKArrowCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

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
            label.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:label];
            label;
        });
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(AKSVCBoundsGap());
            make.centerY.mas_equalTo(0.f);
        }];
        
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_greaterThanOrEqualTo(_titleLabel.mas_trailing);
            make.trailing.mas_equalTo(-AKSVCBoundsGap());
            make.centerY.mas_equalTo(0.f);
        }];
    }
    return self;
}

#pragma mark - 重载方法
+ (CGFloat)AKHeightOfCell {
    return AKSVCBaseCellHeight();
}

- (void)AKDrawCell:(NSArray<NSString *> *)object {
    self.titleLabel.text = object.firstObject;
    self.subTitleLabel.hidden = object.count < 2;
    if(object.count < 2) {
        return;
    }
    self.subTitleLabel.text = object.lastObject;
}

@end
