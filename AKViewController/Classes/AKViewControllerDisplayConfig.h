//
//  AKViewControllerDisplayConfig.h
//  Pods
//
//  Created by 李翔宇 on 2017/1/26.
//
//

#import <Foundation/Foundation.h>

//设置ScrollViewController的通用外边界间隔
extern void AKViewControllerSetBoundsGap(CGFloat gap);
extern CGFloat AKViewControllerBoundsGap();

//设置ScrollViewController的通用内边界间隔
extern void AKViewControllerSetInnerGap(CGFloat gap);
extern CGFloat AKViewControllerInnerGap();

//设置ScrollViewController的Cell通用高度
extern void AKViewControllerSetBaseCellHeight(CGFloat height);
extern CGFloat AKViewControllerBaseCellHeight();
