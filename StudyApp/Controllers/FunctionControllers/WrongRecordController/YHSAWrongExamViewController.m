//
//  YHSAWrongExamViewController.m
//  
//
//  Created by user on 15/9/11.
//
//

#import "YHSAWrongExamViewController.h"

@interface YHSAWrongExamViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataArray;
}
@property (weak, nonatomic) IBOutlet YHBaseTableView *tableView;

@end

@implementation YHSAWrongExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatDate{
    _dataArray = [[NSMutableArray alloc]init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
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
