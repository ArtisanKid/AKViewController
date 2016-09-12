//
//  AKViewControllerMacro.h
//  Pods
//
//  Created by 李翔宇 on 16/8/22.
//
//

#ifndef AKViewControllerMacro_h
#define AKViewControllerMacro_h

static BOOL AKViewControllerLogState = YES;

#define AKViewControllerLogFormat(INFO, ...) [NSString stringWithFormat:(@"\n[Date:%s]\n[Time:%s]\n[File:%s]\n[Line:%d]\n[Function:%s]\n" INFO @"\n"), __DATE__, __TIME__, __FILE__, __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__] 

#if DEBUG
#define AKViewControllerLog(INFO, ...) !AKViewControllerLogState ? : NSLog((@"\n[Date:%s]\n[Time:%s]\n[File:%s]\n[Line:%d]\n[Function:%s]\n" INFO @"\n"), __DATE__, __TIME__, __FILE__, __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__);
#else
#define AKViewControllerLog(INFO, ...)
#endif

#endif /* AKViewControllerMacro_h */
