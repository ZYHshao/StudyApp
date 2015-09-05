//
//  StudyNoteViewController.m
//  StudyApp
//
//  Created by apple on 15/9/4.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//

#import "YHSAStudyNoteViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAGetStudyNotelListModel.h"
#import "YHSAStudyNoteListTableViewCell.h"
#import "YHSAEditStudyNoteViewController.h"
@interface YHSAStudyNoteViewController ()<UITableViewDelegate,UITableViewDataSource,YHSAStudyNoteListTableViewCellDelegate>
{
    YHBaseTableView * _tableView;
    NSMutableArray * _dataArray;
}
@end

@implementation YHSAStudyNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)YHCreatDate{
    //下载数据
    _dataArray = [[NSMutableArray alloc]init];
    [self downData];
}
-(void)downData{
    NSDictionary * dic = @{INTERFACE_FIELD_POST_GET_STUDY_NOTES_PHONECODE:[YHSAUserManager sharedTheSingletion].userName,INTERFACE_FIELD_POST_STUDY_NOTES_STATUS:INTERFACE_FIELD_POST_GET_STUDY_NOTES_STATUS};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeGetStudyNote infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        [_tableView.header endRefreshing];
        NSDictionary * tmpDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
        YHSARequestGetDataModel  * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithDic:tmpDic];
        //进行数据包装
        if ([model.resultCode intValue]==[INTERFACE_RETURN_GET_STUDY_NOTE_LIST_SUCCESS intValue]) {
            [_dataArray removeAllObjects];
            for(int i=0;i<[model.data count];i++){
             YHSAGetStudyNotelListModel * submodel = [[YHSAGetStudyNotelListModel alloc]init];
                [submodel creatModelWithDic:[model.data objectAtIndex:i]];
                [_dataArray addObject:submodel];
            }
            [_tableView reloadData];
            
        }else if([model.resultCode intValue]==[INTERFACE_RETURN_GET_STUDY_NOTE_LIST_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [_tableView.header endRefreshing];
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
}

-(void)YHCreatView{
    self.title=STUDY_NOTE_CONTROLLER_TITLE;
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    __BLOCK__WEAK__SELF__(__self);
    [_tableView shouldRefresh:^{
        [__self downData];
    }];
    [self.view addSubview:_tableView];
    //创建导航新建按钮
    UIBarButtonItem * newItem = [[UIBarButtonItem alloc]init];
    newItem.image = [[UIImage imageNamed:STUDY_NOTE_NEW_IMAGE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newItem.target=self;
    newItem.action=@selector(newNote);
    self.navigationItem.rightBarButtonItem= newItem;
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _tableView.backgroundColor = manager.bgColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//新建笔记
-(void)newNote{
    YHSAEditStudyNoteViewController * con = [[YHSAEditStudyNoteViewController alloc]init];
    con.type=YHSAEditStudyNoteViewControllerTypeNew;
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHSAStudyNoteListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_STUDY_NOTE_LIST];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:TABLEVIEW_CELL_ID_STUDY_NOTE_LIST owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.YHDelegate=self;
    }
    cell.indexRow = (int)indexPath.row;
    YHSAGetStudyNotelListModel * model = _dataArray[indexPath.row];
    cell.theTitleLabel.text = [NSString stringWithFormat:@"%d、%@",(int)indexPath.row+1,model.title];
    cell.dateLabel.text=model.date;
    return cell;
}

#pragma mark - 删除与修改笔记操作
-(void)YHSAStudyNoteListTableViewCellClickRevise:(int)indexRow{
    YHSAGetStudyNotelListModel * model = _dataArray[indexRow];
    YHSAEditStudyNoteViewController * con = [[YHSAEditStudyNoteViewController alloc]init];
    con.type=YHSAEditStudyNoteViewControllerTypeEdit;
    con.noteId=model.id;
    [self.navigationController pushViewController:con animated:YES];

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
