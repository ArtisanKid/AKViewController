//
//  AKTableViewController.h
//  Pods
//
//  Created by 李翔宇 on 15/12/29.
//
//

#import "AKViewController.h"
#import <Masonry/Masonry.h>
#import "AKTableViewControllerProtocol.h"
#import "AKTVCAdapterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKTableViewController : AKViewController<AKTableViewControllerProtocol, AKTVCAdapterProtocol>

@property (nonatomic, strong, readonly) UIScrollView<AKScrollViewDataProtocol> *scrollView;

- (instancetype)initWithStyle:(UITableViewStyle)style;
@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, strong) id<AKTableViewAdapterProtocol, AKTableViewDelegateProtocol> adapter;

//////////////////////////////////////////////////////////////////

@property (nonatomic, strong) MASConstraint *ak_topConstraint;
@property (nonatomic, strong) MASConstraint *ak_bottomConstraint;

@property (nonatomic, strong, readonly) UIView *ak_nilViewForGroupStyle;

@end

NS_ASSUME_NONNULL_END
