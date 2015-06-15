//
//  TJDropMenu.h
//  WechatDropMenuDemo
//
//  Created by MJ on 15/6/13.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^DidSelectIndexHandler)(NSInteger selectIndex,NSString*selectTitle);
@interface TJDropMenu : UIView
{
    DidSelectIndexHandler myHandler;
}
/**
 * 类似于微信添加“+”好友下拉弹出的菜单
 *
 *  @return 单列对象
 */
+ (TJDropMenu *)shareInstance;
/**
 *  类似于微信添加好友下拉弹出的菜单
 *
 *  @param backGroundImage 底部view背景图
 *  @param imgArray        保存button上的图片
 *  @param titleArray      保存button的标题
 *  @param handler         回调用于传递button的tag和button标题
 */
- (void)showDropMenuBackGround:(UIImage *)backGroundImage andImgArray:(NSArray *)imgArray andTitleArray:(NSArray *)titleArray andCompleteHandler:(DidSelectIndexHandler)handler;



@end
