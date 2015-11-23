//
//  NewsATableViewCell.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/11/23.
//  Copyright © 2015年 zhuang chaoxiao. All rights reserved.
//

#import "NewsATableViewCell.h"
#import "CommData.h"
#import "UIImageView+WebCache.h"

@interface NewsATableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation NewsATableViewCell

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
    
    
    
    //[_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",NEWS_BASE_URL,info.imgArray[0]]] placeholderImage:nil];
}

@end
