//
//  NewsCTableViewCell.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/11/23.
//  Copyright © 2015年 zhuang chaoxiao. All rights reserved.
//

#import "NewsCTableViewCell.h"

@interface NewsCTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;

@end

@implementation NewsCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell:(NewsInfo*)info
{
    _titleLab.text = info.title;
    
    [_imgView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NEWS_BASE_URL,info.imgArray[0]]] placeholderImage:nil];
    [_imgView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NEWS_BASE_URL,info.imgArray[1]]] placeholderImage:nil];
    [_imgView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NEWS_BASE_URL,info.imgArray[2]]] placeholderImage:nil];
}


@end
