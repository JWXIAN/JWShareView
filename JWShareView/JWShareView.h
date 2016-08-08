//
//  JWShareView.h
//  ShareViewDemo
//
//  Created by GJW on 16/8/8.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    QQ,
    Qzone,
    WeChat,
    Weibo
} shareItemType;

typedef void (^selectItemBlock)(NSInteger tag, NSString *title);

@interface JWShareItemButton : UIButton
@end

@interface JWShareView : UIView
- (void)addShareItems:(UIView *)superView  shareItems:(NSArray *)shareItems selectShareItem:(selectItemBlock)selectShareItem;
@end
