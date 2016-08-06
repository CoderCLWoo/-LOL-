//
//  CommentateViewController.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "CommentateViewController.h"
#import "Request.h"
#import "HeroTableViewCell.h"
#import "CommentateModel.h"
#import "CurrentHeroTableViewController.h"

static NSString *cellIdentifier = @"cell";

@interface CommentateViewController ()<RequestDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation CommentateViewController

- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"解说";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(settingButtonSelect) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    Request *request = [[Request alloc] init];
    request.delegate = self;
    [request getDataFromUrlString:COMMENTATEURL];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // tableView 自适应高度
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //上拉加载
    [tableView addFooterWithCallback:^{
        
        [request getDataFromUrlString:COMMENTATEURL];
        //给线程添加一个延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];//结束加载的状态
        });
        
    }];
    
    [tableView registerNib:[UINib nibWithNibName:@"HeroTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)settingButtonSelect {
    NSLog(@"settingButtonSelect");
}

#pragma mark - RequestDelegate
- (void)passValue:(id)responseObject {

    NSArray *array = responseObject;
    
    [self.modelArray removeAllObjects];
    
    for (NSDictionary *dic in array) {
        CommentateModel *model = [[CommentateModel alloc] initWithDictionary:dic];
        [self.modelArray addObject:model];
    }
    
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CommentateModel *model = self.modelArray[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
    cell.titleLabel.text = model.title;
    cell.catsLabel.text = [NSString stringWithFormat:@"共%@个视频",model.count];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrentHeroTableViewController *currentHeroTableViewController = [[CurrentHeroTableViewController alloc] init];
    
    CommentateModel *model = self.modelArray[indexPath.row];
    
    currentHeroTableViewController.urlString = [NSString stringWithFormat:@"http://lol.video.luckyamy.com/api/?cat=jieshuo&id=%@&page=1&ap=lol&ver=1.3",model.ids];
    
    currentHeroTableViewController.title = model.title;
    
    [currentHeroTableViewController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    [self.navigationController pushViewController:currentHeroTableViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
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
