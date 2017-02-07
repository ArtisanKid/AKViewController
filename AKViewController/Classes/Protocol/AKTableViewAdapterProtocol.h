//
//  AKTableViewAdapterProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/1/4.
//
//

#import <Foundation/Foundation.h>
#import "AKScrollViewAdapterProtocol.h"
#import "AKTableViewRowProtocol.h"
#import "AKTableViewSectionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewAdapterProtocol <AKScrollViewAdapterProtocol, UITableViewDataSource, UITableViewDelegate>

@required

//AKTableViewAdapter存储的AKSection数组
@property (nonatomic, strong, readonly) NSArray<id<AKTableViewSectionProtocol>> *sections;

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
