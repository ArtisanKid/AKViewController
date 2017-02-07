//
//  AKTableViewAdapter.m
//  Pods
//
//  Created by 李翔宇 on 16/1/4.
//
//

#import "AKTableViewAdapter.h"
#import <libkern/OSAtomic.h>
#import <objc/runtime.h>
#import "AKViewControllerMacro.h"

CGFloat AKTableViewComponentHeightAuto = -1.f;

@interface AKTableViewAdapter()

@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger offsetStart;
@property (nonatomic, assign) NSUInteger offset;

@property (nonatomic, weak) UITableView *scrollView;
@property (nonatomic, assign, getter=isAutoReloadData) BOOL autoReloadData;
@property (nonatomic, strong) NSArray<id> *datas;

#pragma mark- AKTableViewDelegateProtocol

@property (nonatomic, strong) void(^willDisplayCell)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^willDisplayHeaderView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, strong) void(^willDisplayFooterView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, strong) void(^didEndDisplayingCell)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^didEndDisplayingHeaderView)(UITableView *tableView, UIView *view, NSInteger section);
@property (nonatomic, strong) void(^didEndDisplayingFooterView)(UITableView *tableView, UIView *view, NSInteger section);

@property (nonatomic, strong) CGFloat(^heightForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) CGFloat(^heightForHeader)(UITableView *tableView, NSInteger section);
@property (nonatomic, strong) CGFloat(^heightForFooter)(UITableView *tableView, NSInteger section);

@property (nonatomic, strong) CGFloat(^estimatedHeightForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) CGFloat(^estimatedHeightForHeader)(UITableView *tableView, NSInteger section);
@property (nonatomic, strong) CGFloat(^estimatedHeightForFooter)(UITableView *tableView, NSInteger section);

@property (nonatomic, strong) UIView *(^viewForHeader)(UITableView *tableView, NSInteger section);
@property (nonatomic, strong) UIView *(^viewForFooter)(UITableView *tableView, NSInteger section);

@property (nonatomic, strong) void (^accessoryButtonTappedForRow)(UITableView *tableView, NSIndexPath *indexPath);

@property (nonatomic, strong) BOOL(^shouldHighlightRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^didHighlightRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^didUnhighlightRow)(UITableView *tableView, NSIndexPath *indexPath);

@property (nonatomic, strong) NSIndexPath *(^willSelectRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) NSIndexPath *(^willDeselectRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^didSelectRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^didDeselectRow)(UITableView *tableView, NSIndexPath *indexPath);


@property (nonatomic, strong) UITableViewCellEditingStyle(^editingStyleForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) NSString *(^titleForDeleteConfirmationButtonForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) NSArray<UITableViewRowAction *> *(^editActionsForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) BOOL(^shouldIndentWhileEditingRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^willBeginEditingRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) void(^didEndEditingRow)(UITableView *tableView, NSIndexPath *indexPath);

@property (nonatomic, strong) NSIndexPath *(^moveRow)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);

@property (nonatomic, strong) NSInteger(^indentationLevelForRow)(UITableView *tableView, NSIndexPath *indexPath);

@property (nonatomic, strong) BOOL(^shouldShowMenuForRow)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, strong) BOOL(^canPerformActionForRow)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);
@property (nonatomic, strong) BOOL(^performActionForRow)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);

@property (nonatomic, strong) BOOL(^canFocusRow)(UITableView *tableView, NSIndexPath *indexPath) NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) BOOL(^shouldUpdateFocus)(UITableView *tableView, UITableViewFocusUpdateContext *context) NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) BOOL(^didUpdateFocus)(UITableView *tableView, UITableViewFocusUpdateContext *context, UIFocusAnimationCoordinator *coordinator) NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) NSIndexPath *(^indexPathForPreferredFocusedView)(UITableView *tableView) NS_AVAILABLE_IOS(9_0);

#pragma mark- AKScrollViewDelegateProtocol

@property (nonatomic, strong) void(^didScroll)(UIScrollView *scrollView);
@property (nonatomic, strong) void(^willBeginDragging)(UIScrollView *scrollView);
@property (nonatomic, strong) void(^willEndDragging)(UIScrollView *scrollView, CGPoint velocity, CGPoint *targetContentOffset);
@property (nonatomic, strong) void(^didEndDragging)(UIScrollView *scrollView, BOOL decelerate);
@property (nonatomic, strong) void(^willBeginDecelerating)(UIScrollView *scrollView);
@property (nonatomic, strong) void(^didEndDecelerating)(UIScrollView *scrollView);
@property (nonatomic, strong) void(^didEndScrollingAnimation)(UIScrollView *scrollView);
@property (nonatomic, strong) BOOL(^shouldScrollToTop)(UIScrollView *scrollView);
@property (nonatomic, strong) void(^didScrollToTop)(UIScrollView *scrollView);

#pragma mark- 内部参数
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<id<AKTableViewSectionProtocol>> *sectionsM;

@end

@implementation AKTableViewAdapter

#pragma mark- 私有方法
- (void)setScrollView:(UITableView *)scrollView {
    if([_scrollView isEqual:scrollView]) {
        return;
    }
    
    _scrollView = scrollView;
    if([_scrollView isKindOfClass:[UITableView class]]) {
        self.tableView = _scrollView;
    }
}

- (void)setTableView:(UITableView *)tableView {
    if(_tableView == tableView) {
        return;
    }
    
    _tableView = tableView;
    [self.sections enumerateObjectsUsingBlock:^(id<AKTableViewSectionProtocol> _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerSectionView:section.header];
        [self registerSectionView:section.footer];
        [section.rows enumerateObjectsUsingBlock:^(id<AKTableViewRowProtocol> _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
            [self registerRow:row];
        }];
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
}

- (void)registerRow:(id<AKTableViewRowProtocol>)row {
    if(!row) {
        return;
    }
    
    if(!row.identifier.length) {
        return;
    }
    
    [self.tableView registerClass:row.cell forCellReuseIdentifier:row.identifier];
}

- (void)registerSectionView:(id<AKTableViewSectionViewProtocol>)sectionView {
    if(!sectionView) {
        return;
    }
    
    if(!sectionView.identifier.length) {
        return;
    }
    
    if(![sectionView.view isSubclassOfClass:[UITableViewHeaderFooterView class]]) {
        return;
    }
    
    [self.tableView registerClass:sectionView.view forHeaderFooterViewReuseIdentifier:sectionView.identifier];
}

#pragma mark- 创建锁
static OSSpinLock AKTableViewAdapterLock = OS_SPINLOCK_INIT;

#pragma mark- 属性方法
- (NSMutableArray<id<AKTableViewSectionProtocol>> *)sectionsM {
    if(!_sectionsM) {
        _sectionsM = [NSMutableArray array];
    }
    return _sectionsM;
}

- (NSArray<id<AKTableViewSectionProtocol>> *)sections {
    return [self.sectionsM copy];
}

#pragma mark- AKTableViewAdapterProtocol
- (void)setOffsetStart:(NSUInteger)offsetStart {
    _offsetStart = offsetStart;
    self.offset = _offsetStart;
}

- (void)addRow:(id<AKTableViewRowProtocol>)row {
    [self addRows:@[row]];
}
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows {
    if(!self.sections.count) {
        //如果没有用户自定义的section，那么就使用默认的类初始化section
        AKTableViewSection *section = [[AKTableViewSection alloc] init];
        [self.sectionsM addObject:section];
    }
    [self addRows:rows section:self.sections.count - 1];
}
- (void)addRow:(id<AKTableViewRowProtocol>)row section:(NSUInteger)section {
    [self addRows:@[row] section:section];
}
- (void)addRows:(NSArray<id<AKTableViewRowProtocol>> *)rows section:(NSUInteger)section {
    OSSpinLockLock(&AKTableViewAdapterLock);
    if(section >= self.sections.count) {
        OSSpinLockUnlock(&AKTableViewAdapterLock);
        AKViewControllerLog(@"插入的位置indexPath.section:%@ 越界，数组长度:%@", @(section), @(self.sections.count));
        return;
    }
    
    [self.sections[section] addRows:rows];
    [rows enumerateObjectsUsingBlock:^(id<AKTableViewRowProtocol>  _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerRow:row];
    }];
    !self.isAutoReloadData ? : [self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}

- (void)insertRow:(id<AKTableViewRowProtocol>)row indexPath:(NSIndexPath *)indexPath {
    OSSpinLockLock(&AKTableViewAdapterLock);
    if(indexPath.section >= self.sections.count) {
        OSSpinLockUnlock(&AKTableViewAdapterLock);
        //数组越界
        AKViewControllerLog(@"插入的位置indexPath.section:%@ 越界，数组长度:%@", @(indexPath.section), @(self.sections.count));
        return;
    }
    
    if (indexPath.row >= self.sections[indexPath.section].rows.count) {
        OSSpinLockUnlock(&AKTableViewAdapterLock);
        //数组越界
        AKViewControllerLog(@"插入的位置indexPath.row:%@ 越界，数组长度:%@", @(indexPath.row), @(self.sections[indexPath.section].rows.count));
        return;
    }
    
    [self.sections[indexPath.section] insertRow:row index:indexPath.row];
    [self registerRow:row];
    !self.isAutoReloadData ? : [self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}

- (void)addSection:(id<AKTableViewSectionProtocol>)section {
    [self addSections:@[section]];
}
- (void)addSections:(NSArray<id<AKTableViewSectionProtocol>> *)sections {
    OSSpinLockLock(&AKTableViewAdapterLock);
    [self.sectionsM addObjectsFromArray:sections];
    [sections enumerateObjectsUsingBlock:^(id<AKTableViewSectionProtocol> _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerSectionView:section.header];
        [self registerSectionView:section.footer];
        [section.rows enumerateObjectsUsingBlock:^(id<AKTableViewRowProtocol> _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
            [self registerRow:row];
        }];
    }];
    !self.isAutoReloadData ? : [self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}

- (void)insertSection:(id<AKTableViewSectionProtocol>)section index:(NSUInteger)index {
    OSSpinLockLock(&AKTableViewAdapterLock);
    if(!self.sections.lastObject) {//如果没有用户自定义的section，那么就使用默认的类初始化section
        [self.sectionsM addObject:AKTableViewSection.new];
    }
    [self.sectionsM insertObject:section atIndex:index];
    
    [self registerSectionView:section.header];
    [self registerSectionView:section.footer];
    [section.rows enumerateObjectsUsingBlock:^(id<AKTableViewRowProtocol> _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerRow:row];
    }];
    !self.isAutoReloadData ? : [self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}

- (void)removeSectionAtIndex:(NSUInteger)index {
    OSSpinLockLock(&AKTableViewAdapterLock);
    [self.sectionsM removeObjectAtIndex:index];
    self.isAutoReloadData ?:[self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}
- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath {
    OSSpinLockLock(&AKTableViewAdapterLock);
    [self.sections[indexPath.section] removeRowAtIndex:indexPath.row];
    self.isAutoReloadData ?:[self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}

- (void)removeAllSections {
    OSSpinLockLock(&AKTableViewAdapterLock);
    self.sectionsM = nil;
    !self.isAutoReloadData ? : [self.tableView reloadData];
    OSSpinLockUnlock(&AKTableViewAdapterLock);
}

#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].rows.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.sections.count) {
        AKViewControllerLog(@"数组越界 sections.count：%@ 当前Index：%@", @(self.sections.count), @(indexPath.section));
    }
    
    if (indexPath.row >= self.sections[indexPath.section].rows.count) {
        AKViewControllerLog(@"数组越界 self.adapter.sections.rows.count：%@ 当前Index：%@", @(self.sections[indexPath.section].rows.count), @(indexPath.row));
    }
    
    id<AKTableViewRowProtocol> row = self.sections[indexPath.section].rows[indexPath.row];
    UITableViewCell<AKTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:row.identifier];
    if([cell respondsToSelector:@selector(AKDrawContent:)]) {
        [cell AKDrawContent:row.objToDraw];
    }
    return cell;
}

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

// fixed font style. use custom view (UILabel) if you want something different
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section].header.title;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.sections[section].footer.title;
}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section].rows[indexPath.row].canEditRow;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section].rows[indexPath.row].canMoveRow;
}

// Index

// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return [self.sections valueForKey:@"indexTitle"];
//}

// tell table which section corresponds to section title/index (e.g. "B",1))
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return 0;
//}

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.sections[indexPath.section] removeRowAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Data manipulation - reorder / moving support
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    id<AKTableViewRowProtocol> row = self.sections[sourceIndexPath.section].rows[sourceIndexPath.row];
    [self.sections[sourceIndexPath.section] removeRowAtIndex:sourceIndexPath.row];
    [self.sections[destinationIndexPath.section] insertRow:row index:destinationIndexPath.row];
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

#pragma mark- UITableViewDelegate

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.willDisplayCell ? : self.willDisplayCell(tableView, cell, indexPath);
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    !self.willDisplayHeaderView ? : self.willDisplayHeaderView(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    !self.willDisplayFooterView ? : self.willDisplayFooterView(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    !self.didEndDisplayingCell ? : self.didEndDisplayingCell(tableView, cell, indexPath);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    !self.didEndDisplayingHeaderView ? : self.didEndDisplayingHeaderView(tableView, view, section);
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    !self.didEndDisplayingFooterView ? : self.didEndDisplayingFooterView(tableView, view, section);
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<AKTableViewRowProtocol> row = self.sections[indexPath.section].rows[indexPath.row];
    if(row.height != AKTableViewComponentHeightAuto) {
        return row.height;
    }
    
    /*
     计算cell高度的时候，不再考虑父类协议
     首先尝试AKHeightOfContent:获取精确高度
     如果无法获取精确高度，那么就Autolayout自动计算高度，且和AKMinimumHeight(最小高度)比较
     */
    
    if(class_getClassMethod(row.cell, @selector(AKHeightOfContent:))) {
        row.height = [row.cell AKHeightOfContent:row.objToDraw];
        if(row.height) {
            return row.height;
        }
    }
    
    UITableViewCell<AKTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:row.identifier];
    if(cell) {
        if([cell respondsToSelector:@selector(AKDrawContent:)]) {
            [cell AKDrawContent:row.objToDraw];
        }
        
        [cell layoutIfNeeded];
        CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        if(height) {
            if(self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine) {
                height += 1.f;
            }
            
            //有高度的情况下判断是否比最小高度大，否则取最小高度
            if(class_getClassMethod(row.cell, @selector(AKMinimumHeight))) {
                CGFloat minHeight = [row.cell AKMinimumHeight];
                if(minHeight) {
                    if(self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine) {
                        minHeight += 1.f;
                    }
                    
                    if(minHeight > height) {
                        height = minHeight;
                    }
                }
            }
            row.height = height;
            return row.height;
        }
    }
    
    return 0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<AKTableViewSectionViewProtocol> view = self.sections[section].header;
    if(!view) {
        return tableView.style == UITableViewStylePlain ? 0.f : CGFLOAT_MIN;
    }
    
    if(view.height != AKTableViewComponentHeightAuto) {
        return view.height;
    }
    
    if(class_getClassMethod(view.view, @selector(AKSizeOfContent:))) {
        view.height = [view.view  AKSizeOfContent:view.objToDraw].height;
        if(view.height) {
            return view.height;
        }
    }
    
    if(class_getClassMethod(view.view, @selector(AKMinimumSize))) {
        view.height = [view.view AKMinimumSize].height;
        if(view.height) {
            return view.height;
        }
    }
    
    return tableView.style == UITableViewStylePlain ? 0.f : CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<AKTableViewSectionViewProtocol> view = self.sections[section].footer;
    if(!view) {
        return tableView.style == UITableViewStylePlain ? 0.f : CGFLOAT_MIN;
    }
    
    if(view.height != AKTableViewComponentHeightAuto) {
        return view.height;
    }
    
    if(class_getClassMethod(view.view, @selector(AKSizeOfContent:))) {
        view.height = [view.view AKSizeOfContent:view.objToDraw].height;
        if(view.height) {
            return view.height;
        }
    }
    
    if(class_getClassMethod(view.view, @selector(AKMinimumSize))) {
        view.height = [view.view AKMinimumSize].height;
        if(view.height) {
            return view.height;
        }
    }
    
    return tableView.style == UITableViewStylePlain ? 0.f : CGFLOAT_MIN;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.estimatedHeightForRow) {
        return 0.f;
    }
    return self.estimatedHeightForRow(tableView, indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if(!self.estimatedHeightForHeader) {
        return 0.f;
    }
    return self.estimatedHeightForHeader(tableView, section);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if(!self.estimatedHeightForFooter) {
        return 0.f;
    }
    return self.estimatedHeightForFooter(tableView, section);
}

// Section header & footer information. Views are preferred over title should you decide to provide both

// custom view for header. will be adjusted to default or specified header height
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<AKTableViewSectionProtocol> _section = self.sections[section];
    if(!_section.header.view) {
        return nil;
    }
    
    id<AKViewProtocol> view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:_section.header.identifier];
    if(!view) {
        view = [[_section.header.view alloc] initWithReuseIdentifier:_section.header.identifier];
    }
    
    if([view respondsToSelector:@selector(AKDrawView:)]) {
        [view AKDrawContent:_section.header.objToDraw];
    }
    return view;
}
// custom view for footer. will be adjusted to default or specified footer height
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<AKTableViewSectionProtocol> _section = self.sections[section];
    if(!_section.footer.view) {
        return nil;
    }
    
    id<AKViewProtocol> view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:_section.footer.identifier];
    if(!view) {
        view = [[_section.footer.view alloc] initWithReuseIdentifier:_section.header.identifier];
    }
    
    if([view respondsToSelector:@selector(AKDrawView:)]) {
        [view AKDrawContent:_section.footer.objToDraw];
    }
    return view;
}

// Accessories (disclosures). 

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    !self.accessoryButtonTappedForRow ? : self.accessoryButtonTappedForRow(tableView, indexPath);
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row. 
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.shouldHighlightRow) {
        return YES;
    }
    return self.shouldHighlightRow(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didHighlightRow ? : self.didHighlightRow(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didUnhighlightRow ? : self.didUnhighlightRow(tableView, indexPath);
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.willSelectRow) {
        return indexPath;
    }
    return self.willSelectRow(tableView, indexPath);
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.willDeselectRow) {
        return indexPath;
    }
    return self.willDeselectRow(tableView, indexPath);
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didSelectRow ? : self.didSelectRow(tableView, indexPath);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didDeselectRow ? : self.didDeselectRow(tableView, indexPath);
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.editingStyleForRow) {
        return UITableViewCellEditingStyleNone;
    }
    return self.editingStyleForRow(tableView, indexPath);
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.titleForDeleteConfirmationButtonForRow) {
        return @"删除";
    }
    return self.titleForDeleteConfirmationButtonForRow(tableView, indexPath);
}

// supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.editActionsForRow) {
        return nil;
    }
    return self.editActionsForRow(tableView, indexPath);
}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.shouldIndentWhileEditingRow) {
        return YES;
    }
    return self.shouldIndentWhileEditingRow(tableView, indexPath);
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.willBeginEditingRow ? : self.willBeginEditingRow(tableView, indexPath);
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didEndEditingRow ? : self.didEndEditingRow(tableView, indexPath);
}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if(!self.moveRow) {
        return nil;
    }
    return self.moveRow(tableView, sourceIndexPath, proposedDestinationIndexPath);
}

// Indentation

// return 'depth' of row for hierarchies
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.indentationLevelForRow) {
        return 0;
    }
    return self.indentationLevelForRow(tableView, indexPath);
}

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.shouldShowMenuForRow) {
        return NO;
    }
    return self.shouldShowMenuForRow(tableView, indexPath);
}
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    if(!self.canPerformActionForRow) {
        return NO;
    }
    return self.canPerformActionForRow(tableView, action, indexPath, sender);
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender {
    !self.performActionForRow ? : self.performActionForRow(tableView, action, indexPath, sender);
}

// Focus

- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.canFocusRow) {
        return NO;
    }
    return self.canFocusRow(tableView, indexPath);
}
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context {
    if(!self.shouldUpdateFocus) {
        return NO;
    }
    return self.shouldUpdateFocus(tableView, context);
}
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    !self.didUpdateFocus ? : self.didUpdateFocus(tableView, context, coordinator);
}
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView {
    if(!self.indexPathForPreferredFocusedView) {
        return nil;
    }
    return self.indexPathForPreferredFocusedView(tableView);
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.didScroll ? : self.didScroll(scrollView);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    !self.willBeginDragging ? : self.willBeginDragging(scrollView);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    !self.willEndDragging ? : self.willEndDragging(scrollView, velocity, targetContentOffset);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    !self.didEndDragging ? : self.didEndDragging(scrollView, decelerate);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    !self.willBeginDecelerating ? : self.willBeginDecelerating(scrollView);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    !self.didEndDecelerating ? : self.didEndDecelerating(scrollView);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    !self.didEndScrollingAnimation ? : self.didEndScrollingAnimation(scrollView);
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if(!self.shouldScrollToTop) {
        return YES;
    }
    return self.shouldScrollToTop(scrollView);
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    !self.didScrollToTop ? : self.didScrollToTop(scrollView);
}

@end
