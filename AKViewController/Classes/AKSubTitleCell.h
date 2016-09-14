//
//  AKSubTitleCell.h
//  Pods
//
//  Created by 李翔宇 on 15/8/18.
//
//

#import <UIKit/UIKit.h>
#import "AKTableViewCellProtocol.h"

typedef NS_ENUM (NSUInteger, AKSVCCellBaseline) {
    AKSVCCellBaselineCenter,
    AKSVCCellBaselineBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface AKSubTitleCell : UITableViewCell<AKTableViewCellProtocol>

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subTitleLabel;

@property (nonatomic, assign) AKSVCCellBaseline ak_base;/**<控件对齐方式*/

+ (CGFloat)AKMinimumHeightOfCell;

/**
 *  AKDrawCell:
 *
 *  @param object @[title, subTitle]
 */
- (void)AKDrawCell:(NSArray<NSString *> * _Nullable)object;

@end

NS_ASSUME_NONNULL_END
