//
//  FocusTableViewCell.h
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface FocusTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playImageView;

@property (nonatomic, copy)NSString *url;

- (void)setValuesForKeysWithModel:(Model *)model;

@end
