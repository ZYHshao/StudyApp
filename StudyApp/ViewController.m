//
//  ViewController.m
//  StudyApp
//
//  Created by user on 15/8/17.
//  Copyright (c) 2015年 jaki.zhang. All rights reserved.
//启动加载页面

#import "ViewController.h"
#import "YHSAMainToolsViewController.h"
#import "YHSANavigationViewController.h"
#import "YHSALoginViewController.h"
#import "YHSARegistViewController.h"

@interface ViewController ()
{
    UIScrollView * _loaderScorllView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void)YHCreatView{
    _loaderScorllView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _loaderScorllView.bounces=NO;
    _loaderScorllView.showsHorizontalScrollIndicator = NO;
    _loaderScorllView.showsVerticalScrollIndicator = NO;
    _loaderScorllView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 0);
    _loaderScorllView.pagingEnabled=YES;
    [self.view addSubview:_loaderScorllView];
    UIImageView * page1 = [[UIImageView alloc]initWithFrame:self.view.frame];
    page1.image=[UIImage imageNamed:LOADER_ONE_BG_IMAGE];
    [_loaderScorllView addSubview:page1];
    
    UIImageView * page2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    page2.userInteractionEnabled = YES;
    page2.image = [UIImage imageNamed:LOADER_TWO_BG_IMAGE];
    //创建logo和按钮
    UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 100, 200, 100)];
    logo.image = [UIImage imageNamed:LOADER_LOGO_IMAGE];
    [page2 addSubview:logo];
    __BLOCK__WEAK__SELF__(tmpCon);
    YHBaseButton * regist = [[YHBaseButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 320, 200, 60) backgroundImage:nil backgroundColor:[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1] textColor:[UIColor whiteColor] titleText:LOADER_REGIST_BUTTON_TEXT andClickBlock:^(YHBaseButton *btn) {
        //跳转注册
        YHSANavigationViewController * nav = [[YHSANavigationViewController alloc]initWithRootViewController:[[YHSAMainToolsViewController alloc]init]];
        [nav pushViewController:[[YHSARegistViewController alloc]init] animated:NO];
        [tmpCon presentViewController:nav animated:YES completion:nil];
    }];
    regist.titleLabel.font= [UIFont boldSystemFontOfSize:TEXT_FONT_SIZE_BIG_TITLE];
    [regist setCornerRaidus:30];
    
    YHBaseButton * next = [[YHBaseButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, 40, 60, 30) backgroundImage:nil backgroundColor:nil textColor:[UIColor grayColor] titleText:LOADER_NEXT_BUTTON_TEXT andClickBlock:^(YHBaseButton *btn) {
        //跳转功能
        YHSANavigationViewController * nav = [[YHSANavigationViewController alloc]initWithRootViewController:[[YHSAMainToolsViewController alloc]init]];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    next.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    YHBaseButton * login = [[YHBaseButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-90, SCREEN_HEIGHT-50, 180, 20) backgroundImage:nil backgroundColor:nil textColor:[UIColor colorWithRed:10/255.0 green:85/255.0 blue:160/255.0 alpha:1] titleText:LOADER_LOGIN_BUTTON_TEXT andClickBlock:^(YHBaseButton *btn) {
        //跳转登陆
        YHSANavigationViewController * nav = [[YHSANavigationViewController alloc]initWithRootViewController:[[YHSAMainToolsViewController alloc]init]];
        [nav pushViewController:[[YHSALoginViewController alloc]init] animated:NO];
        [tmpCon presentViewController:nav animated:YES completion:nil];
    }];
    [page2 addSubview:login];
    [page2 addSubview:next];
    [page2 addSubview:regist];
    [_loaderScorllView  addSubview:page2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
