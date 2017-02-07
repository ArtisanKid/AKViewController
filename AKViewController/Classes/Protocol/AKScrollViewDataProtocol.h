//
//  AKScrollViewDataProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/8/26.
//
//

#import <Foundation/Foundation.h>

/**
 *  UITableView，UICollectionView都实现了reloadData方法
 */

@protocol AKScrollViewDataProtocol <NSObject>

@required
- (void)reloadData;

@end
