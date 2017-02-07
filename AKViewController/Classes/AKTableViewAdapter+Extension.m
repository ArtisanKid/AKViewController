//
//  AKTableViewAdapter+Extension.m
//  Pods
//
//  Created by 李翔宇 on 2017/2/6.
//
//

#import "AKTableViewAdapter+Extension.h"

@implementation AKTableViewAdapter (Extension)

@end

@implementation AKTableViewAdapter (Protocol)

#pragma mark- AKTableViewAdapterProtocol

@dynamic pageSize;
@dynamic offsetStart;
@dynamic offset;

@dynamic scrollView;
@dynamic autoReloadData;
@dynamic datas;

@dynamic sections;

#pragma mark- AKTableViewDelegateProtocol

@dynamic willDisplayCell;
@dynamic willDisplayHeaderView;
@dynamic willDisplayFooterView;
@dynamic didEndDisplayingCell;
@dynamic didEndDisplayingHeaderView;
@dynamic didEndDisplayingFooterView;

@dynamic heightForRow;
@dynamic heightForHeader;
@dynamic heightForFooter;

@dynamic estimatedHeightForRow;
@dynamic estimatedHeightForHeader;
@dynamic estimatedHeightForFooter;

@dynamic viewForHeader;
@dynamic viewForFooter;

@dynamic accessoryButtonTappedForRow;

@dynamic shouldHighlightRow;
@dynamic didHighlightRow;
@dynamic didUnhighlightRow;

@dynamic willSelectRow;
@dynamic willDeselectRow;
@dynamic didSelectRow;
@dynamic didDeselectRow;

@dynamic editingStyleForRow;
@dynamic titleForDeleteConfirmationButtonForRow;
@dynamic editActionsForRow;
@dynamic shouldIndentWhileEditingRow;
@dynamic willBeginEditingRow;
@dynamic didEndEditingRow;

@dynamic moveRow;

@dynamic indentationLevelForRow;

@dynamic shouldShowMenuForRow;
@dynamic canPerformActionForRow;
@dynamic performActionForRow;

@dynamic canFocusRow;
@dynamic shouldUpdateFocus;
@dynamic didUpdateFocus;
@dynamic indexPathForPreferredFocusedView;

#pragma mark- AKScrollViewDelegateProtocol

@dynamic didScroll;
@dynamic willBeginDragging;
@dynamic willEndDragging;
@dynamic didEndDragging;
@dynamic willBeginDecelerating;
@dynamic didEndDecelerating;
@dynamic didEndScrollingAnimation;
@dynamic shouldScrollToTop;
@dynamic didScrollToTop;

@end
