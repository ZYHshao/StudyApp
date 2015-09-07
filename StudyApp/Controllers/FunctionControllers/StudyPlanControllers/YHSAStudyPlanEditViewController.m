//
//  YHSAStudyPlanEditViewController.m
//  
//
//  Created by user on 15/9/7.
//
//

#import "YHSAStudyPlanEditViewController.h"
#import "YHSAHttpManager.h"
@interface YHSAStudyPlanEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet YHBaseTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *theButton;

@end

@implementation YHSAStudyPlanEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)YHCreatDate{
    if (_style==YHSAStudyPlanEditViewControllerStyleDetails) {
        //取数据
        NSDictionary * dic = @{INTERFACE_FIELD_POST_STUDY_PLAN_STATUS:INTERFACE_FIELD_POST_DETAILS_STUDY_PLAN_STATUS,INTERFACE_FIELD_POST_STUDY_PLAN_ID:_planId};
        [YHSAHttpManager YHSARequestPost:YHSARequestTypeStudyPlanList infoDic:dic Succsee:^(NSData *data) {
            NSDictionary * dataDic = [YHBaseJOSNAnalytical dictionaryWithJSData:data];
            NSLog(@"%@",dataDic);
        } andFail:^(YHBaseError *error) {
            
        } isbuffer:NO];
    }
}


- (IBAction)btnCick:(UIButton *)sender {
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
