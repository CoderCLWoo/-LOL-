//
//  CurrentHeroTableViewController.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "CurrentHeroTableViewController.h"
#import "Request.h"
#import "Model.h"
#import "FocusTableViewCell.h"
#import "DetailViewController.h"


static NSString *focusCellIdentifier = @"focusTableViewCell";

@interface CurrentHeroTableViewController ()<RequestDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CurrentHeroTableViewController

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSString *urlString = self.urlString;
    Request *request = [[Request alloc] init];
    request.delegate = self;
    [request getDataFromUrlString:urlString];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // tableView 自适应高度
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //上拉加载
    [self.tableView addFooterWithCallback:^{
        
        [request getDataFromUrlString:urlString];
      
        //给线程添加一个延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadData];
            [tableView footerEndRefreshing];//结束加载的状态
        });
        
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FocusTableViewCell" bundle:nil] forCellReuseIdentifier:focusCellIdentifier];
    
}

#pragma mark - RequestDelegate
- (void)passValue:(id)responseObject {
    NSArray *array = responseObject;
    
    [self.modelArray removeAllObjects];
    
    for (NSDictionary *dic in array) {
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
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    cell.titleLabel.text = model.title;
    cell.durationLabel.text = model.duration;
    cell.numLabel.hidden = YES;
    cell.playImageView.hidden = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    Model *model = self.modelArray[indexPath.row];
    detailViewController.urlString = model.url;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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
