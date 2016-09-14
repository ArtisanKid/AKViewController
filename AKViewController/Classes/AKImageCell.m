//
//  AKImageCell.m
//  Pods
//
//  Created by 李翔宇 on 16/4/11.
//
//

#import "AKImageCell.h"
#import <Masonry/Masonry.h>

@interface AKImageCell ()

@property (nonatomic, strong, readwrite) UIImageView *wholeImageView;

@end

@implementation AKImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _wholeImageView = ({
            UIImageView *imageView= [[UIImageView alloc] init];
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:imageView];
            imageView;
        });

        [_wholeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0.f);
        }];
    }
    return self;
}

#pragma mark - 重载方法
- (void)AKDrawCell:(id)object {
    if([object isKindOfClass:[UIImage class]]) {
        self.wholeImageView.image = object;
    } else if([object isKindOfClass:[NSString class]]) {
        self.wholeImageView.image = [UIImage imageNamed:object];
    }
}

@end
