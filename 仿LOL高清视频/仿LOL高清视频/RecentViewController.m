//
//  RecentViewController.m
//  仿LOL高清视频
//
//  Created by WuChunlong on 16/6/6.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "RecentViewController.h"
#import "FocusTableViewCell.h"
#import "Model.h"
#import "DataHandle.h"
#import "DetailViewController.h"

static NSString *focusCellIdentifier = @"focusTableViewCell";

@interface RecentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.dataHandle = [DataHandle defaultHandle];
    self.navigationItem.title = [NSString stringWithFormat:@"- 共%ld条 -", self.dataHandle.cellArray.count];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeButtonSelect)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // tableView 自适应高度
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:@"FocusTableViewCell" bundle:nil] forCellReuseIdentifier:focusCellIdentifier];

    
    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataHandle.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FocusTableViewCell *cell = self.dataHandle.cellArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FocusTableViewCell *cell = (FocusTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.urlString = cell.url;
    [self.navigationController pushViewController:detailViewController animated:YES];
}



- (void)removeButtonSelect {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"确认" message:@"您确定要清空收藏夹吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.dataHandle.cellArray removeAllObjects];
        self.navigationItem.title = [NSString stringWithFormat:@"- 共%ld条 -", self.dataHandle.cellArray.count];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertViewController addAction:okAction];
    [alertViewController addAction:cancelAction];
    [self presentViewController:alertViewController animated:YES completion:^{}];
    
}



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 
     return YES;
 }
 


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         
         DataHandle *dataHandle = [DataHandle defaultHandle];
         [dataHandle.cellArray removeObjectAtIndex:indexPath.row];
         self.navigationItem.title = [NSString stringWithFormat:@"- 共%ld条 -", self.dataHandle.cellArray.count];
         
         // Delete the row from the data source
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
         [tableView reloadData];
     }
     
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


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
