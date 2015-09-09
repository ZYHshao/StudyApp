//
//  QuestionCollectViewController.m
//  
//
//  Created by user on 15/9/9.
//
//

#import "QuestionCollectViewController.h"

@interface QuestionCollectViewController ()

@end

@implementation QuestionCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatDate{
    self.dataArray = @[@[@"1",@"2"],@[@"1",@"2",@"3"],@[@"1"]];
    self.rowsHight=44;
    self.cellClass = [UITableViewCell class];
    self.cellFunc = ^(id model,UITableViewCell * cell){
        cell.textLabel.text = model;
    };
    self.isAutoOpenSection=NO;
    NSMutableArray * headArray = [[NSMutableArray alloc]init];
    for (int i=0; i<3; i++){
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,100)];
        view.backgroundColor = [UIColor redColor];
        [headArray addObject:view];
    }
    self.headArray=headArray;
    self.tableViewStyle = UITableViewStylePlain;
    self.shouldRefresh=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //对选中的cell处理
}
@end
