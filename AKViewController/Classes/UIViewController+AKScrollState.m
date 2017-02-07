//
//  UIViewController+AKScrollState.m
//  Pods
//
//  Created by 李翔宇 on 16/4/22.
//
//

#import "UIViewController+AKScrollState.h"
#import "UIViewController+AKState.h"
#import "AKScrollViewControllerProtocol.h"
#import "AKScrollViewAdapterProtocol.h"
#import "AKPullRefreshView.h"
#import "AKPushLoadView.h"

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
        
        if(![self conformsToProtocol:@protocol(AKScrollViewControllerProtocol)]) {
            return;
        }
        
        id<AKScrollViewControllerProtocol> controller = self;
        UIScrollView<AKScrollViewDataProtocol> *scrollView = controller.scrollView;
        id<AKScrollViewAdapterProtocol> adapter = controller.adapter;
        
        AKPullRefreshView *view = [[AKPullRefreshView alloc] init];
        [scrollView addSubview:view];
        
        __weak typeof(self) weak_self = self;
        __weak typeof(controller) weak_controller = controller;
        view.triggerToRefreshBlock = ^() {
            __strong typeof(weak_self) strong_self = weak_self;
            __strong typeof(weak_controller) strong_controller = weak_controller;
            
            if (strong_self.ak_pushLoadView.state == AKPushLoadStateLoading) {
                strong_self.ak_pullRefreshView.state = AKPullRefreshStateFinishRefresh;
                return;
            }
            
            strong_self.ak_pushLoadView.state = AKPushLoadStateFinishLoad;
            strong_self.ak_pullRefreshView.state = AKPullRefreshStateRefreshing;
            
            strong_self.ak_progressHUD.mode = MBProgressHUDModeIndeterminate;
            strong_self.ak_progressHUD.labelText = nil;
            [strong_self.ak_progressHUD show:YES];
            
            //记录原始数据状态
            NSArray *datas = adapter.datas;
            NSUInteger offset = adapter.offset;
            
            adapter.offset = adapter.offsetStart;
            
            [strong_controller AKLoadDataWithComplete:^ (AKLoadDataResult (^_Nullable organizeBlock)()){
                [strong_self.ak_progressHUD hide:YES];
                strong_self.ak_pullRefreshView.state = AKPullRefreshStateFinishRefresh;
                
                adapter.datas = nil;
                
                AKLoadDataResult result = organizeBlock();
                if(result == AKLoadDataResultNewData) {
                    //刷新成功有数据
                    [scrollView reloadData];
                } else if(result == AKLoadDataResultNoData) {
                    //刷新成功无数据
                    strong_self.ak_loadStateView.state = AKLoadStateDataEmpty;
                    [scrollView reloadData];
                } else if(result == AKLoadDataResultFailed) {
                    //刷新失败
                    adapter.offset = offset;
                    adapter.datas = datas;                }
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
        
        if(![self conformsToProtocol:@protocol(AKScrollViewControllerProtocol)]) {
            return;
        }
        
        id<AKScrollViewControllerProtocol> controller = self;
        UIScrollView<AKScrollViewDataProtocol> *scrollView = controller.scrollView;
        id<AKScrollViewAdapterProtocol> adapter = controller.adapter;
        
        AKPushLoadView *view = [[AKPushLoadView alloc] init];
        [scrollView addSubview:view];
        
        __weak typeof(self) weak_self = self;
        __weak typeof(controller) weak_controller = controller;
        view.triggerToLoadBlock = ^() {
            __strong typeof(weak_self) strong_self = weak_self;
            __strong typeof(weak_controller) strong_controller = weak_controller;
            
            if (strong_self.ak_pullRefreshView.state == AKPullRefreshStateRefreshing) {
                strong_self.ak_pushLoadView.state = AKPushLoadStateFinishLoad;
                return;
            }
            
            strong_self.ak_pullRefreshView.state = AKPullRefreshStateFinishRefresh;
            strong_self.ak_pushLoadView.state = AKPushLoadStateLoading;
            
            //记录原始数据状态
            NSUInteger offset = adapter.offset;
            adapter.offset++;
            
            [strong_controller AKLoadDataWithComplete:^ (AKLoadDataResult (^_Nullable organizeBlock)()) {
                AKLoadDataResult result = organizeBlock();
                if(result == AKLoadDataResultNewData) {
                    //加载成功有数据
                    strong_self.ak_pushLoadView.state = AKPushLoadStateFinishLoad;
                    [scrollView reloadData];
                } else if(result == AKLoadDataResultNoData) {
                    //加载成功无数据
                    strong_self.ak_pushLoadView.state = AKPushLoadStateNoMoreData;
                } else if(result == AKLoadDataResultFailed) {
                    //加载失败
                    adapter.offset = offset;
                    strong_self.ak_pushLoadView.state = AKPushLoadStateNoNetwork;
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
