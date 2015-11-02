//
//  HandleViewController.m
//  项目三~healthy guys
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 Feyddy. All rights reserved.
//

#import "HandleViewController.h"
#import "ThemeButton.h"

@interface HandleViewController ()

@end

@implementation HandleViewController{
    UILabel *_label;
    UIView *_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _ceateButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_ceateButton {
    
//    self.view.backgroundColor = [UIColor clearColor];
    _view = [[UIView alloc] init];
    _view.frame = CGRectMake(90, 200, 180, 280);
//    _view.backgroundColor = [UIColor clearColor];
//    _view.layer.transform = CATransform3DMakeRotation(M_PI/8, 0, 0, 1);
    [self.view addSubview:_view];
    
    NSArray *imgName = @[@"咨询.png",
                        @"图书.png",
                        @"菜谱.png",
                        @"个人.png"];
    for (int i = 0; i < imgName.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 70 *(i + 1), 60, 60);
        button.layer.cornerRadius = 20;
        button.layer.borderWidth = 2;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.clipsToBounds = YES;
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:imgName[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 200, 300)];
    _label.numberOfLines = 0;
    [self.view addSubview:_label];
}
- (void)buttonAction:(UIButton *)button {
    _view.layer.cornerRadius = 10;
    _view.layer.borderColor = [UIColor blackColor].CGColor;
    _view.layer.borderWidth = 2;
    NSArray *handle = @[@"1.点击咨询之家可以进入咨询分类列表；\n2.点解咨询详情可以进入详情界面；\n3.最新推荐与更新正在开发中.",
                    @"1.点击图书之家可以进入图书分类列表，查看自己感兴趣的总类；\n2.点解图书详情可以进入图像详情介绍界面；\n3.最新推荐与更新正在开发中.",
                    @"1.点击菜谱之家可以进入菜谱分类列表，查看自己喜欢的美食；\n2.点解菜谱详情可以进入菜谱详情介绍界面查看菜谱的具体做法；\n3.最新推荐与更新正在开发中.",
                    @"1.点击登陆/注册可以进入登陆界面，可以选择登陆或注册；\n2.点解清除缓存弹出提示框提示是否清除缓存；\n3.点击操作说明进入操作说明界面；\n4.点击版本更新可以查看最新版本选择是否更新."];
    [UIView animateWithDuration:0.25 animations:^{
        if (button.tag == 0) {
            _label.text = [NSString stringWithFormat:@"%@",handle[0]];
            _view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"big_home"]];
            _view.layer.transform = CATransform3DMakeRotation(M_PI/10, 0, 0, 1);
            
        } else if (button.tag == 1) {
            _label.text = [NSString stringWithFormat:@"%@",handle[1]];
            _view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"big_book"]];
            _view.layer.transform = CATransform3DMakeRotation(M_PI/8, 0, 0, 1);
        } else if ( button.tag == 2){
            _label.text = [NSString stringWithFormat:@"%@",handle[2]];
            _view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"big_menu"]];
            _view.layer.transform = CATransform3DMakeRotation(M_PI/9, 0, 0, 1);
        } else if (button.tag == 3) {
            _label.text = [NSString stringWithFormat:@"%@",handle[3]];
            _view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"big_person"]];
            _view.layer.transform = CATransform3DMakeRotation(M_PI/7, 0, 0, 1);
        }

    }];
}
@end
