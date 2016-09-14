//
//  AKTableViewSectionView.h
//  Pods
//
//  Created by 李翔宇 on 16/3/25.
//
//

#import <Foundation/Foundation.h>
#import "AKTableViewSectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

extern CGFloat AKTableViewComponentHeightAuto;

@interface AKTableViewSectionView : NSObject<AKTableViewSectionViewProtocol>

@property (nonatomic, assign) CGFloat height;

@property (nullable, nonatomic, strong) NSString *title;
@property (nonatomic, strong) Class<AKViewProtocol> view;

@property (nullable, nonatomic, strong) id objToDraw;

@property (nonatomic, strong) NSString *identifier;

+ (id<AKTableViewSectionViewProtocol>)sectionViewWithView:(Class<AKViewProtocol>)cls obj:(id _Nullable)obj;

@end

NS_ASSUME_NONNULL_END
