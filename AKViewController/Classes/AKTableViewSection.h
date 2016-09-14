//
//  AKTableViewSection.h
//  Pods
//
//  Created by 李翔宇 on 16/1/5.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewSectionProtocol.h"
#import "AKTableViewSectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKTableViewSection : NSObject<AKTableViewSectionProtocol>

@property (nonatomic, strong, readonly) NSArray<id<AKTableViewRowProtocol>> *rows;

@property (nullable, nonatomic, strong) id<AKTableViewSectionViewProtocol> header;
@property (nullable, nonatomic, strong) id<AKTableViewSectionViewProtocol> footer;

+ (id<AKTableViewSectionProtocol>)sectionWithRows:(NSArray<id<AKTableViewRowProtocol>> *)rows;

- (void)addRow:(id<AKTableViewRowProtocol>)row;
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows;

- (void)insertRow:(id<AKTableViewRowProtocol>)row index:(NSUInteger)index;

- (void)removeRowAtIndex:(NSUInteger)index;
- (void)removeAllRows;

@end

NS_ASSUME_NONNULL_END
