//
//  DataHandle.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "DataHandle.h"

@implementation DataHandle

- (NSMutableArray *)cellArray {
    if (_cellArray == nil) {
        _cellArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _cellArray;
}

+ (instancetype)defaultHandle {
    
    static DataHandle *dataHandle = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataHandle = [[DataHandle alloc] init];
        
    });
    
    return dataHandle;
}

@end
