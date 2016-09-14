//
//  AKCollectionViewControllerProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/9/14.
//
//

#import <Foundation/Foundation.h>
#import "AKScrollViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKCollectionViewControllerProtocol <AKScrollViewControllerProtocol>

@required

- (instancetype)init;

@property (nonatomic, strong, readonly) UICollectionViewLayout *layout;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
