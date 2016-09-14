//
//  AKTableViewRow.h
//  Pods
//
//  Created by 李翔宇 on 16/1/5.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewRowProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern CGFloat AKTableViewComponentHeightAuto;

@interface AKTableViewRow : NSObject<AKTableViewRowProtocol>

/**
 *  默认值AKTableViewRowHeightAuto
 */
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Class<AKTableViewCellProtocol> cell;
@property (nullable, nonatomic, strong) id objToDraw;
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, assign) BOOL canEditRow;
@property (nonatomic, assign) BOOL canMoveRow;

+ (id<AKTableViewRowProtocol>)rowWithCell:(Class<AKTableViewCellProtocol>)cls obj:(id _Nullable)obj;

@end

NS_ASSUME_NONNULL_END
