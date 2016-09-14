//
//  AKSVCDisplayConfig.m
//  Pods
//
//  Created by 李翔宇 on 16/9/12.
//
//

#import "AKSVCDisplayConfig.h"

CGFloat AKSVC_BoundsGap = 0.f;
CGFloat AKSVCSetBoundsGap(CGFloat gap) {
    AKSVC_BoundsGap = gap;
}
CGFloat AKSVCBoundsGap() {
    return AKSVC_BoundsGap;
}

CGFloat AKSVC_InnerGap = 0.f;
CGFloat AKSVCSetInnerGap(CGFloat gap) {
    AKSVC_InnerGap = gap;
}
CGFloat AKSVCInnerGap() {
    return AKSVC_InnerGap;
}

CGFloat AKSVC_BaseCellHeight = 0.f;
CGFloat AKSVCSetBaseCellHeight(CGFloat height) {
    AKSVC_BaseCellHeight = height;
}
CGFloat AKSVCBaseCellHeight() {
    return AKSVC_BaseCellHeight;
}
