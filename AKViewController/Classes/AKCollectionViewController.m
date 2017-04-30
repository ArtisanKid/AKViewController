//
//  AKCollectionViewController.m
//  Pods
//
//  Created by 李翔宇 on 16/9/14.
//
//

#import "AKCollectionViewController.h"
#import <Masonry/Masonry.h>
#import "AKViewControllerMacro.h"
#import "UIViewController+AKState.h"
#import "UIViewController+AKScrollState.h"

@interface AKCollectionViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AKCollectionViewController

#pragma mark - 生命周期
- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    self.ak_startPullRefreshView = NO;
    self.ak_startPushLoadView = NO;
    AKViewControllerLog(@"%@销毁", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSParameterAssert(self.layout);
        
    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        collectionView.clipsToBounds = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        //collectionView.delegate = self;
        //collectionView.dataSource = self;
        [self.view addSubview:collectionView];
        collectionView;
    });
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.leading.trailing.mas_equalTo(0.);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 协议方法
- (UIScrollView<AKScrollViewDataProtocol> *)scrollView {
    return (UIScrollView<AKScrollViewDataProtocol> *)self.collectionView;
}

#pragma mark - Interface
- (void)setLayout:(UICollectionViewLayout *)layout {
    NSParameterAssert(layout);
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView reloadData];
}

- (void)setAdapter:(id<AKCollectionViewAdapterProtocol, AKCollectionViewDelegateProtocol>)adapter {
    if([_adapter isEqual:adapter]) {
        return;
    }
    
    _adapter = adapter;
    //_adapter.scrollView = (UIScrollView *)self.collectionView;
}

@end
