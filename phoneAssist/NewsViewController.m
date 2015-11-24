//
//  NewsViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/11/23.
//  Copyright © 2015年 zhuang chaoxiao. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsATableViewCell.h"
#import "NewsBTableViewCell.h"
#import "NewsCTableViewCell.h"
#import "JSONKit.h"
#import "CommInfo.h"
#import "NewsDetailViewController.h"
#import "SVProgressHUD.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData * bookData;
    NSURLRequest * request;
    NSURLConnection * conn;
    
}
@property(strong,nonatomic) NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 50;
    
    //
    [self startDownLoad:NEWS_LIST_URL];
    //
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    self.title = @"苹果使用技巧";
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    NewsInfo * info = self.dataArray[indexPath.row];
    if( [info.type isEqualToString:@"A"])
    {
        static NSString * cellID = @"NewsATableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if( !cell )
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil]lastObject];
        }
        
        [((NewsATableViewCell*)cell) refreshCell:(NewsInfo*)info];
    }
    else if( [info.type isEqualToString:@"B"])
    {
        static NSString * cellID = @"NewsBTableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if( !cell )
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil]lastObject];
        }
        
        [((NewsBTableViewCell*)cell) refreshCell:(NewsInfo*)info];
    }
    else if( [info.type isEqualToString:@"C"])
    {
        static NSString * cellID = @"NewsCTableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if( !cell )
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil]lastObject];
        }
        
        [((NewsCTableViewCell*)cell) refreshCell:(NewsInfo*)info];
    }
    else
    {
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsInfo * info  = (self.dataArray[indexPath.row]);
    
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
    vc.info = info;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma System
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma DownLoad
-(void)startDownLoad:(NSString*)strUrl
{
    bookData = [NSMutableData new];
    //
    request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
    [SVProgressHUD showInfoWithStatus:@"信息拉取中..."];
}

#pragma
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    
    [bookData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError:%@-%@",error,error.description);
    
    [SVProgressHUD showErrorWithStatus:@"信息拉取失败，请稍后再试！"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [SVProgressHUD dismiss];
    
    NSString * str = [[NSString alloc]initWithData:bookData encoding:NSUTF8StringEncoding];
    NSDictionary * dict = [str objectFromJSONString];
    
    NSArray * array = dict[@"array"];
    if( array )
    {
        for( NSDictionary * d in array )
        {
            if( !d )return;
        
            NewsInfo * info = [NewsInfo new];
            [info fromDict:d];
            
            [self.dataArray addObject:info];
        }
    }
    
    [_tableView reloadData];
}


#pragma InitData
-(NSMutableArray*)dataArray
{
    if( !_dataArray )
    {
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

@end
