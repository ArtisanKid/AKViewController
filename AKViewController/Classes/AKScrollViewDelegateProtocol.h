//
//  AKScrollViewDelegateProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/3/3.
//
//

#import <Foundation/Foundation.h>

@protocol AKScrollViewDelegateProtocol <NSObject>

// - (void)scrollViewDidScroll:(UIScrollView *)scrollView
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
