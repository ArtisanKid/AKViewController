//
//  AKTableViewControllerAdapterProtocol.h
//  Pods
//
//  Created by 李翔宇 on 16/4/1.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewAdapterProtocol.h"
#import "AKTableViewDelegateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AKTVCAdapterProtocol <NSObject>

@property (nonatomic, strong) id<AKTableViewAdapterProtocol, AKTableViewDelegateProtocol> adapter;

@end

NS_ASSUME_NONNULL_END
