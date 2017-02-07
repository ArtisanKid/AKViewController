//
//  AKArrowCell.h
//  Pods
//
//  Created by 李翔宇 on 15/11/30.
//
//

#import <UIKit/UIKit.h>
#import "AKTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKArrowCell : UITableViewCell<AKTableViewCellProtocol>

//默认规则：titleLabel不压缩，不拉伸，16号字，靠左对齐，纵向居中
@property (nonatomic, strong, readonly) UILabel *titleLabel;

//默认规则：subTitleLabel可压缩，不拉伸，14号字，靠右对齐，纵向居中
@property (nonatomic, strong, readonly) UILabel *subTitleLabel;

/**
 *  AKDrawContent:
 *
 *  @param object @[title, subTitle]
 */
- (void)AKDrawContent:(NSArray<NSString *> * _Nullable)object;

@end

NS_ASSUME_NONNULL_END
