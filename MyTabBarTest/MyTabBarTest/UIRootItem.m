//
//  UIRootItem.m
//  MyTabBarTest
//
//  Created by 阮皓 on 2018/4/8.
//  Copyright © 2018年 阮皓. All rights reserved.
//

#import "UIRootItem.h"

@interface UIRootItem () {
    
    UIImageView *_itemImage;
    UILabel *_itemTitle;
}

@end

@implementation UIRootItem

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat totalHeight = _itemTitle.bounds.size.height + _itemImage.bounds.size.height + 7.0f;
    CGFloat totalWidth = _itemImage.bounds.size.width;
    _itemImage.frame = CGRectMake((self.bounds.size.width - totalWidth) / 2.0f, (self.bounds.size.height - totalHeight) / 2.0f, totalWidth, _itemImage.bounds.size.height);
    _itemTitle.frame = CGRectMake(0, _itemImage.frame.origin.y + _itemImage.bounds.size.height + 7.0f, self.bounds.size.width, _itemTitle.bounds.size.height);
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    _itemImage = [[UIImageView alloc] initWithImage:image];
    [self addSubview:_itemImage];
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    _itemTitle = [[UILabel alloc] init];
    _itemTitle.font = [UIFont systemFontOfSize:10.0f];
    _itemTitle.textAlignment = NSTextAlignmentCenter;
    _itemTitle.textColor = [UIColor lightGrayColor];
    _itemTitle.text = title;
    [_itemTitle sizeToFit];
    [self addSubview:_itemTitle];
}

- (void)setSelected:(BOOL)selected {
    
    _selected = selected;
    [self selectedWith:selected];
}

- (void)selectedWith:(BOOL)selected {
    
    _itemImage.image = selected ? _selectedImage : _image;
    _itemTitle.textColor = selected ? [UIColor orangeColor] : [UIColor lightGrayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.delegate respondsToSelector:@selector(itemDidSelectedWith:)]) {
        
        [self.delegate itemDidSelectedWith:self];
    }
}

@end
