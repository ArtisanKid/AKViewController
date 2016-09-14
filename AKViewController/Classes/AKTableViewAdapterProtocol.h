//
//  AKTableViewAdapterProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/1/4.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewRowProtocol.h"
#import "AKTableViewSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewAdapterProtocol <UITableViewDataSource, UITableViewDelegate>

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
 *  AKTableViewAdapter存储的AKSection数组
 */
@property (nonatomic, strong, readonly) NSArray<id<AKTableViewSectionProtocol>> *sections;

/**
 *  当前管理的tableView
 */
@property (nullable, nonatomic, weak) UITableView *tableView;

/**
 *  是否自动重新加载数据
 */
@property (nonatomic, assign, getter=isAutoReloadData) BOOL autoReloadData;

- (void)addRow:(id<AKTableViewRowProtocol>)row;
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows;
- (void)addRow:(id<AKTableViewRowProtocol>)row section:(NSUInteger)section;
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows section:(NSUInteger)section;

- (void)insertRow:(id<AKTableViewRowProtocol>)row indexPath:(NSIndexPath *)indexPath;

- (void)addSection:(id<AKTableViewSectionProtocol>)section;
- (void)addSections:(NSArray<id<AKTableViewSectionProtocol>> *)sections;

- (void)insertSection:(id<AKTableViewSectionProtocol>)section index:(NSUInteger)index;

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)removeAllSections;

@end

NS_ASSUME_NONNULL_END
