//
//  DataHandle.h
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandle : NSObject
@property (nonatomic, strong)NSMutableArray *cellArray;

+ (instancetype)defaultHandle;
@end
