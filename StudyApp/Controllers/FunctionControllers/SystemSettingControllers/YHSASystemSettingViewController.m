//
//  YHSASystemSettingViewController.m
//  
//
//  Created by user on 15/8/21.
//
//

#import "YHSASystemSettingViewController.h"
#import "YHSASystemSettingManager.h"
@interface YHSASystemSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    YHBaseTableView * _tableView;
    NSArray * _dataArray;
    UISwitch * _topicSwitch;
    UISwitch * _upDataSwitch;
    
}
@end

@implementation YHSASystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatDate{
    _dataArray = @[SYSTEM_SETTING_SWITCH_TOPIC,SYSTEM_SETTING_SWITCH_UPDATA,SYSTEM_SETTING_RETURN_IDEA,SYSTEM_SETTING_ABOUT_WE];
}

-(void)YHCreatView{
    self.title = SYSTEM_SETTING_CONTROLLER_TITLE;
    
    _tableView = [[YHBaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _topicSwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
    [_topicSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    if ([YHSASystemSettingManager sharedTheSingletion].topic==dayTime) {
        _topicSwitch.on = NO;
    }else{
        _topicSwitch.on = YES;
    }
   
    _upDataSwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
    [_upDataSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
     _upDataSwitch.on =  [YHSASystemSettingManager sharedTheSingletion].autoUpdataExamBank;
    
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    _tableView.backgroundColor = manager.bgColor;
    
}


-(void)switchClick:(UISwitch *)sender{
    if (sender==_topicSwitch) {
    if (sender.isOn) {
            [YHSASystemSettingManager sharedTheSingletion].topic=nightTime;
        }else{
            [YHSASystemSettingManager sharedTheSingletion].topic=dayTime;
        }
        [YHTopicColorManager postTopicChangeMessage];
    }else if (sender==_upDataSwitch){
        if (sender.isOn) {
            [YHSASystemSettingManager sharedTheSingletion].autoUpdataExamBank=YES;
        }else{
            [YHSASystemSettingManager sharedTheSingletion].autoUpdataExamBank=NO;
        }
    }
}


#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEW_CELL_ID_SYSTEM_SETTING];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLEVIEW_CELL_ID_SYSTEM_SETTING];
    }
        cell.textLabel.text = _dataArray[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                _topicSwitch.center = CGPointMake(cell.frame.size.width-55, cell.frame.size.height/2);
                [cell.contentView addSubview:_topicSwitch];
            }
                break;
            case 1:
            {
                _upDataSwitch.center = CGPointMake(cell.frame.size.width-55, cell.frame.size.height/2);
                [cell.contentView addSubview:_upDataSwitch];
            }
                break;
            default:
                break;
        }
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
