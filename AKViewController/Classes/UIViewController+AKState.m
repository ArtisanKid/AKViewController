//
//  UIViewController+AKState.m
//  Pods
//
//  Created by 李翔宇 on 16/4/22.
//
//

#import "UIViewController+AKState.h"
#import <Masonry/Masonry.h>
#import "AKViewControllerProtocol.h"

@implementation UIViewController (AKState)

#pragma mark- ProgressHUD

@dynamic ak_startProgressHUD;
@dynamic ak_startDimProgressHUD;
@dynamic ak_progressHUD;
@dynamic ak_dimProgressHUD;

static NSMapTable *ak_progressHUDMapTable = nil;
static NSMapTable *ak_dimProgressHUDMapTable = nil;

- (BOOL)ak_startProgressHUD {
    return !![ak_progressHUDMapTable objectForKey:@(self.hash).description];
}
- (void)setAk_startProgressHUD:(BOOL)start {
    if(start) {
        self.ak_startDimProgressHUD = NO;
        
        if ([ak_progressHUDMapTable objectForKey:@(self.hash).description]) {
            return;
        }
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        
        [ak_progressHUDMapTable setObject:hud forKey:@(self.hash).description];
    } else {
        MBProgressHUD *hud = [ak_progressHUDMapTable objectForKey:@(self.hash).description];
        [hud removeFromSuperview];
        [ak_progressHUDMapTable removeObjectForKey:@(self.hash).description];
    }
}

- (MBProgressHUD *)ak_progressHUD {
    MBProgressHUD *hud = [ak_progressHUDMapTable objectForKey:@(self.hash).description];
    [self.view bringSubviewToFront:hud];
    return hud;
}

- (BOOL)ak_startDimProgressHUD {
    return !![ak_dimProgressHUDMapTable objectForKey:@(self.hash).description];
}
- (void)setAk_startDimProgressHUD:(BOOL)start {
    if(start) {
        self.ak_startProgressHUD = NO;
        
        if ([ak_dimProgressHUDMapTable objectForKey:@(self.hash).description]) {
            return;
        }
        
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:window];
        [window addSubview:hud];
        
        [ak_dimProgressHUDMapTable setObject:hud forKey:@(self.hash).description];
    } else {
        MBProgressHUD *hud = [ak_dimProgressHUDMapTable objectForKey:@(self.hash).description];
        [hud removeFromSuperview];
        [ak_dimProgressHUDMapTable removeObjectForKey:@(self.hash).description];
    }
}

- (MBProgressHUD *)ak_dimProgressHUD {
    MBProgressHUD *hud = [ak_dimProgressHUDMapTable objectForKey:@(self.hash).description];
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    [window bringSubviewToFront:hud];
    return hud;
}

#pragma mark- LoadStateView

@dynamic ak_startLoadStateView;
@dynamic ak_loadStateView;

static NSMapTable *ak_loadStateViewMapTable = nil;

- (BOOL)ak_startLoadStateView {
    return !![ak_loadStateViewMapTable objectForKey:@(self.hash).description];
}
- (void)setAk_startLoadStateView:(BOOL)ak_startLoadStateView {
    if(ak_startLoadStateView) {
        if ([ak_loadStateViewMapTable objectForKey:@(self.hash).description]) {
            return;
        }
        
        AKLoadStateView *view = [[AKLoadStateView alloc] init];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0.f);
        }];
        
        __weak typeof(self) weak_self = self;
        [view setTouchUpInsideBlock:^{
            __strong typeof(self) strong_self = self;
            if (strong_self.ak_loadStateView.state == AKLoadStateNetworkError) {
                if(![strong_self conformsToProtocol:@protocol(AKViewControllerProtocol)]) {
                    return;
                }
                
                if(![strong_self respondsToSelector:@selector(AKLoadData)]) {
                    return;
                }
                
                strong_self.ak_loadStateView.state = AKLoadStateDataLoading;
                id<AKViewControllerProtocol> controller = strong_self;
                [controller AKLoadData];
            }
        }];
        
        [ak_loadStateViewMapTable setObject:view forKey:@(self.hash).description];
    } else {
        AKLoadStateView *view = [ak_loadStateViewMapTable objectForKey:@(self.hash).description];
        [view removeFromSuperview];
        [ak_loadStateViewMapTable removeObjectForKey:@(self.hash).description];
    }
}

- (AKLoadStateView *)ak_loadStateView {
    AKLoadStateView *view = [ak_loadStateViewMapTable objectForKey:@(self.hash).description];
    [self.view bringSubviewToFront:view];
    return view;
}

#pragma mark- load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ak_progressHUDMapTable = NSMapTable.strongToWeakObjectsMapTable;
        ak_dimProgressHUDMapTable = NSMapTable.strongToWeakObjectsMapTable;
        ak_loadStateViewMapTable = NSMapTable.strongToWeakObjectsMapTable;
    });
}

@end
