//
//  AKTableViewAdapter.h
//  Pods
//
//  Created by 李翔宇 on 16/1/4.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewRow.h"
#import "AKTableViewSection.h"
#import "AKTableViewAdapterProtocol.h"
#import "AKScrollViewDelegateProtocol.h"
#import "AKTableViewDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKTableViewAdapter : NSObject<AKTableViewAdapterProtocol, AKScrollViewDelegateProtocol, AKTableViewDelegateProtocol>

#pragma mark- AKTableViewAdapterProtocol

@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger offsetStart;
@property (nonatomic, assign) NSUInteger offset;

@property (nullable, nonatomic, weak) UITableView<AKScrollViewDataProtocol> *scrollView;
@property (nonatomic, assign, getter=isAutoReloadData) BOOL autoReloadData;
@property (nonatomic, strong, nullable) NSArray<id/*不同子类指定不同类型*/> *datas;

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

#pragma mark- AKTableViewDelegateProtocol

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) void(^willDisplayCell)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^willDisplayHeaderView)(UITableView *tableView, UIView *view, NSInteger section);

//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^willDisplayFooterView)(UITableView *tableView, UIView *view, NSInteger section);

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^didEndDisplayingCell)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);

//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^didEndDisplayingHeaderView)(UITableView *tableView, UIView *view, NSInteger section);

//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^didEndDisplayingFooterView)(UITableView *tableView, UIView *view, NSInteger section);



//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) CGFloat(^heightForRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
@property (nonatomic, strong) CGFloat(^heightForHeader)(UITableView *tableView, NSInteger section);

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
@property (nonatomic, strong) CGFloat(^heightForFooter)(UITableView *tableView, NSInteger section);



//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
@property (nonatomic, strong) CGFloat(^estimatedHeightForRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
@property (nonatomic, strong) CGFloat(^estimatedHeightForHeader)(UITableView *tableView, NSInteger section);

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
@property (nonatomic, strong) CGFloat(^estimatedHeightForFooter)(UITableView *tableView, NSInteger section);



//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
@property (nonatomic, strong) UIView *(^viewForHeader)(UITableView *tableView, NSInteger section);

//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
@property (nonatomic, strong) UIView *(^viewForFooter)(UITableView *tableView, NSInteger section);



//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) void (^accessoryButtonTappedForRow)(UITableView *tableView, NSIndexPath *indexPath);



//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) BOOL(^shouldHighlightRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^didHighlightRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong) void(^didUnhighlightRow)(UITableView *tableView, NSIndexPath *indexPath);



//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
@property (nonatomic, strong) NSIndexPath *(^willSelectRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
@property (nonatomic, strong) NSIndexPath *(^willDeselectRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
@property (nonatomic, strong) void(^didSelectRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
@property (nonatomic, strong) void(^didDeselectRow)(UITableView *tableView, NSIndexPath *indexPath);



//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) UITableViewCellEditingStyle(^editingStyleForRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSString *(^titleForDeleteConfirmationButtonForRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0);
@property (nonatomic, strong) NSArray<UITableViewRowAction *> *(^editActionsForRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) BOOL(^shouldIndentWhileEditingRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) void(^willBeginEditingRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) void(^didEndEditingRow)(UITableView *tableView, NSIndexPath *indexPath);



//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
@property (nonatomic, strong) NSIndexPath *(^moveRow)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);



//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
@property (nonatomic, strong) NSInteger(^indentationLevelForRow)(UITableView *tableView, NSIndexPath *indexPath);



//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
@property (nonatomic, strong) BOOL(^shouldShowMenuForRow)(UITableView *tableView, NSIndexPath *indexPath);

//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
@property (nonatomic, strong) BOOL(^canPerformActionForRow)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);

//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
@property (nonatomic, strong) void(^performActionForRow)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);



//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) BOOL(^canFocusRow)(UITableView *tableView, NSIndexPath *indexPath) NS_AVAILABLE_IOS(9_0);

//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) BOOL(^shouldUpdateFocus)(UITableView *tableView, UITableViewFocusUpdateContext *context) NS_AVAILABLE_IOS(9_0);

//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) void(^didUpdateFocus)(UITableView *tableView, UITableViewFocusUpdateContext *context, UIFocusAnimationCoordinator *coordinator) NS_AVAILABLE_IOS(9_0);

//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong) NSIndexPath *(^indexPathForPreferredFocusedView)(UITableView *tableView) NS_AVAILABLE_IOS(9_0);

#pragma mark- AKScrollViewDelegateProtocol

// - (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@property (nonatomic, strong) void(^didScroll)(UIScrollView *scrollView);

// - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
@property (nonatomic, strong) void(^willBeginDragging)(UIScrollView *scrollView);

// - (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
@property (nonatomic, strong) void(^willEndDragging)(UIScrollView *scrollView, CGPoint velocity, CGPoint *targetContentOffset);

// - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@property (nonatomic, strong) void(^didEndDragging)(UIScrollView *scrollView, BOOL decelerate);

// - (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
@property (nonatomic, strong) void(^willBeginDecelerating)(UIScrollView *scrollView);

// - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@property (nonatomic, strong) void(^didEndDecelerating)(UIScrollView *scrollView);

// - (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
@property (nonatomic, strong) void(^didEndScrollingAnimation)(UIScrollView *scrollView);

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;
@property (nonatomic, strong) BOOL(^shouldScrollToTop)(UIScrollView *scrollView);

//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;
@property (nonatomic, strong) void(^didScrollToTop)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
