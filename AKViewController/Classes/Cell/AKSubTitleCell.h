//
//  AKSubTitleCell.h
//  Pods
//
//  Created by 李翔宇 on 15/8/18.
//
//

#import <UIKit/UIKit.h>
#import "AKTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKSubTitleCell : UITableViewCell<AKTableViewCellProtocol>

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *subTitleLabel;

@property (nonatomic, assign, getter=isAk_bottomAlignment) BOOL ak_bottomAlignment;/**<控件对齐方式*/

/**
 *  AKDrawContent:
 *
 *  @param object @[title, subTitle]
 */
- (void)AKDrawContent:(NSArray<NSString *> * _Nullable)object;

@end

NS_ASSUME_NONNULL_END
