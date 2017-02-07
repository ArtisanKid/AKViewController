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

//占满cell的UIImageView
@property (nonatomic, strong, readonly) UIImageView *wholeImageView;

/**
 *  AKDrawContent:
 *
 *  @param object UIImage/NSString/NSURL
 */
- (void)AKDrawContent:(id _Nullable)object;

@end

NS_ASSUME_NONNULL_END
