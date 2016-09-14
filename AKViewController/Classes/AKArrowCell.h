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

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subTitleLabel;

+ (CGFloat)AKHeightOfCell;

/**
 *  AKDrawCell:
 *
 *  @param object @[title, subTitle]
 */
- (void)AKDrawCell:(NSArray<NSString *> * _Nullable)object;

@end

NS_ASSUME_NONNULL_END
