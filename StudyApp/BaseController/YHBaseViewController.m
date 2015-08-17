//
//  YHBaseViewController.m
//  
//
//  Created by user on 15/8/17.
//
//

#import "YHBaseViewController.h"

@interface YHBaseViewController ()

@end

@implementation YHBaseViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //取消导航的影响
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //添加监听主题更换的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(useYHTopicToCreatViewWithModel) name:YHTopicChangeTopicNotication object:nil];
    [self YHCreatView];
    //加载主题
    [self useYHTopicToCreatViewWithModel];
}
//子类实现如下方法
-(void)YHCreatView{
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)useYHTopicToCreatViewWithModel{
    
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
