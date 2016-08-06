//
//  Model.h
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
/**  username  */
@property (nonatomic, copy) NSString *username;
/**  title  */
@property (nonatomic, copy) NSString *title;
/**  url  */
@property (nonatomic, copy) NSString *url;
/**  img  */
@property (nonatomic, copy) NSString *img;
/**  duration  */
@property (nonatomic, copy) NSString *duration;
/**  num  */
@property (nonatomic, copy) NSString *num;
/**  id  */
@property (nonatomic, copy) NSString *ids;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
