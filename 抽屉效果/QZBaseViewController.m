//
//  CYBaseViewController.m
//  抽屉效果
//
//  Created by qz on 15/10/28.
//  Copyright (c) 2015年 qz. All rights reserved.
//

#import "QZBaseViewController.h"

//DDMenuController
//2.left ---->
//self.refreshControl

@interface QZBaseViewController ()

@property (nonatomic,strong) UIViewController *leftVC;
@property (nonatomic,strong) UIViewController *mainVC;
@property (nonatomic,strong) UIViewController *rightVC;

@end

@implementation QZBaseViewController

-(id)initWithLeftVC:(UIViewController *)leftViewController mianVC:(UIViewController *)mainViewController rightVC:(UIViewController *)rightViewController
{
    self = [super init];
    if (self) {
        //保存三个viewController 方便操作
        self.leftVC = leftViewController;
        self.mainVC = mainViewController;
        self.rightVC = rightViewController;
        
        [self.view addSubview:self.leftVC.view];
        [self.view addSubview:self.rightVC.view];
        [self.view addSubview:self.mainVC.view];
        
        //给主界面的view增加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        [self.mainVC.view addGestureRecognizer:pan];
        
        
    }
    return self;
}

-(void)panHandle:(UIPanGestureRecognizer *)pan
{
    //获取 x,y的移动的偏移量
    CGPoint point = [pan translationInView:self.view];
    //NSLog(@"%@",NSStringFromCGPoint(point));
    
    //让view跟着手势移动
    pan.view.center = CGPointMake(pan.view.center.x + point.x, pan.view.center.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];
    
    //判断向左移动 还是向右移动
    if(pan.view.frame.origin.x >= 0)
    {
        self.leftVC.view.hidden = NO;
        self.rightVC.view.hidden = YES;
    }
    else
    {
        self.leftVC.view.hidden = YES;
        self.rightVC.view.hidden = NO;
    }
    
    //200
    //-140
    //手势停下之后  处理 view的停靠位置
    if(pan.state == UIGestureRecognizerStateEnded)
    {
        CGFloat xOffset = 0;
        //偏移量 超过140 停在140的位置
        if(pan.view.frame.origin.x > 140)
        {
            xOffset = [UIScreen mainScreen].bounds.size.width / 2.0f + 140;
        }
        else if (pan.view.frame.origin.x < -140)
        {
            xOffset = [UIScreen mainScreen].bounds.size.width / 2.0f - 140;
        }
        else
        {
            xOffset = [UIScreen mainScreen].bounds.size.width / 2.0f;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            pan.view.center = CGPointMake(xOffset, pan.view.center.y);
        }];
    }
   
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
