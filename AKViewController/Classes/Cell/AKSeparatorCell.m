//
//  AKSeparatorCell.m
//  Pods
//
//  Created by 李翔宇 on 15/8/18.
//
//

#import "AKSeparatorCell.h"
#import "AKViewControllerDisplayConfig.h"

@implementation AKSeparatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

#pragma mark- 协议方法
+ (CGFloat)AKHeightOfContent:(id)object {
    return AKViewControllerBoundsGap();
}

@end
