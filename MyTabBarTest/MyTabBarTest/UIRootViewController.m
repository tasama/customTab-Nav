//
//  UIRootViewController.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "UIRootViewController.h"
#import "UIRootView.h"
#import "UIRootItem.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"

@interface UIRootViewController () <UIRootViewDelegate> {
    
    NSArray <UIRootItem *>* _items;
}

@property (nonatomic, strong) UIRootView *rootView;

@property (nonatomic, strong) UIView *contentView;

@end

#define IS_IPHONE_X (kScreenHeight == 812.0f)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define TAB_HEIGHT (IS_IPHONE_X) ? 83 : 49

@implementation UIRootViewController

+ (instancetype)sharedRoot {
    
    static UIRootViewController *root = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        root = [[UIRootViewController alloc] init];
    });
    return root;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self setTabItems];
    [self initChildViewController];
}

#pragma mark - ********* Init ChildViewController *********

- (void)initChildViewController {
    
    OneViewController *one = [[OneViewController alloc] init];
    TwoViewController *two = [[TwoViewController alloc] init];
    ThreeViewController *three = [[ThreeViewController alloc] init];
    FourViewController *four = [[FourViewController alloc] init];
    FiveViewController *five = [[FiveViewController alloc] init];
    
    [self addChildViewController:one];
    [self addChildViewController:two];
    [self addChildViewController:three];
    [self addChildViewController:four];
    [self addChildViewController:five];
    
    one.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.contentView addSubview:one.view];
}

#pragma mark - ********* UI *********

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.contentView.frame = self.view.bounds;
}

#pragma mark - ********* Set Tab *********

- (void)setTabItems {
    
    NSArray *images = @[@"tab_button_home_default",@"tab_button_news_default",@"tab_button_collection_default",@"tab_button_shopping _default",@"tab_button_personal_default"];
    
    NSArray *selectedImages = @[@"tab_button_home_selected",@"tab_button_news_selected",@"tab_button_collection_selected",@"tab_button_shopping _selected",@"tab_button_personal_selected"];
    
    NSArray *titles = @[@"首页", @"最新", @"收藏", @"购物车", @"我的"];
    
    NSMutableArray <UIRootItem *>*items = @[].mutableCopy;
    for (int i = 0; i < 5; i ++) {
        
        UIRootItem *item = [[UIRootItem alloc] init];
        item.image = [UIImage imageNamed:images[i]];
        item.selectedImage = [UIImage imageNamed:selectedImages[i]];
        item.title = titles[i];
        [items addObject:item];
    }
    _items = items.copy;
    [self.view addSubview:self.rootView];
}

#pragma mark - ********* Public *********

- (void)selectedtoIndex:(NSUInteger)toIndex {
    
    [self.rootView itemDidSelectedWith:self.rootView.items[toIndex]];
}

- (void)hideTabBar:(BOOL)hide animated:(BOOL)animation {
    
    if (animation) {
      
        CGFloat top = self.rootView.frame.origin.y;
        if (hide) {
            
            top = kScreenHeight;
        } else {
            
            top = kScreenHeight - (TAB_HEIGHT);
        }
        [UIView animateWithDuration:.25f animations:^{
            
            self.rootView.frame = CGRectMake(0, top, kScreenWidth, TAB_HEIGHT);
        }];
        
    } else {
       
        self.rootView.hidden = hide;
    }
}

#pragma mark - ********* ROOT DELEGATE *********

- (void)itemDidSelectedFrom:(UIRootItem *)fromItem toItem:(UIRootItem *)toItem {
    
    NSUInteger fromIndex = fromItem.tag;
    NSUInteger toIndex = toItem.tag;
    BaseViewController *fromVC = self.childViewControllers[fromItem.tag];
    BaseViewController *toVC = self.childViewControllers[toItem.tag];
    //向左滚动
    if (fromIndex < toIndex) {
        
        toVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self.contentView addSubview:toVC.view];
        
        [UIView animateWithDuration:.25f animations:^{
            
            fromVC.view.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
            toVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                [fromVC.view removeFromSuperview];
            }
        }];
    } else {
    //向右滚动
        
        toVC.view.frame = CGRectMake(- kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [self.contentView addSubview:toVC.view];
        
        [UIView animateWithDuration:.25f animations:^{
            
            fromVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
            toVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        } completion:^(BOOL finished) {
            
            if (finished) {
                
                [fromVC.view removeFromSuperview];
            }
        }];
    }

    
}

#pragma mark - ********* LAZY LOAD *********

- (UIRootView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[UIRootView alloc] initWithItems:_items];
        _rootView.delegate = self;
        CGFloat height = kScreenHeight;
        CGFloat tabHeight = TAB_HEIGHT;
        NSLog(@"%.2lf, %.2lf", height, tabHeight);
        _rootView.frame = CGRectMake(0, kScreenHeight - (TAB_HEIGHT), kScreenWidth, TAB_HEIGHT);
    }
    return _rootView;
}

- (UIView *)contentView {
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

@end
