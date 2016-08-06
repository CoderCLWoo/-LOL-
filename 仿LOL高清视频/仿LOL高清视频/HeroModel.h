//
//  HeroModel.h
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject
/**  title  */
@property (nonatomic, copy) NSString *title;
/**  img  */
@property (nonatomic, copy) NSString *img;
/**  id  */
@property (nonatomic, copy) NSString *ids;
/**  cats  */
@property (nonatomic, strong) NSArray *cats;
/**  heroCats  */
@property (nonatomic, copy) NSString *heroCats;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
