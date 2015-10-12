//
//  APPsViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/11.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "APPsViewController.h"

@interface APPsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *view_1;
@property (weak, nonatomic) IBOutlet UILabel *view_2;
@property (weak, nonatomic) IBOutlet UILabel *view_3;
@property (weak, nonatomic) IBOutlet UILabel *view_4;
@property (weak, nonatomic) IBOutlet UILabel *view_5;
@property (weak, nonatomic) IBOutlet UILabel *view_6;

@end

@implementation APPsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    self.title = @"应用推荐";
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * t = [touches anyObject];
    
    CGPoint pt;
    
    pt = [t locationInView:_view_1];
    
    if( CGRectContainsPoint(_view_1.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/bi-qi-nao-zhong-bu-qi-chuang/id1009624896?l=zh&ls=1&mt=8"]];
        
        return;
    }
    
    //
    pt = [t locationInView:_view_2];
    
    if( CGRectContainsPoint(_view_2.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/tian-tian-zhuan-qian-hu-lian/id1044171073?l=zh&ls=1&mt=8"]];
        
        return;
    }

    pt = [t locationInView:_view_3];
    
    if( CGRectContainsPoint(_view_3.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/mi-ma-xiang-ce-wei-zhuang/id1038043569?l=zh&ls=1&mt=8"]];
        
        return;
    }
    
    pt = [t locationInView:_view_4];
    
    if( CGRectContainsPoint(_view_4.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/21tian-jian-fei-bu-fan-dan/id1024533470?l=zh&ls=1&mt=8"]];
        
        return;
    }
    
    pt = [t locationInView:_view_4];
    
    if( CGRectContainsPoint(_view_4.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/shuai-ge-mei-nu-pin-tu/id953090519?l=zh&ls=1&mt=8"]];
        
        return;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
