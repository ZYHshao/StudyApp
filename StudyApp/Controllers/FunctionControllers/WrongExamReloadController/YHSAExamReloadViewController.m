//
//  YHSAExamReloadViewController.m
//  StudyApp
//
//  Created by apple on 15/9/13.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAExamReloadViewController.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAWrongExamReloadModel.h"
#import "YHSAWrongExamReloadTableViewCell.h"
@interface YHSAExamReloadViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
    YHBaseTableView * _tableView;
}
@end

@implementation YHSAExamReloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
    NSDictionary * dic = @{INTERFACE_FIELD_POST_WRONG_EXAM_RELOAD_PHONECODE:[YHSAUserManager sharedTheSingletion].userName};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeWrongExamReloadList infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithData:data];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_WRONG_EXAM_RELOAD_SUCCESS intValue]) {
            YHSAWrongExamReloadModel * fatherModel = [[YHSAWrongExamReloadModel alloc]init];
            for (int i=0; i<[(NSArray *)[tmpModel.data objectForKey:@"pagedata"] count]; i++) {
                [fatherModel creatModelWithDic:[[tmpModel.data objectForKey:@"pagedata"] objectAtIndex:i]];
                [_dataArray addObject:fatherModel];
            }
            [_tableView reloadData];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_WRONG_EXAM_RELOAD_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}



-(void)YHCreatView{
    self.title = WRONG_EXAM_RELOAD_CONTROLLER_TITLE;
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_dataArray[indexPath.row] txlist].count*30+80;
    return height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"WrongReloadCell";
    YHSAWrongExamReloadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[YHSAWrongExamReloadTableViewCell alloc]init];
       
    }
    cell.theTitle = [_dataArray[indexPath.row] typename];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i=0; i<[_dataArray[indexPath.row] txlist].count; i++) {
        YHSASubWrongExamReloadModel * model = [[YHSASubWrongExamReloadModel  alloc]init];
        [model creatModelWithDic:[[_dataArray[indexPath.row] txlist] objectAtIndex:i]];
        [array addObject:model];
    }
    cell.dataArray=array;
    return cell;
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
