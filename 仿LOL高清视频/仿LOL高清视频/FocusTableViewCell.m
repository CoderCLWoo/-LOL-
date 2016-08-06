//
//  FocusTableViewCell.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "FocusTableViewCell.h"
#import "Model.h"
#import "UIImageView+WebCache.h"

@implementation FocusTableViewCell

- (void)setValuesForKeysWithModel:(Model *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    NSString *title = [NSString stringWithFormat:@"【%@】 %@", model.username, model.title];
    self.titleLabel.text = title;
    
    self.durationLabel.text = model.duration;
    self.numLabel.text = model.num;
    self.url = model.url;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
