//
//  YHSAStudyPlanViewController.m
//  
//
//  Created by user on 15/9/6.
//
//

#import "YHSAStudyPlanViewController.h"

@interface YHSAStudyPlanViewController ()
@property (weak, nonatomic) IBOutlet YHBaseCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet UIView *funcView;
@property (weak, nonatomic) IBOutlet UILabel *throughLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *reviseButton;

@end

@implementation YHSAStudyPlanViewController
- (IBAction)deleteClick:(UIButton *)sender {
}
- (IBAction)reviseClick:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
