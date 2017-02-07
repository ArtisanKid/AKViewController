//
//  AKTableViewController.h
//  Pods
//
//  Created by 李翔宇 on 15/12/29.
//
//

#import "AKViewController.h"
#import <Masonry/Masonry.h>
#import "AKScrollViewControllerProtocol.h"
#import "AKTableViewAdapterProtocol.h"
#import "AKTableViewDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKTableViewController : AKViewController<AKScrollViewControllerProtocol>

#pragma mark - AKScrollViewControllerProtocol

@property (nonatomic, strong, readonly) UIScrollView<AKScrollViewDataProtocol> *scrollView;
@property (nonatomic, strong) id<AKTableViewAdapterProtocol, AKTableViewDelegateProtocol> adapter;

#pragma mark - Interface

- (instancetype)initWithStyle:(UITableViewStyle)style;
@property (nonatomic, strong, readonly) UITableView *tableView;

//////////////////////////////////////////////////////////////////

@property (nonatomic, strong) MASConstraint *ak_topConstraint;
@property (nonatomic, strong) MASConstraint *ak_bottomConstraint;

@property (nonatomic, strong, readonly) UIView *ak_nilViewForGroupStyle;

@end

NS_ASSUME_NONNULL_END
