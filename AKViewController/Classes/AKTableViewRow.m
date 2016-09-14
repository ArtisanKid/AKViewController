//
//  AKTableViewRow.m
//  Pods
//
//  Created by 李翔宇 on 16/1/5.
//
//

#import "AKTableViewRow.h"

@implementation AKTableViewRow

- (instancetype)init {
    self = [super init];
    if(self) {
        self.height = AKTableViewComponentHeightAuto;
    }
    return self;
}

- (NSString *)identifier {
    if(!_identifier.length) {
        _identifier = NSStringFromClass(self.cell);
    }
    return _identifier;
}

+ (id<AKTableViewRowProtocol>)rowWithCell:(Class<AKTableViewCellProtocol>)cls obj:(id _Nullable)obj {
    AKTableViewRow *row = AKTableViewRow.new;
    row.objToDraw = obj;
    row.cell = cls;
    return row;
}

@end
