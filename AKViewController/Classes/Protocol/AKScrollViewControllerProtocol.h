//
//  AKScrollViewControllerProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/1/11.
//
//

#import <Foundation/Foundation.h>
#import "AKScrollViewDataProtocol.h"
#import "AKScrollViewAdapterProtocol.h"

/**
 *  加载数据结果
 */
typedef NS_ENUM(NSUInteger, AKLoadDataResult) {
    AKLoadDataResultNone = 0,
    
    //加载新数据。包括下拉刷新成功和上拉加载数据
    AKLoadDataResultNewData = 1,
    //加载未返回数据。包括下拉刷新无数据和上拉加载无数据
    AKLoadDataResultNoData,
    //加载数据失败
    AKLoadDataResultFailed
};

NS_ASSUME_NONNULL_BEGIN

typedef AKLoadDataResult (^AKOrganizeBlock)();
typedef void (^AKLoadDataCompleteBlock)(AKOrganizeBlock organize);

@protocol AKScrollViewControllerProtocol <NSObject>

@required

@property (nonatomic, strong, readonly) UIScrollView<AKScrollViewDataProtocol> *scrollView;
@property (nonatomic, strong, readonly) id<AKScrollViewAdapterProtocol> adapter;

@optional

/**
 加载数据
 逻辑是controller将数据处理逻辑包裹在AKOrganizeBlock中，通过AKLoadDataCompleteBlock传回

 @param complete AKLoadDataCompleteBlock
 */
- (void)AKLoadDataWithComplete:(AKLoadDataCompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END
