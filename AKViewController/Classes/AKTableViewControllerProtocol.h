//
//  AKTableViewControllerProtocol.h
//  Pods
//
//  Created by 李翔宇 on 15/12/29.
//
//

#import <Foundation/Foundation.h>
#import "AKScrollViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewControllerProtocol<AKScrollViewControllerProtocol>

@required

- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong, readonly) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
