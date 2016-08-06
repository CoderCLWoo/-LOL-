//
//  Request.h
//  仿糗事百科之纯文
//
//  Created by WuChunlong on 16/6/3.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestDelegate <NSObject>

- (void)passValue:(id)responseObject;

@end


@interface Request : NSObject

@property (nonatomic, weak) id <RequestDelegate> delegate;

/** GET 请求数据  */
- (void)getDataFromUrlString:(NSString *)urlString;

/** POST 请求数据  */
//- (void)postDataFromUrlString:(NSString *)urlString;

@end
