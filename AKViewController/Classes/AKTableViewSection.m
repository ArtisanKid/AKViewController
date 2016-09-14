//
//  AKTableViewSection.m
//  Pods
//
//  Created by 李翔宇 on 16/1/5.
//
//

#import "AKTableViewSection.h"
#import <libkern/OSAtomic.h>
#import "AKViewControllerMacro.h"

@interface AKTableViewSection ()

@property (nonatomic, strong) NSMutableArray<id<AKTableViewRowProtocol>> *rowsM;

@end

@implementation AKTableViewSection

static OSSpinLock AKTableViewSectionLock = OS_SPINLOCK_INIT;

#pragma mark- 属性方法
- (NSMutableArray<id<AKTableViewRowProtocol>> *)rowsM {
    if(!_rowsM) {
        _rowsM = [NSMutableArray array];
    }
    return _rowsM;
}

- (NSArray<id<AKTableViewRowProtocol>> *)rows {
    return [self.rowsM copy];
}

#pragma mark- AKTableViewSectionProtocol
+ (id<AKTableViewSectionProtocol>)sectionWithRows:(NSArray<id<AKTableViewRowProtocol>> *)rows {
    AKTableViewSection *section = [[AKTableViewSection alloc] init];
    [section.rowsM addObjectsFromArray:rows];
    return section;
}

- (void)addRow:(id<AKTableViewRowProtocol>)row {
    [self addRows:@[row]];
}
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows {
    OSSpinLockLock(&AKTableViewSectionLock);
    [self.rowsM addObjectsFromArray:rows];
    OSSpinLockUnlock(&AKTableViewSectionLock);
}

- (void)insertRow:(id<AKTableViewRowProtocol>)row index:(NSUInteger)index {
    OSSpinLockLock(&AKTableViewSectionLock);
    if(index >= self.rows.count) {
        OSSpinLockUnlock(&AKTableViewSectionLock);
        AKViewControllerLog(@"插入的位置index:%@ 越界，数组长度:%@", @(index), @(self.rows.count));
        return;
    }
    [self.rowsM insertObject:row atIndex:index];
    OSSpinLockUnlock(&AKTableViewSectionLock);
}

- (void)removeRowAtIndex:(NSUInteger)index {
    OSSpinLockLock(&AKTableViewSectionLock);
    if(index >= self.rows.count) {
        OSSpinLockUnlock(&AKTableViewSectionLock);
        AKViewControllerLog(@"插入的位置index:%@ 越界，数组长度:%@", @(index), @(self.rows.count));
        return;
    }
    [self.rowsM removeObjectAtIndex:index];
    OSSpinLockUnlock(&AKTableViewSectionLock);
}

- (void)removeAllRows {
    OSSpinLockLock(&AKTableViewSectionLock);
    [self.rowsM removeAllObjects];
    OSSpinLockUnlock(&AKTableViewSectionLock);
}

@end
