//
//  AKTableViewController.m
//  Pods
//
//  Created by 李翔宇 on 15/12/29.
//
//

#import "AKTableViewController.h"
#import "AKTableViewAdapter.h"
#import "AKViewControllerMacro.h"
#import "UIViewController+AKState.h"
#import "UIViewController+AKScrollState.h"

@interface AKTableViewController ()

@property (nonatomic, assign) UITableViewStyle style;
@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation AKTableViewController

#pragma mark - 生命周期
- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    self.ak_startPullRefreshView = NO;
    self.ak_startPushLoadView = NO;
    AKViewControllerLog(@"%@销毁", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        tableView.clipsToBounds = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = YES;
        [self.view addSubview:tableView];
        tableView;
    });
    
    if(self.style == UITableViewStyleGrouped) {
        self.tableView.tableHeaderView = self.ak_nilViewForGroupStyle;
        self.tableView.tableFooterView = self.ak_nilViewForGroupStyle;
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.ak_topConstraint = make.top.mas_equalTo(self.mas_topLayoutGuide);
        self.ak_bottomConstraint = make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.leading.mas_equalTo(0.);
        make.trailing.mas_equalTo(0.);
    }];
        
    self.adapter = [[AKTableViewAdapter alloc] init];
    self.adapter.offsetStart = 1;
    self.tableView.delegate = self.adapter;
    self.tableView.dataSource = self.adapter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 重载方法
- (void)AKLoadData {
    AKViewControllerLog(@"执行父类AKLoadData");
    
    self.adapter.offset = self.adapter.offsetStart;
    
    self.ak_progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.ak_progressHUD.label.text = nil;
    [self.ak_progressHUD showAnimated:YES];
    
    self.ak_pushLoadView.state = AKPushLoadStateNormal;
    
    //记录原始数据状态
    [self AKLoadDataWithComplete:^(AKLoadDataResult (^_Nullable organizeBlock)()){
        [self.ak_progressHUD hideAnimated:YES];
        
        [self.adapter removeAllSections];
        
        AKLoadDataResult result = organizeBlock();
        if (result == AKLoadDataResultNewData) {
            //加载成功有数据
            self.ak_loadStateView.state = AKLoadStateNormal;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView scrollRectToVisible:CGRectMake(0., 0., CGRectGetWidth(self.tableView.bounds), CGFLOAT_MIN) animated:NO];
                });
            });
        } else if (result == AKLoadDataResultNoData) {
            //加载成功无数据
            self.ak_loadStateView.state = AKLoadStateDataEmpty;
        } else if (result == AKLoadDataResultFailed) {
            if(self.adapter.sections.count) {
                return;
            }
            //加载失败
            self.ak_loadStateView.state = AKLoadStateNetworkError;
        }
    }];
}

- (void)AKLoadDataWithComplete:(void(^ _Nonnull)(AKLoadDataResult(^_Nonnull organizeBlock)()))complete {
    AKViewControllerLog(@"执行父类AKLoadDataWithComplete");
}

- (void)AKReceiveNotification:(NSNotification *)notification {
    AKViewControllerLog(@"执行父类AKReceiveNotification:");
}

#pragma mark - 协议方法
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if(self) {
        _style = style;
    }
    return self;
}

- (UIScrollView<AKScrollViewDataProtocol> *)scrollView {
    return (UIScrollView<AKScrollViewDataProtocol> *)self.tableView;
}

- (void)setAdapter:(id<AKTableViewAdapterProtocol, AKTableViewDelegateProtocol>)adapter {
    if([_adapter isEqual:adapter]) {
        return;
    }
    
    _adapter = adapter;
    _adapter.scrollView = (UIScrollView<AKScrollViewDataProtocol> *)self.tableView;
}

#pragma mark- 公开方法
- (UIView *)ak_nilViewForGroupStyle {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 0., CGFLOAT_MIN)];
    return view;
}

@end
