//
//  AKTableViewSectionView.m
//  Pods
//
//  Created by 李翔宇 on 16/3/25.
//
//

#import "AKTableViewSectionView.h"

@implementation AKTableViewSectionView

- (instancetype)init {
    self = [super init];
    if(self) {
        self.height = AKTableViewComponentHeightAuto;
    }
    return self;
}

- (NSString *)identifier {
    if(!_identifier.length) {
        _identifier = NSStringFromClass(self.view);
    }
    return _identifier;
}

+ (id<AKTableViewSectionViewProtocol>)sectionViewWithView:(Class<AKViewProtocol>)cls obj:(id _Nullable)obj {
    AKTableViewSectionView *sectionView = [[AKTableViewSectionView alloc] init];
    sectionView.objToDraw = obj;
    sectionView.view = cls;
    return sectionView;
}

@end
