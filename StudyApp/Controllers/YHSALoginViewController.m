//
//  YHSALoginViewController.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHSALoginViewController.h"
#import "YHTopicProtocol.h"
#import "YHTopicColorModel.h"
@interface YHSALoginViewController ()<YHTopicProcotol>
{
    UIImageView * _userNameImageView;
    UIImageView * _userSecretImageView;
    UITextField * _userNameTestField;
    UITextField * _userSecretTestField;
    UIButton    * _shouldAutoLoginBtn;
    UILabel     * _shouldAutoLoginLabel;
    UIButton    * _loginBtn;
    UIButton    * _registBtn;
    UIButton    * _refindSecretBtn;
}
@end

@implementation YHSALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加监听主题更换的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(useYHTopicToCreatViewWithModel:) name:YHTopicChangeTopicNotication object:nil];
    
    
}



-(void)useYHTopicToCreatViewWithModel:(YHTopicModel)model{
    
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
