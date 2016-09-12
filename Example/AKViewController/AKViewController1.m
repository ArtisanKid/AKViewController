//
//  AKViewController.m
//  AKViewController
//
//  Created by Freud on 09/11/2016.
//  Copyright (c) 2016 Freud. All rights reserved.
//

#import "AKViewController1.h"

@interface AKViewController1 ()

@end

@implementation AKViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [AKLoadStateView setBackgroundColor:[UIColor blueColor] state:AKLoadStateNetworkError];
    [AKLoadStateView setImage:@"state_no_wifi" state:AKLoadStateNetworkError];
    [AKLoadStateView setTitle:@"网络错误" state:AKLoadStateNetworkError];
    [AKLoadStateView setTitleColor:[UIColor grayColor] state:AKLoadStateNetworkError];
    [AKLoadStateView setTitleFont:[UIFont systemFontOfSize:18.f]];
    
    [AKLoadStateView setDetail:@"网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误网络错误" state:AKLoadStateNetworkError];
    [AKLoadStateView setDetailColor:[UIColor grayColor] state:AKLoadStateNetworkError];
    [AKLoadStateView setDetailFont:[UIFont systemFontOfSize:14.f]];
    
    [AKLoadStateView setRefreshButtonColor:[UIColor greenColor] state:AKLoadStateNetworkError];
    [AKLoadStateView setRefreshButtonTitle:@"重新加载123" state:AKLoadStateNetworkError];
    [AKLoadStateView setRefreshButtonTitleColor:[UIColor whiteColor] state:AKLoadStateNetworkError];
    [AKLoadStateView setRefreshButtonFont:[UIFont systemFontOfSize:14.f]];
    
    self.ak_startProgressHUD = YES;
    self.ak_startLoadStateView = YES;
    
    [self.ak_progressHUD showAnimated:YES];
    [self.ak_progressHUD hideAnimated:YES afterDelay:5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.ak_loadStateView.state = AKLoadStateNetworkError;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AKLoadData {
    [self.ak_progressHUD showAnimated:YES];
    [self.ak_progressHUD hideAnimated:YES afterDelay:5];
}

@end
