//
//  Model.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "Model.h"

@implementation Model


- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
        self.username = dic[@"username"];
        self.title = dic[@"title"];
        self.url = dic[@"url"];
        self.img = dic[@"img"];
        self.duration = dic[@"duration"];
        self.num = dic[@"num"];
        self.ids = dic[@"id"];
    }
    
    return self;
    
}

@end
