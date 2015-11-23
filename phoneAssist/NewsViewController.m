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
}


#pragma UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellAID = @"NewsATableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellAID];
    
    if( !cell )
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellAID owner:self options:nil]lastObject];
    }
    
    
    NewsInfo * info = self.dataArray[indexPath.row];
    if( [info.type isEqualToString:@"A"])
    {
        [((NewsATableViewCell*)cell) refreshCell:(NewsInfo*)info];
    }
    else if( [info.type isEqualToString:@"B"])
    {
        [((NewsATableViewCell*)cell) refreshCell:(NewsInfo*)info];
    }
    else if( [info.type isEqualToString:@"C"])
    {
        [((NewsATableViewCell*)cell) refreshCell:(NewsInfo*)info];
    }
    else
    {
        
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSString * s = ((NewsBaseInfo*)(self.dataArray[indexPath.row])).type;
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
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
