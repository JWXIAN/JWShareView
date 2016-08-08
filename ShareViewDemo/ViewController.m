//
//  ViewController.m
//  ShareViewDemo
//
//  Created by GJW on 16/8/8.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "ViewController.h"
#import "JWShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.bounds];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"点我";
    [self.view addSubview:lab];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                              @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                              @{@"name":@"QQ",@"icon":@"sns_icon_4"},
                              @{@"name":@"微信",@"icon":@"sns_icon_7"},
                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
                              @{@"name":@"微信收藏",@"icon":@"sns_icon_9"}];
    JWShareView *shareView = [[JWShareView alloc] init];
    [shareView addShareItems:self.view shareItems:contentArray selectShareItem:^(NSInteger tag, NSString *title) {
        NSLog(@"%ld --- %@", tag, title);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
