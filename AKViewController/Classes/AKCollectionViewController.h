//
//  AKCollectionViewController.h
//  Pods
//
//  Created by 李翔宇 on 16/9/14.
//
//

#import "AKViewController.h"
#import "AKScrollViewControllerProtocol.h"
#import "AKCollectionViewAdapterProtocol.h"
#import "AKCollectionViewDelegateProtocol.h"

@interface AKCollectionViewController : AKViewController<AKScrollViewControllerProtocol>

#pragma mark - AKScrollViewControllerProtocol
@property (nonatomic, strong, readonly) UIScrollView<AKScrollViewDataProtocol> *scrollView;
@property (nonatomic, strong) id<AKCollectionViewAdapterProtocol, AKCollectionViewDelegateProtocol> adapter;

#pragma mark - Interface
- (instancetype)init;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end
