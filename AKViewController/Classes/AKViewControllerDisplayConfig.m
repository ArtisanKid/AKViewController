//
//  AKViewControllerDisplayConfig.m
//  Pods
//
//  Created by 李翔宇 on 2017/1/26.
//
//

#import "AKViewControllerDisplayConfig.h"

static CGFloat AKViewController_Bounds_Gap = 0.f;
void AKViewControllerSetBoundsGap(CGFloat gap) {
    AKViewController_Bounds_Gap = gap;
}
CGFloat AKViewControllerBoundsGap() {
    return AKViewController_Bounds_Gap;
}

CGFloat AKViewController_Inner_Gap = 0.f;
void AKViewControllerSetInnerGap(CGFloat gap) {
    AKViewController_Inner_Gap = gap;
}
CGFloat AKViewControllerInnerGap() {
    return AKViewController_Inner_Gap;
}

CGFloat AKViewController_Base_Cell_Height = 44.f;
void AKViewControllerSetBaseCellHeight(CGFloat height) {
    AKViewController_Base_Cell_Height = height;
}
CGFloat AKViewControllerBaseCellHeight() {
    return AKViewController_Base_Cell_Height;
}
