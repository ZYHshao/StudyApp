//
//  YHSAActivityIndicatorView.m
//  
//
//  Created by user on 15/8/19.
//
//

#import "YHSAActivityIndicatorView.h"

@implementation YHSAActivityIndicatorView
{
    UIImageView * _activityImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//重写界面的方法
-(void)reloadView{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    _activityImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, SCREEN_HEIGHT/2-20, 40, 40)];
    //加动画帧
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i= 0; i<8; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d.png",i]];
        [arr addObject:image];
    }
    _activityImage.animationImages = arr;
    _activityImage.animationRepeatCount = 0;
    _activityImage.animationDuration = 1;
    [_activityImage startAnimating];
    [self addSubview:_activityImage];
}

@end
