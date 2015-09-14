//
//  YHSARecordsViewController.m
//  
//
//  Created by user on 15/9/7.
//
//

#import "YHSARecordsViewController.h"

@interface YHSARecordsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sreceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@end

@implementation YHSARecordsViewController
- (IBAction)clickBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatView{
    _sreceLabel.text  = [NSString stringWithFormat:@"您的成绩:%d",_sorce];
    _timeLabel.text = [NSString stringWithFormat:@"您的用时:%d分%d秒",_time/60,_time%60];
    [_clickBtn setTitle:@"查看错题" forState:UIControlStateNormal];
    [_clickBtn setBackgroundColor:[UIColor blueColor]];
    [_clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _clickBtn.layer.masksToBounds = YES;
    _clickBtn.layer.cornerRadius = 6;
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * manager = [YHTopicColorManager sharedTheSingletion];
    [manager getTopicModel];
    self.view.backgroundColor = manager.bgColor;
    self.titleLabel.backgroundColor= manager.labelColor;
    self.titleLabel.textColor = manager.textColor;
    _sreceLabel.backgroundColor = manager.bgColor;
    _sreceLabel.textColor = manager.textColor;
    _clickBtn.backgroundColor = manager.btnColor;
    [_clickBtn setTitleColor:manager.btnTextColor forState:UIControlStateNormal];
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
