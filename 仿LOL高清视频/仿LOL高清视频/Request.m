//
//  Request.m
//  仿糗事百科之纯文
//
//  Created by WuChunlong on 16/6/3.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "Request.h"


@implementation Request

- (void)getDataFromUrlString:(NSString *)urlString {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.firstObject.rootViewController.view animated:YES];
    HUD.label.text = @"努力加载中...";
    
    // 创建HTTP请求管理类
    AFHTTPSessionManager *mananger = [AFHTTPSessionManager manager];
    
    // 设置请求的数据的返回格式
    mananger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [mananger GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HUD hideAnimated:YES];
        [self.delegate passValue:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HUD hideAnimated:YES];
        NSLog(@"~~~~~~~%@", error);
    }];

}


@end
