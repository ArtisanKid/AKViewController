//
//  AKTitleCell.h
//  Pods
//
//  Created by 李翔宇 on 15/8/18.
//
//

#import <UIKit/UIKit.h>
#import "AKTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKTitleCell : UITableViewCell<AKTableViewCellProtocol>

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, assign) BOOL ak_autoNumberOfLine;

/**
 *  绘制cell
 *
 *  @param object NSString 或者 NSAttributedString，或者相应description方法的对象
 */
- (void)AKDrawCell:(id _Nullable)object;

@end

NS_ASSUME_NONNULL_END
