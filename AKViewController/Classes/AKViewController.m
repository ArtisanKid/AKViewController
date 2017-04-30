//
//  AKViewController.m
//  Pods
//
//  Created by 李翔宇 on 3/2/15.
//
//

#import "AKViewController.h"
#import "AKViewControllerMacro.h"

@interface AKViewController ()

@end

@implementation AKViewController

#pragma mark- 生命周期

- (void)dealloc {
    //取消所有的操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [NSNotificationCenter.defaultCenter removeObserver:self];
    AKViewControllerLog(@"%@销毁", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //这是坑，当容器Controller嵌套的时候，需要指定这个属性是NO，否则对于UIScrollView及其子类很容易出现各种稀奇古怪的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = AKViewController_BackgroundColor;
    
    //默认不启动ProgressHUD，谁使用谁启动
    //self.ak_startProgressHUD = YES;
    
    //默认不启动ProgressHUD，谁使用谁启动
    //self.ak_startLoadStateView = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AKViewControllerLog(@"执行父类viewWillAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AKViewControllerLog(@"执行父类viewWillDisappear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AKViewControllerLog(@"执行父类viewDidAppear");
}

- (void)viewDidDisAppear:(BOOL)animated {
    [super viewDidDisappear:animated];
    AKViewControllerLog(@"执行父类viewDidDisAppear");
}

//#pragma mark- 私有方法
//- (void)selfPop:(UIBarButtonItem *)item {
//    if(self.navigationController) {
//        if(self.navigationController.viewControllers.count > 1) {
//            [self.navigationController popViewControllerAnimated:YES];
//        } else if(self.navigationController.presentingViewController) {
//            [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
//        } else if(self.navigationController.parentViewController) {
//            [self.navigationController removeFromParentViewController];
//        } else {
//            AKViewControllerLog(@"What The FUCK!!!");
//        }
//    } else {
//        if(self.presentingViewController) {
//            [self dismissViewControllerAnimated:YES completion:^{}];
//        } else if(self.parentViewController) {
//            [self removeFromParentViewController];
//        } else {
//            AKViewControllerLog(@"What The FUCK!!!");
//        }
//    }
//}

#pragma mark - 重载方法
- (void)AKReceiveNotification:(NSNotification *)notification {
    AKViewControllerLog(@"执行父类AKReceiveNotification:\n%@", notification);
}

- (void)AKLoadData {
    AKViewControllerLog(@"执行父类AKLoadData");
}
//
//#pragma mark- 公开方法
//- (void)sjb_installBackBarButtonItem {
//    if(!self.navigationController) {
//        return;
//    }
//    
//    NSString *popImage = nil;
//    if (self.navigationController.viewControllers.count > 1) {
//        //没有在最下面的话，那么可以默认设置一个返回按钮
//        if([self.navigationController.viewControllers indexOfObject:self]) {
//            if(!self.ak_backBarButtonItemImage) {
//                AKViewControllerLog(@"没有设置返回按钮图片");
//                return;
//            }
//            
//            popImageName = self.ak_backBarButtonItemImage;
//        } else {
//            return;
//        }
//    } else {
//        popImageName = self.ak_closeBarButtonItemImage;
//    }
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:popImageName] 
//                                                             style:UIBarButtonItemStylePlain target:self action:@selector(selfPop:)];
//    
//    NSMutableArray<UIBarButtonItem *> *items = [self.navigationItem.leftBarButtonItems mutableCopy];
//    if(!items) {
//        items = [NSMutableArray array];
//    }
//    [items insertObject:item atIndex:0];
//    self.navigationItem.leftBarButtonItems = items;
//    
//    self.view.hidden
//}
//
//#pragma mark- 公开方法
//- (void)setAk_backBarButtonItemHidden:(BOOL)hidden {
//    if(!self.navigationController) {
//        return;
//    }
//    
//    if(_ak_hideBackBarButtonItem == hidden) {
//        return;
//    }
//    
//    if (hide) {
//        if(_ak_hideBackBarButtonItem) {
//            NSMutableArray<UIBarButtonItem *> *items = [self.navigationItem.leftBarButtonItems mutableCopy];
//            if(items.count) {
//                [items removeObject:items.firstObject];
//            }
//            self.navigationItem.leftBarButtonItems = items;
//        }
//    } else {
//        [self sjb_installBackBarButtonItem];
//    }
//}
//
#pragma mark- 配置方法
UIColor *AKViewController_BackgroundColor = nil;
+ (void)setAk_backgroundColor:(UIColor *)color {
    AKViewController_BackgroundColor = color;
}

//UIImage *AKViewController_BackBarButtonItemImage = nil;
//+ (void)setAk_backBarButtonItemImage:(UIImage *)image {
//    AKViewController_BackBarButtonItemImage = image;
//}
//
//UIImage *AKViewController_CloseBarButtonItemImage = nil;
//+ (void)setAk_closeBarButtonItemImage:(UIImage *)image {
//    AKViewController_CloseBarButtonItemImage = image;
//}

@end
