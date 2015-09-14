//
//  YHSAExamCollectListViewController.m
//  StudyApp
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAExamCollectListViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSAUserManager.h"
#import "YHSAMockExamDetailsModel.h"
#import "YHSAMockExamAnswerQuestionViewController.h"
@interface YHSAExamCollectListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
    YHBaseTableView * _tableView;
}
@end

@implementation YHSAExamCollectListViewController
-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
    //获取数据
    NSDictionary * dic = @{INTERFACE_FIELD_POST_EXAM_COLLECT_LIST_PHONECODE:[YHSAUserManager sharedTheSingletion].userName};
    [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeExamCollectList infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithData:data];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_EXAM_COLLECT_LIST_SUCCESS intValue]) {
            //进行数据包装
            for (int i=0; i<[(NSArray *)[tmpModel data] count]; i++) {
                YHSAMockExamDetailsModel * model = [[YHSAMockExamDetailsModel alloc]init];
                [model creatModelWithDic:[tmpModel.data objectAtIndex:i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_EXAM_COLLECT_LIST_FAILED intValue]){
            
        }
        
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

-(void)YHCreatView{
    self.title = EXAM_COLLECT_CONTROLLER_TITLE;
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _tableView.backgroundColor = manager.bgColor;
    [_tableView reloadData];
}



#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"examColloectCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
        [manager getTopicModel];
        cell.backgroundColor = manager.cellColor;
        cell.textLabel.textColor=manager.textColor;
    }
    cell.textLabel.text = [_dataArray[indexPath.row] examname];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAMockExamAnswerQuestionViewController * con = [[YHSAMockExamAnswerQuestionViewController alloc]init];
    //进行请求
    NSDictionary * dic = @{INTERFACE_FIELD_POST_EXAM_EXAM_ID:[_dataArray[indexPath.row] examid]};
    __BLOCK__WEAK__SELF__(__self);
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeMockExamDetails infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        YHSARequestGetDataModel * tmpModel = [[YHSARequestGetDataModel alloc]init];
        [tmpModel creatModelWithData:data];
        if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_EXAM_COLLECT_LIST_SUCCESS intValue]) {
            YHSAMockExamDetailsModel * model = [[YHSAMockExamDetailsModel alloc]init];
            [model creatModelWithDic:[tmpModel.data firstObject]];
            con.dataModel = model;
            [[__self navigationController] pushViewController:con animated:YES];
        }else if ([tmpModel.resultCode intValue]==[INTERFACE_RETURN_POST_EXAM_COLLECT_LIST_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
