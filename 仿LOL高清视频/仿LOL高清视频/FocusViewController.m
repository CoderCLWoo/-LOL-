//
//  FocusViewController.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "FocusViewController.h"
#import "Request.h"
#import "Model.h"
#import "FocusTableViewCell.h"
#import "DetailViewController.h"
#import "RecentViewController.h"
#import "DataHandle.h"

static NSString *focusCellIdentifier = @"focusTableViewCell";

@interface FocusViewController ()<RequestDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation FocusViewController

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _modelArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *items = @[@"最近更新", @"热播排行"];
    UISegmentedControl *titleSegment = [[UISegmentedControl alloc] initWithItems:items];
    [titleSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [titleSegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
    titleSegment.tintColor = PINKCOLOR;
    
    titleSegment.selectedSegmentIndex = 0;
    [titleSegment addTarget:self action:@selector(titleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = titleSegment;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton setImage:[UIImage imageNamed:@"recent"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(recentButtonSelect) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    Request *request = [[Request alloc] init];
    request.delegate = self;
    
    [request getDataFromUrlString:FOCUSVIDEOURL];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // tableView 自适应高度
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //下拉刷新
    [tableView addHeaderWithCallback:^{
        
        [request getDataFromUrlString:FOCUSVIDEOURL];
        //给线程添加一个延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];//结束刷新的状态
        });
        
    }];
    
    //上拉加载
    [tableView addFooterWithCallback:^{
        
        [request getDataFromUrlString:FOCUSVIDEOURL];
        //给线程添加一个延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];//结束加载的状态
        });
        
    }];
    
    
    [tableView registerNib:[UINib nibWithNibName:@"FocusTableViewCell" bundle:nil] forCellReuseIdentifier:focusCellIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)titleSegmentedControlValueChanged:(UISegmentedControl *)titleSegment {
    if (titleSegment.selectedSegmentIndex == 0) {
        Request *request = [[Request alloc] init];
        request.delegate = self;
        
        [request getDataFromUrlString:FOCUSVIDEOURL];
    } else {
        Request *request = [[Request alloc] init];
        request.delegate = self;
        
        [request getDataFromUrlString:FOCUSVIDEOURL];
    }
}

- (void)recentButtonSelect {
    
    RecentViewController *recentViewController = [[RecentViewController alloc] init];
    [self.navigationController pushViewController:recentViewController animated:YES];
    
}

#pragma mark - RequestDelegate 
- (void)passValue:(id)responseObject {
//    NSLog(@"%@", responseObject);
    
    NSArray *dataArray = responseObject;
    [self.modelArray removeAllObjects];
    
    for (NSDictionary *dic in dataArray) {
        Model *model = [[Model alloc] initWithDictionary:dic];
        [self.modelArray addObject:model];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FocusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:focusCellIdentifier forIndexPath:indexPath];
    
    Model *model = self.modelArray[indexPath.row];
    [cell setValuesForKeysWithModel:model];
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FocusTableViewCell *cell = (FocusTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    DataHandle *dataHandle = [DataHandle defaultHandle];
    
    if (dataHandle.cellArray.count == 0) {
        [dataHandle.cellArray addObject:cell];
    } else {
        NSInteger index = 0;
        for (FocusTableViewCell *focusCell in dataHandle.cellArray) {
            if ([focusCell.titleLabel.text isEqualToString:cell.titleLabel.text]) {
                break;
            } else {
                index++;
            }
        }
        if (index == dataHandle.cellArray.count) {
            [dataHandle.cellArray addObject:cell];
        }
    }
    
    
    Model *model = self.modelArray[indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.urlString = model.url;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
