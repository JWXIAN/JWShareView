//
//  JWShareView.m
//  ShareViewDemo
//
//  Created by GJW on 16/8/8.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "JWShareView.h"

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kShareItemNum 4

#define kBtnW 60
#define kBtnH 60
#define kMarginX 15
#define kMarginY 15
#define kFirst 10

#define kTitlePrecent 0.4
#define kImageViewWH 40

#define RGB(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface JWShareItemButton()
@end
@implementation JWShareItemButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:RGB(40, 40, 40) forState:UIControlStateNormal];
        self.imageView.layer.cornerRadius = kImageViewWH * 0.5;
    }
    return self;
}
#pragma mark 调整文字的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height * kTitlePrecent;
    CGFloat titleX = 2;
    CGFloat titleY = self.frame.size.height * (1 - kTitlePrecent) + 7;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
#pragma mark 调整图片的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = kImageViewWH;
    CGFloat imageH = kImageViewWH;
    CGFloat imageX = (self.frame.size.width - kImageViewWH) * 0.5;
    CGFloat imageY = 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end


@interface JWShareView()
@property (nonatomic, strong) NSArray *sharItems;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, copy) void(^btnBlock)(NSInteger tag, NSString *title);
@end
@implementation JWShareView
- (void)addShareItems:(UIView *)superView  shareItems:(NSArray *)shareItems selectShareItem:(selectItemBlock)selectShareItem{
    if (shareItems == nil || shareItems.count < 1) return;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addBackgroundView:superView];
    
    [shareItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj[@"name"];
        NSString *icon = obj[@"icon"];
        JWShareItemButton *btn = [JWShareItemButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat marginX = (self.frame.size.width - kShareItemNum * kBtnW) / (kShareItemNum + 1);
        NSInteger col = idx % kShareItemNum;
        NSInteger row = idx / kShareItemNum;
        CGFloat btnX = marginX + (marginX + kBtnW) * col;
        CGFloat btnY = kFirst + (kMarginY + kBtnH) * row;
        btn.frame = CGRectMake(btnX, btnY, kBtnW, kBtnH);
        [self addSubview:btn];
    }];
    //计算frame
    [superView addSubview:self];
    NSUInteger row = (shareItems.count - 1) / kShareItemNum;
    CGFloat height = kFirst + 50 + (row +1) * (kBtnH + kMarginY);
    CGFloat originY = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, originY, 0, height);
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sF = self.frame;
        sF.origin.y = [UIScreen mainScreen].bounds.size.height - sF.size.height;
        self.frame = sF;
    }];
    
    //取消
    UIButton *canleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canleBtn.frame = CGRectMake(0, self.frame.size.height-44, self.frame.size.width, 44);
    [canleBtn setTitle:@"取 消" forState:UIControlStateNormal];
    canleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [canleBtn setBackgroundColor:[UIColor whiteColor]];
    [canleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [canleBtn addTarget:self action:@selector(cancleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canleBtn];
    
    self.btnBlock = ^(NSInteger tag, NSString *title){
        if(selectShareItem) selectShareItem(tag, title);
    };
//    //分割线
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(canleBtn.frame), kScreenWidth, 0.5)];
//    line.backgroundColor = RGB(180, 180, 180);
//    [self addSubview:line];
}
- (void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    if (frame.size.height <= 0) {
        frame.size.height = 00;
    }
    frame.origin.x = 0;
    [super setFrame:frame];
}
- (void)addBackgroundView:(UIView *)superView{
    _backgroundView = [[UIView alloc] initWithFrame:superView.bounds];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleButtonAction)];
    [_backgroundView addGestureRecognizer:tap];
    [superView addSubview:_backgroundView];
}
- (void)cancleButtonAction{
    [_backgroundView removeFromSuperview];
    _backgroundView = nil;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect sf = self.frame;
        sf.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = sf;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)btnClick:(UIButton *)sender{
    if(_btnBlock) _btnBlock(sender.tag, sender.titleLabel.text);
}
@end
