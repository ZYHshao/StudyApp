//
//  YHSANavigationViewController.m
//  
//
//  Created by user on 15/8/18.
//
//

#import "YHSANavigationViewController.h"

@interface YHSANavigationViewController ()

@end

@implementation YHSANavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)YHCreatView{
    
}
-(void)useYHTopicToCreatViewWithModel{
    YHTopicColorManager * model = [YHTopicColorManager sharedTheSingletion];
    //获取主题
    [model getTopicModel];
    self.navigationBar.barTintColor = model.navColor;
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:model.navTextColor,UITextAttributeTextColor,nil]];
    self.navigationBar.tintColor = model.navTextColor;
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
