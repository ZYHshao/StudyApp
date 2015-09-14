//
//  YHSAWrongRecordViewController.m
//  
//
//  Created by user on 15/9/9.
//
//

#import "YHSAWrongRecordViewController.h"
#import "YHSAHttpManager.h"
#import "YHSAUserManager.h"
#import "YHSAActivityIndicatorView.h"
#import "YHSARequestGetDataModel.h"
#import "YHSAWrongRecordModel.h"
#import "YHSASubWrongRecordModel.h"
#import "YHSAMockExamAnswerQuestionViewController.h"
#import "YHSAWrongRecordPostModel.h"
@interface YHSAWrongRecordViewController ()
{
    NSMutableArray * _dataArray;
    NSMutableArray * _headArray;
}
@end

@implementation YHSAWrongRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//只做相关设置即可
-(void)YHCreatDate{
    self.title = WRONG_RECORD_CONTROLLER_TITLE;
    //设置相关属性
    _dataArray = [[NSMutableArray alloc]init];
    _headArray = [[NSMutableArray alloc]init];
    self.rowsHight = 30;
    self.cellClass = [UITableViewCell class];
    self.tableViewStyle = UITableViewStyleGrouped;
    self.cellFunc = ^(YHSASubWrongRecordModel* model,UITableViewCell*cell){
        cell.textLabel.text = [NSString stringWithFormat:@"%@  存有%@道答错过的试题",model.txname,model.count];
    };
    __BLOCK__WEAK__SELF__(__self);
    __block NSArray * array = _dataArray;
    self.selectedCellFunc=^(NSIndexPath *index){
        YHSAWrongRecordPostModel * model = [[YHSAWrongRecordPostModel alloc]init];
        model.phonecode = [YHSAUserManager sharedTheSingletion].userName;
        model.examid = [array[index.section] examid];
        model.txcode = [[[array[index.section] txlist] objectAtIndex:index.row] objectForKey:@"txcode"];
        model.count =[[[array[index.section] txlist] objectAtIndex:index.row] objectForKey:@"count"];
        YHSAMockExamAnswerQuestionViewController * con = [[YHSAMockExamAnswerQuestionViewController alloc]init];
        con.isNotExam=YES;
        con.subDataModel = model;
        [[__self navigationController] pushViewController:con animated:YES];
    };
    self.isAutoOpenSection=YES;
    
    //取数据
   
    NSDictionary * dic = @{INTERFACE_FIELD_POST_WRONG_RECORD_PHONECODE:[YHSAUserManager sharedTheSingletion].userName};
    [[YHSAActivityIndicatorView sharedTheSingletion]show];
    [YHSAHttpManager YHSARequestPost:YHSARequestTypeWrongRecord infoDic:dic Succsee:^(NSData *data) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
        YHSARequestGetDataModel * model = [[YHSARequestGetDataModel alloc]init];
        [model creatModelWithData:data];
        if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_WRONG_RECORD_SUCCESS intValue]) {
            NSMutableArray * tmpArray = [[NSMutableArray alloc]init];

            for (int i=0; i<[(NSArray*)[model.data objectForKey:@"pagedata"] count]; i++) {
                              YHSAWrongRecordModel * fathModel = [[YHSAWrongRecordModel alloc]init];
                [fathModel creatModelWithDic:[[model.data objectForKey:@"pagedata"] objectAtIndex:i]];
                NSMutableArray * subArray = [[NSMutableArray alloc]init];
                for (int j=0; j<fathModel.txlist.count; j++) {
                    YHSASubWrongRecordModel * subModel = [[YHSASubWrongRecordModel  alloc]init];
                    [subModel creatModelWithDic:[fathModel.txlist objectAtIndex:j]];
                    [subArray addObject:subModel];
                }
                [_dataArray addObject:fathModel];
                //头视图
                UIView * headView = [self creatHeadView:fathModel.examname];
                [_headArray addObject:headView];
                [tmpArray addObject:subArray];
            }
            self.dataArray=tmpArray;
            self.headArray=_headArray;
            [self reloadData];
        }else if ([model.resultCode intValue]==[INTERFACE_RETURN_POST_WRONG_RECORD_FAILED intValue]){
            
        }
    } andFail:^(YHBaseError *error) {
        [[YHSAActivityIndicatorView sharedTheSingletion]unShow];
    } isbuffer:NO];
    
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    self.tableView.backgroundColor= manager.bgColor;
    [self reloadData];
}

-(UIView *)creatHeadView:(NSString *)title{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UILabel * label = [[UILabel alloc]initWithFrame:view.frame];
    label.numberOfLines=0;
    label.font=[UIFont boldSystemFontOfSize:18];
    label.text=title;
    view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    [view addSubview:label];
    return view;
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
