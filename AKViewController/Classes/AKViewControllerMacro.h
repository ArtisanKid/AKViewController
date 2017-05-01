//
//  AKViewControllerMacro.h
//  Pods
//
//  Created by 李翔宇 on 16/8/22.
//
//

#ifndef AKViewControllerMacro_h
#define AKViewControllerMacro_h

#if DEBUG
    #define AKViewControllerLog(_Format, ...) NSLog((@"\n[File:%s]\n[Line:%d]\n[Function:%s]\n" _Format), __FILE__, __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__);printf("\n");
#else
    #define AKViewControllerLog(_Format, ...)
#endif

#endif /* AKViewControllerMacro_h */
