//
//  NewsBTableViewCell.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/11/23.
//  Copyright © 2015年 zhuang chaoxiao. All rights reserved.
//

#import "NewsBTableViewCell.h"

@interface NewsBTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation NewsBTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
