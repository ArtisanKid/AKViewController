//
//  AKTableViewSectionProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/1/5.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewRowProtocol.h"
#import "AKTableViewSectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewSectionProtocol <NSObject>

@required

/**
 *  AKSection存储的AKRow数组
 */
@property (nonatomic, strong, readonly) NSArray<id<AKTableViewRowProtocol>> *rows;

/**
 *  SectionHeader
 */
@property (nullable, nonatomic, strong) id<AKTableViewSectionViewProtocol> header;

/**
 *  SectionFooter
 */
@property (nullable, nonatomic, strong) id<AKTableViewSectionViewProtocol> footer;

+ (id<AKTableViewSectionProtocol>)sectionWithRows:(NSArray<id<AKTableViewRowProtocol>> *)rows;

- (void)addRow:(id<AKTableViewRowProtocol>)row;
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows;

- (void)insertRow:(id<AKTableViewRowProtocol>)row index:(NSUInteger)index;

- (void)removeRowAtIndex:(NSUInteger)index;
- (void)removeAllRows;

@end

NS_ASSUME_NONNULL_END
