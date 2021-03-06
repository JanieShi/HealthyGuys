//
//  RecommendViewController.m
//  项目三~healthy guys
//
//  Created by Mac on 15/10/21.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "RecommendViewController.h"
#import "ThemeButton.h"
#import "ConsultCell.h"
#import "ConsultListViewController.h"
#import "ConsultModel.h"
#import "ConsultListModel.h"
#import "Common.h"
#import "ConsultDetailViewController.h"
#import "MJRefresh.h"
@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_consultTableView;
    NSMutableArray *_allDicArray;
    NSArray *_array;
    int _index;
}


@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建表视图
    
    self.title = @"最新推荐";
    [self _createTableView];
    //    NSString *httpUrl = @"http://apis.baidu.com/tngou/info/classify";
    //    NSString *httpArg = @"";
    //    [self request: httpUrl withHttpArg: httpArg];
//    _index = -1;
    _allDicArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 10; i++) {
        NSString *httpUrl = @"http://apis.baidu.com/tngou/info/show";
        NSString *httpArg = [NSString stringWithFormat:@"id=%d",i];
        [self request: httpUrl withHttpArg: httpArg];
    }
//    [self _loadMoreData];

}

#pragma mark - 创建表视图
-(void)_createTableView
{
    UILabel *title = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    title.text = @"最新推荐";
    [self.view addSubview:title];
    
    _consultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70,kScreenWidth , kScreenHeight - 70)];
    _consultTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_consultTableView];
    
    _consultTableView.delegate = self;
    _consultTableView.dataSource = self;
    
    [self _loadMoreData];
    
    _consultTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
}

//上拉刷新
- (void)_loadMoreData{
    
    [_allDicArray removeLastObject];
    
    _index++;
    
    for (int i = (_index - 1)*10 ; i <= _index*10; i++) {
        NSString *httpUrl = @"http://apis.baidu.com/tngou/info/show";
        NSString *httpArg = [NSString stringWithFormat:@"id=%d",i];
        [self request: httpUrl withHttpArg: httpArg];
    }

}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    
    //    2.构造NSURLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //    3.设置请求相关的信息
    //设置请求方式，默认是GET请求
    request.HTTPMethod = @"GET";
    //设置请求超时时间
    request.timeoutInterval = 60;
    
    //设置请求头
    //    request.allHTTPHeaderFields = @{
    //
    //                                   };
    [request addValue: @"6bc2f7f95fcf078e12edb003bc89cb8d" forHTTPHeaderField: @"apikey"];
    
    //    4.构造NSURLConnection，发送请求
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //    5.获取响应头信息
    //    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //获取状态码
    //    NSInteger statusCode = httpResponse.statusCode;
    //    NSLog(@"状态码:%li", statusCode);
    //
    //    //响应头
    //    NSLog(@"响应头:%@", httpResponse.allHeaderFields);
    
    
    
    //    6.获取响应数据信息
    if (data != nil)
    {
        
//        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@",jsonString);
        
        //JSON解析
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [_allDicArray addObject:dic[@"title"]];
        
        [_consultTableView reloadData];
    }
    
    [_consultTableView.footer endRefreshing];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    ConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ConsultCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 280, 60)];
    label.font = [UIFont systemFontOfSize:16];

    label.text = _allDicArray[indexPath.row];
    [cell.contentView addSubview:label];
    label.numberOfLines = 0;
    
    //辅助图标
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsultDetailViewController *consultDetailC=[[ConsultDetailViewController alloc] init];
    
    consultDetailC.indexPathRow = (NSInteger)indexPath.row +1;
    [self presentViewController:consultDetailC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
