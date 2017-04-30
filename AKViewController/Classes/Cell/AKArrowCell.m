//
//  AKArrowCell.m
//  Pods
//
//  Created by 李翔宇 on 15/11/30.
//
//

#import "AKArrowCell.h"
#import <Masonry/Masonry.h>
#import "AKViewControllerDisplayConfig.h"

@interface AKArrowCell ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *subTitleLabel;

@end

@implementation AKArrowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16.];
            label.textColor = [UIColor darkGrayColor];
            [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.contentView addSubview:label];
            label;
        });
        
        _subTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14.];
            label.textColor = UIColor.lightGrayColor;
            [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.contentView addSubview:label];
            label;
        });
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(AKViewControllerBoundsGap());
            make.centerY.mas_equalTo(0.);
        }];
        
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_greaterThanOrEqualTo(_titleLabel.mas_trailing).offset(AKViewControllerInnerGap());
            make.trailing.mas_equalTo(-AKViewControllerBoundsGap());
            make.centerY.mas_equalTo(0.);
        }];
    }
    return self;
}

#pragma mark - 重载方法
+ (CGFloat)AKHeightOfContent:(id)object {
    return AKViewControllerBaseCellHeight();
}

//@[title, subTitle]
- (void)AKDrawContent:(NSArray<NSString *> *)object {
    self.titleLabel.text = object.firstObject;
    if(object.count < 2) {
        self.subTitleLabel.text = nil;
        self.subTitleLabel.hidden = YES;
        return;
    }
    self.subTitleLabel.hidden = NO;
    self.subTitleLabel.text = object.lastObject;
}

@end
