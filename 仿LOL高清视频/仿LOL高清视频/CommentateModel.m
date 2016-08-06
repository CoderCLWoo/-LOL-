//
//  CommentateModel.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "CommentateModel.h"

@implementation CommentateModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.count = dic[@"count"];
        self.img = dic[@"img"];
        self.title = dic[@"title"];
        self.ids = dic[@"id"];
    }
    
    return self;
}
@end
