//
//  UIViewController+AKScrollState.m
//  Pods
//
//  Created by 李翔宇 on 16/4/22.
//
//

#import "UIViewController+AKScrollState.h"
#import "AKPullRefreshView.h"
#import "AKPushLoadView.h"
#import "UIViewController+AKState.h"
#import "AKTableViewControllerProtocol.h"
#import "AKCollectionViewControllerProtocol.h"
#import "AKTableViewAdapterProtocol.h"
#import "AKTableViewDelegateProtocol.h"
#import "AKTVCAdapterProtocol.h"
#import "AKScrollViewDataProtocol.h"

@implementation UIViewController (AKScrollState)

#pragma mark- PullRefreshView

static NSMapTable *ak_pullRefreshViewMapTable = nil;

- (BOOL)ak_startPullRefreshView {
    return !![ak_pullRefreshViewMapTable objectForKey:@(self.hash).description];
}
- (void)setAk_startPullRefreshView:(BOOL)ak_startPullRefreshView {
    if(![self conformsToProtocol:@protocol(AKScrollViewControllerProtocol)]) {
        return;
    }
    
    if(ak_startPullRefreshView) {
        if ([ak_pullRefreshViewMapTable objectForKey:@(self.hash).description]) {
            return;
        }
        
        AKPullRefreshView *view = [[AKPullRefreshView alloc] init];
        id<AKScrollViewControllerProtocol> controller = self;
        [controller.scrollView addSubview:view];
        
        __weak typeof(self) weak_self = self;
        view.triggerToRefreshBlock = ^() {
            __strong typeof(weak_self) strong_self = weak_self;
            
            if (strong_self.ak_pushLoadView.state == AKPushLoadStateLoading) {
                strong_self.ak_pullRefreshView.state = AKPullRefreshStateFinishRefresh;
                return;
            }
            
            strong_self.ak_pushLoadView.state = AKPushLoadStateFinishLoad;
            strong_self.ak_pullRefreshView.state = AKPullRefreshStateRefreshing;
            
            strong_self.ak_progressHUD.mode = MBProgressHUDModeIndeterminate;
            strong_self.ak_progressHUD.labelText = nil;
            [strong_self.ak_progressHUD show:YES];
            
            //如果实现了AKTableViewControllerAdapterProtocol
            id<AKTableViewAdapterProtocol, AKTableViewDelegateProtocol> adapter = nil;
            if([self conformsToProtocol:@protocol(AKTVCAdapterProtocol)]) {
                id<AKTVCAdapterProtocol> controller = strong_self;
                adapter = controller.adapter;
            }
            
            //如果实现了AKTableViewControllerProtocol
            id<AKScrollViewDataProtocol> scrollView = nil;
            if([strong_self conformsToProtocol:@protocol(AKTableViewControllerProtocol)]) {
                id<AKTableViewControllerProtocol> controller = strong_self;
                scrollView = controller.tableView;
            } else if([strong_self conformsToProtocol:@protocol(AKCollectionViewControllerProtocol)]) {
                id<AKCollectionViewControllerProtocol> controller = strong_self;
                scrollView = controller.collectionView;
            }
            
            //记录原始数据状态
            NSArray *sections = adapter.sections;
            NSUInteger offset = adapter.offset;
            
            adapter.offset = adapter.offsetStart;
            
            //实现了AKScrollViewControllerProtocol的controller
            id<AKScrollViewControllerProtocol> controller = strong_self;
            
            [controller AKLoadDataWithComplete:^ (AKLoadDataResult (^_Nullable organizeBlock)()){
                [self.ak_progressHUD hide:YES];
                self.ak_pullRefreshView.state = AKPullRefreshStateFinishRefresh;
                
                [adapter removeAllSections];
                
                AKLoadDataResult result = organizeBlock();
                if(result == AKLoadDataResultNewData) {
                    //刷新成功有数据
                    [scrollView reloadData];
                } else if(result == AKLoadDataResultNoData) {
                    //刷新成功无数据
                    self.ak_loadStateView.state = AKLoadStateDataEmpty;
                    [scrollView reloadData];
                } else if(result == AKLoadDataResultFailed) {
                    //刷新失败
                    adapter.offset = offset;
                    [adapter addSections:sections];
                }
            }];
        };
        
        [ak_pullRefreshViewMapTable setObject:view forKey:@([self hash]).description];
        [view startObserver];
    } else {
        AKPullRefreshView *view = [ak_pullRefreshViewMapTable objectForKey:@(self.hash).description];
        [view stopObserver];
        [ak_pullRefreshViewMapTable removeObjectForKey:@(self.hash).description];
        [view removeFromSuperview];
    }
}

- (AKPullRefreshView *)ak_pullRefreshView {
    AKPullRefreshView *view = [ak_pullRefreshViewMapTable objectForKey:@(self.hash).description];
    [self.view bringSubviewToFront:view];
    return view;
}
//- (void)setAk_pullRefreshView:(AKPullRefreshView *)ak_pullRefreshView {
//    AKPullRefreshView *view = [ak_pullRefreshViewMapTable objectForKey:@(self.hash).description];
//    if([view isEqual:ak_pullRefreshView]) {
//        return;
//    }
//    [view stopObserver];
//    
//    [ak_pullRefreshViewMapTable setObject:ak_pullRefreshView forKey:@([self hash]).description];
//    [ak_pullRefreshView startObserver];
//}

#pragma mark- PushLoadView

static NSMapTable *ak_pushLoadViewMapTable = nil;

- (BOOL)ak_startPushLoadView {
    return !![ak_pushLoadViewMapTable objectForKey:@(self.hash).description];
}
- (void)setAk_startPushLoadView:(BOOL)ak_startPushLoadView {
    if(![self conformsToProtocol:@protocol(AKScrollViewControllerProtocol)]) {
        return;
    }
    
    if(ak_startPushLoadView) {
        if ([ak_pushLoadViewMapTable objectForKey:@(self.hash).description]) {
            return;
        }
        
        AKPushLoadView *view = [[AKPushLoadView alloc] init];
        id<AKScrollViewControllerProtocol> controller = self;
        [controller.scrollView addSubview:view];
        
        __weak typeof(self) weak_self = self;
        view.triggerToLoadBlock = ^() {
            __strong typeof(weak_self) strong_self = weak_self;
            
            if (self.ak_pullRefreshView.state == AKPullRefreshStateRefreshing) {
                self.ak_pushLoadView.state = AKPushLoadStateFinishLoad;
                return;
            }
            
            self.ak_pullRefreshView.state = AKPullRefreshStateFinishRefresh;
            self.ak_pushLoadView.state = AKPushLoadStateLoading;
            
            //如果实现了AKTableViewControllerAdapterProtocol
            id<AKTableViewAdapterProtocol, AKTableViewDelegateProtocol> adapter = nil;
            if([self conformsToProtocol:@protocol(AKTVCAdapterProtocol)]) {
                id<AKTVCAdapterProtocol> controller = self;
                adapter = controller.adapter;
            }
            
            //实现了AKScrollViewControllerProtocol的controller
            id<AKScrollViewControllerProtocol> controller = self;
            
            //如果实现了AKTableViewControllerProtocol
            id<AKScrollViewDataProtocol> scrollView = nil;
            if([self conformsToProtocol:@protocol(AKTableViewControllerProtocol)]) {
                id<AKTableViewControllerProtocol> controller = self;
                scrollView = controller.tableView;
            } else if([strong_self conformsToProtocol:@protocol(AKCollectionViewControllerProtocol)]) {
                id<AKCollectionViewControllerProtocol> controller = strong_self;
                scrollView = controller.collectionView;
            }
            
            //记录原始数据状态
            NSUInteger offset = adapter.offset;
            adapter.offset++;
            
            [controller AKLoadDataWithComplete:^ (AKLoadDataResult (^_Nullable organizeBlock)()) {
                AKLoadDataResult result = organizeBlock();
                if(result == AKLoadDataResultNewData) {
                    //加载成功有数据
                    self.ak_pushLoadView.state = AKPushLoadStateFinishLoad;
                    [scrollView reloadData];
                } else if(result == AKLoadDataResultNoData) {
                    //加载成功无数据
                    self.ak_pushLoadView.state = AKPushLoadStateNoMoreData;
                } else if(result == AKLoadDataResultFailed) {
                    //加载失败
                    adapter.offset = offset;
                    self.ak_pushLoadView.state = AKPushLoadStateNoNetwork;
                }
            }];
        };
        
        [ak_pushLoadViewMapTable setObject:view forKey:@(self.hash).description];
        [view startObserver];
    } else {
        AKPushLoadView *view = [ak_pushLoadViewMapTable objectForKey:@(self.hash).description];
        [view stopObserver];
        [ak_pushLoadViewMapTable removeObjectForKey:@(self.hash).description];
        [view removeFromSuperview];
    }
}

- (AKPushLoadView *)ak_pushLoadView {
    AKPushLoadView *view = [ak_pushLoadViewMapTable objectForKey:@(self.hash).description];
    [self.view bringSubviewToFront:view];
    return view;
}
- (void)setAk_pushLoadView:(AKPushLoadView *)ak_pushLoadView {
    AKPushLoadView *view = [ak_pushLoadViewMapTable objectForKey:@(self.hash).description];
    if([view isEqual:ak_pushLoadView]) {
        return;
    }
    [view stopObserver];
    
    [ak_pushLoadViewMapTable setObject:ak_pushLoadView forKey:@([self hash]).description];
    [ak_pushLoadView startObserver];
}

#pragma mark- load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ak_pullRefreshViewMapTable = NSMapTable.strongToWeakObjectsMapTable;
        ak_pushLoadViewMapTable = NSMapTable.strongToWeakObjectsMapTable;
    });
}

@end
