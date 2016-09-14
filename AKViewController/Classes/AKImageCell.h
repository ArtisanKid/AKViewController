//
//  AKImageCell.h
//  Pods
//
//  Created by 李翔宇 on 16/4/11.
//
//

#import <UIKit/UIKit.h>
#import "AKTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKImageCell : UITableViewCell<AKTableViewCellProtocol>

@property (nonatomic, strong, readonly) UIImageView *wholeImageView;

/**
 *  AKDrawCell
 *
 *  @param object UIImage/NSString
 */
- (void)AKDrawCell:(id _Nullable)object;

@end

NS_ASSUME_NONNULL_END
