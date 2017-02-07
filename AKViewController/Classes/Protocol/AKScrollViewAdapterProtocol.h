//
//  AKScrollViewAdapterProtocol.h
//  Pods
//
//  Created by 李翔宇 on 2017/2/6.
//
//

#import <Foundation/Foundation.h>
#import "AKScrollViewDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKScrollViewAdapterProtocol <NSObject>

@required

//数据分页大小，默认值为20
@property (nonatomic, assign) NSUInteger pageSize;

//起始数据偏移量
@property (nonatomic, assign) NSUInteger offsetStart;

/**
 数据偏移量，简单列表无需自己手动管理请求位置
 offset根据接口设置不同，含义可能不同
 (1)表示第几页
 (2)表示第几条
 */
@property (nonatomic, assign) NSUInteger offset;

//当前管理的scrollView
@property (nullable, nonatomic, weak) UIScrollView<AKScrollViewDataProtocol> *scrollView;

/**
 是否自动重新加载数据
 设置为YES的时候，每次更改数据源都会导致界面刷新
 */
@property (nonatomic, assign, getter=isAutoReloadData) BOOL autoReloadData;

//AKScrollViewAdapter存储的数据数组
@property (nonatomic, strong) NSArray<id/*不同子类指定不同类型*/> *datas;

@end

NS_ASSUME_NONNULL_END
