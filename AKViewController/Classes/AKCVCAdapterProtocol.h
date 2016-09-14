//
//  AKCVCAdapterProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/9/14.
//
//

#import <Foundation/Foundation.h>
#import "AKCollectionViewAdapterProtocol.h"
#import "AKCollectionViewDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKCVCAdapterProtocol <NSObject>

@property (nonatomic, strong) id<AKCollectionViewAdapterProtocol, AKCollectionViewDelegateProtocol> adapter;

@end

NS_ASSUME_NONNULL_END
