//
//  SpeedResultViewController.m
//  NewiPhoneADV
//
//  Created by zhuang chaoxiao on 15/8/15.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "SpeedResultViewController.h"
#import "commData.h"
#import <UMShare/UMShare.h>

@interface SpeedResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgBgView;
- (IBAction)backClicked;
- (IBAction)shareClicked;

@end

@implementation SpeedResultViewController


-(NSString*)tranSpeed
{
    CGFloat per = _speed/(1048576/2);//全国平均 512K
    
    per = (per>0.99? 0.99:per);
    
    return [NSString stringWithFormat:@"%0.0f%%",per*100];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString * strSpeed = nil;
    
    if( _speed/1048576>=1.0)
    {
        strSpeed = [NSString stringWithFormat:@"%.2fM/s",_speed/1048576];
    }
    else if( _speed/1024>=1.0)
    {
        strSpeed = [NSString stringWithFormat:@"%.2fK/s",_speed/1024];
    }
    else
    {
        strSpeed = [NSString stringWithFormat:@"%dB/s",(int)_speed];
    }
   
    
    UILabel * speedLab1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 160, 120, 25)];
    speedLab1.text = strSpeed;
    speedLab1.textAlignment = NSTextAlignmentCenter;
    speedLab1.font = [UIFont systemFontOfSize:26];
    [_imgBgView addSubview:speedLab1];
    
    
    UILabel * speedLab3 = [[UILabel alloc]initWithFrame:CGRectMake(170, 340, 100, 25)];
    speedLab3.text = [self tranSpeed];
    speedLab3.font = [UIFont systemFontOfSize:20];
    [_imgBgView addSubview:speedLab3];

//
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareClicked
{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"苹果手机助手" descr:SHARE_TEXT thumImage:SHARE_IMAGE];
    //设置网页地址
    shareObject.webpageUrl = kAppStoreAddress;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                NSLog(@"response data is %@",data);
            }
        }
    }];
}
@end
