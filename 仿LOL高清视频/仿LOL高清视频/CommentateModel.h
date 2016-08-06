//
//  CommentateModel.h
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentateModel : NSObject
/**  count  */
@property (nonatomic, copy) NSString *count;
/**  img  */
@property (nonatomic, copy) NSString *img;
/**  title  */
@property (nonatomic, copy) NSString *title;
/**  id  */
@property (nonatomic, copy) NSString *ids;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
