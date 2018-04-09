//
//  UIRootView.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "UIRootView.h"
#import "UIRootItem.h"

@interface UIRootView () <UIRootItemDelegate>

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation UIRootView

- (instancetype)initWithItems:(NSArray <UIRootItem *>*)items {
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        _items = items;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.9f];
    [self addSubview:self.effectView];
    UIRootItem *item = _items.firstObject;
    item.selected = YES;
    _currentItem = item;
    for (UIRootItem *item in _items) {
        
        item.delegate = self;
        [self addSubview:item];
    }
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowOpacity = 0.3f;
    self.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.5f].CGColor;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.effectView.frame = self.bounds;
    CGFloat width = self.bounds.size.width;
    CGFloat itemWidth = width / (_items.count);
    CGFloat itemHeight = 49.0f;
    [_items enumerateObjectsUsingBlock:^(UIRootItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        obj.tag = idx;
        obj.frame = CGRectMake(idx * itemWidth, 0, itemWidth, itemHeight);
    }];
}

#pragma mark - ********* iTEM Delegate *********

- (void)itemDidSelectedWith:(UIRootItem *)item {
    
    if (item == _currentItem) {
        
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(itemDidSelectedFrom:toItem:)]) {
            
            [self.delegate itemDidSelectedFrom:_currentItem toItem:item];
        }
        _currentItem.selected = NO;
        item.selected = YES;
        _currentItem = item;
    }
    
}

#pragma mark - ********* LAZY LOAD *********

- (UIVisualEffectView *)effectView {
    
    if (!_effectView) {
        
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    }
    return _effectView;
}

@end
