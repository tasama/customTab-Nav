//
//  TwoViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/9.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "TwoViewController.h"
#import "UIRootViewController.h"
@interface TwoViewController ()

@property (nonatomic, assign) BOOL hideT_B;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
    self.navTitle = @"TwoViewController";
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIRootViewController *root = [UIRootViewController sharedRoot];
    if (!self.hideT_B) {
        
        [root hideTabBar:YES animated:YES];
        [self hideNav:YES withAnimation:YES];
    } else {
        
        [root hideTabBar:NO animated:YES];
        [self hideNav:NO withAnimation:YES];
    }
    self.hideT_B = !self.hideT_B;
}

@end
