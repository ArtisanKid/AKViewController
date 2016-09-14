//
//  AKCollectionViewController.h
//  Pods
//
//  Created by 李翔宇 on 16/9/14.
//
//

#import "AKViewController.h"
#import "AKCollectionViewControllerProtocol.h"
#import "AKCVCAdapterProtocol.h"

@interface AKCollectionViewController : AKViewController<AKCollectionViewControllerProtocol, AKCVCAdapterProtocol>

@property (nonatomic, strong, readonly) UIScrollView<AKScrollViewDataProtocol> *scrollView;

- (instancetype)init;
@property (nonatomic, strong) UICollectionViewLayout *layout;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, strong) id<AKCollectionViewAdapterProtocol, AKCollectionViewDelegateProtocol> adapter;

@end
