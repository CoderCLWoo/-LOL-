//
//  HeroModel.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.img = dic[@"img"];
        self.ids = dic[@"id"];
        self.cats = dic[@"cats"];
        
//        NSString *str = @"";
//        for (NSString *string in self.cats) {
//            
//            if (string != self.cats.lastObject) {
//               str = [str stringByAppendingString:[NSString stringWithFormat:@"%@,", string]];
//            } else {
//                str = [str stringByAppendingString:string];
//            }
//        }
//        
//        self.heroCats = str;
        
        self.heroCats = [self.cats componentsJoinedByString:@","];
        
    }
    return self;
}

@end
