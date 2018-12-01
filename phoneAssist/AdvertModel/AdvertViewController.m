//
//  AdvertViewController.m
//  test
//
//  Created by 停有钱 on 16/11/15.
//  Copyright © 2016年 rock. All rights reserved.
//

/*
 设计方案：
 1.设置openAdv标志，打开之后才会显示里面的内容
 2.传APPID到后台，后台根据APPID来判断是否打开
 3.
 */

#import "AdvertViewController.h"
#import "AdvertTableViewCell.h"
#import "NetWorkUikits.h"
#import "AdvertModel.h"
#import "AppDelegate.h"
#import <UMShare/UMShare.h>
#import "CommData.h"

/////////////////////////////////////////////////////////////////////////////////

@interface AdvertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * array;

@end

@implementation AdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 60;
    [self.tableView setTableFooterView:[UIView new]];
    
    
    NSString * showApps = @"undefined";
    for( AdvertModel * m in [AdvertModel getAdvert] )
    {
        if( [m.appid isEqualToString:[[NSBundle mainBundle] bundleIdentifier]] )
        {
            showApps = m.showApps;
        }
    }
    
    for( AdvertModel * m in [AdvertModel getAdvert] )
    {
        NSLog(@"showApps:%@",m.showApps);
        
        if( ([showApps rangeOfString:m.appid].length > 0))
        {
            [self.array addObject:m];
        }
    }
    
    UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Clicked)];
    [[self.view viewWithTag:100] addGestureRecognizer:g];
    
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view2Clicked)];
    [[self.view viewWithTag:101] addGestureRecognizer:g];
    
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view3Clicked)];
    [[self.view viewWithTag:102] addGestureRecognizer:g];
}


-(void)view1Clicked
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1048451512"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)view2Clicked
{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1048451512"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)view3Clicked
{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"苹果手机助手" descr:@"苹果手机必备的一款APP，很多名人都在使用！" thumImage:[UIImage imageNamed:@"ShareIcon"]];
    //设置网页地址
    shareObject.webpageUrl = @"https://itunes.apple.com/us/app/%E6%89%8B%E6%9C%BA%E4%B8%93%E5%AE%B6-%E5%85%8D%E8%B4%B9%E7%9A%84%E6%9C%80%E5%A5%BD%E7%9A%84%E6%89%8B%E6%9C%BA%E4%BF%A1%E6%81%AF%E4%B8%93%E5%AE%B6%E8%BD%AF%E4%BB%B6app/id1048451512?l=zh&ls=1&mt=8";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
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


-(void)hideView1
{
    UIView * view = [self.view viewWithTag:100];
    
    view.hidden = YES;
    
    [view.superview.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop)
     {
         if ((constraint.firstItem == view )&&(constraint.firstAttribute == NSLayoutAttributeTop))
         {
             constraint.constant = 0;
         }
     }];
    
    [view.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop)
     {
         if ((constraint.firstItem == view )&&(constraint.firstAttribute == NSLayoutAttributeHeight))
         {
             constraint.constant = 0;
         }
     }];
}


-(void)hideView2
{
    UIView * view = [self.view viewWithTag:101];
    
    view.hidden = YES;
    
    [view.superview.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop)
     {
         if ((constraint.firstItem == view )&&(constraint.firstAttribute == NSLayoutAttributeTop))
         {
             constraint.constant = 0;
         }
     }];
    
    [view.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop)
     {
         if ((constraint.firstItem == view )&&(constraint.firstAttribute == NSLayoutAttributeHeight))
         {
             constraint.constant = 0;
         }
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"AdvertTableViewCell";
    
    AdvertTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil] lastObject];
    }
    
    [cell refresCell:self.array[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((AdvertModel*)self.array[indexPath.row]).url] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

#pragma setter & getter
-(NSMutableArray*)array
{
    if( !_array )
    {
        _array = [NSMutableArray new];
    }
    
    return _array;
}

@end
