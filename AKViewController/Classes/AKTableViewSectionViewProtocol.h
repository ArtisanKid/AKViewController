//
//  AKTableViewSectionViewProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/3/25.
//
//

#import <Foundation/Foundation.h>
#import "AKViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTableViewSectionViewProtocol <NSObject>

@required

/**
 *  指定行高。优先使用指定行高显示view
 *  如果自动计算行高，height需指定为AKTableViewComponentHeightAuto
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  标题
 */
@property (nullable, nonatomic, strong) NSString *title;

/**
 *  自定义View的Class
 *  如果自动计算行高，将调用AKViewProtocol中计算高度的协议方法
 */
- (void)setView:(Class<AKViewProtocol>)view;
- (Class)view;
//@property (nonatomic, strong) Class<AKSVCViewProtocol> view;

/**
 *  用于绘制的object
 *  将调用AKViewProtocol中绘制的协议方法
 */
@property (nullable, nonatomic, strong) id objToDraw;

/**
 *  reuseIdentifier
 *  如果nil，那么使用cellClass作为identifier
 */
@property (nonatomic, strong) NSString *identifier;

+ (id<AKTableViewSectionViewProtocol>)sectionViewWithView:(Class<AKViewProtocol>)cls obj:(id _Nullable)obj;

@end

NS_ASSUME_NONNULL_END
