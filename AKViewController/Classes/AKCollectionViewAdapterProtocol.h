//
//  AKCollectionViewAdapterProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/9/14.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AKCollectionViewAdapterProtocol <UICollectionViewDataSource, UICollectionViewDelegate>

@required

/**
 *  数据分页大小，默认值为20
 */
@property (nonatomic, assign) NSUInteger pageSize;

/**
 *  起始数据偏移量
 */
@property (nonatomic, assign) NSUInteger offsetStart;

/**
 *  数据偏移量，简单列表无需自己手动管理请求位置
 *  offset根据接口设置不同，含义可能不同
 *  (1)表示第几页
 *  (2)表示第几条
 */
@property (nonatomic, assign) NSUInteger offset;

/**
 *  当前管理的tableView
 */
@property (nullable, nonatomic, weak) UICollectionView *collectionView;

/**
 *  是否自动重新加载数据
 */
@property (nonatomic, assign, getter=isAutoReloadData) BOOL autoReloadData;

@end

NS_ASSUME_NONNULL_END
