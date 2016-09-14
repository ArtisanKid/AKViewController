//
//  AKTableViewRowProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/1/5.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewRowProtocol <NSObject>

@required

/**
 *  指定行高。优先使用指定行高显示cell
 *  如果自动计算行高，height需指定为AKTableViewComponentHeightAuto
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  自定义TableViewCell的Class
 *  如果自动计算行高，将调用AKTableViewCellProtocol中计算高度的协议方法
 */
@property (nonatomic, strong) Class<AKTableViewCellProtocol> cell;

/**
 *  用于绘制的object
 *  将调用AKTableViewCellProtocol中绘制的协议方法
 
 */
@property (nullable, nonatomic, strong) id objToDraw;

/**
 *  reuseIdentifier
 *  如果nil，那么使用NSStringFromClass(cellClass)作为identifier
 */
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, assign) BOOL canEditRow;
@property (nonatomic, assign) BOOL canMoveRow;
 
+ (id<AKTableViewRowProtocol>)rowWithCell:(Class<AKTableViewCellProtocol>)cls obj:(id _Nullable)obj;

@end

NS_ASSUME_NONNULL_END
