//
//  BaseViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong, readwrite) UIImageView *navigationBar;

@property (nonatomic, strong) UILabel *titleLabel;

@end

#define IS_IPHONE_X (kScreenHeight == 812.0f)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define NAV_HEIGHT IS_IPHONE_X ? 88 : 64
#define STA_HEIGHT IS_IPHONE_X ? 44 : 20

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self.view addSubview:self.navigationBar];
    [self.navigationBar addSubview:self.backBtn];
    [self.navigationBar addSubview:self.titleLabel];
    [self setBackBtnImage];
}

#pragma mark - ********* UI *********

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    CGFloat navHeight =  NAV_HEIGHT;
    self.backBtn.frame = CGRectMake(0, STA_HEIGHT, 44, 44);
    self.titleLabel.frame = CGRectMake(44, STA_HEIGHT, kScreenWidth - 88, 44.0f);
}

- (void)setBackBtnImage {
    
    if ((self.presentingViewController && !self.navigationController) ||
        (self.navigationController && self == self.navigationController.viewControllers.firstObject)){
        [self.backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    }else{
        
        if (self.navigationController &&
            self != self.navigationController.viewControllers.firstObject &&
            self.parentViewController != self.navigationController.viewControllers.firstObject ) {
            [self.backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - ********* Public *********

- (void)hideNav:(BOOL)hide withAnimation:(BOOL)animation {
    
    if (animation) {
        
        CGFloat top = 0;
        if (hide) {
            
            top = - (NAV_HEIGHT);
        } else {
            
            top = 0;
        }
        [UIView animateWithDuration:.25f animations:^{
           
            self.navigationBar.frame = CGRectMake(0, top, kScreenWidth, NAV_HEIGHT);
        }];
    } else {
        
        self.navigationBar.hidden = hide;
    }
}

#pragma mark - ********* Private *********

-(void)onBackButtonClick
{
    [self.view endEditing:YES];
    if (self.presentingViewController &&
        (!self.navigationController ||self == self.navigationController.viewControllers.firstObject)) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        if (self != self.navigationController.viewControllers.firstObject) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)setNavTitle:(NSString *)navTitle {
    
    _navTitle = navTitle;
    self.titleLabel.text = navTitle;
}

#pragma mark - ********* LAZY LOAD *********

- (UIImageView *)navigationBar {
    
    if (!_navigationBar) {
        
        _navigationBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_bg"]];
        _navigationBar.frame = CGRectMake(0, 0, kScreenWidth, NAV_HEIGHT);
        _navigationBar.contentMode = UIViewContentModeScaleAspectFill;
        _navigationBar.clipsToBounds = YES;
        _navigationBar.userInteractionEnabled = YES;
    }
    return _navigationBar;
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn addTarget:self action:@selector(onBackButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17.0f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
