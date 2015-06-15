# 类似于微信首页添加好友“+”按钮弹出下拉菜单
#使用方法：
#1：把TJDropMenu文件夹加入工程中并#import "TJDropMenu.h"
#2：调用方法
 
    NSArray *imgArray = @[@"1",@"2",@"3",@"4"];//图片名称
    NSArray *titleArray = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收钱"]; //button标题
    UIImage *img = [UIImage imageNamed:@"5"];//下拉菜单底部view的背景图
    
    [[TJDropMenu shareInstance] showDropMenuBackGround:img andImgArray:imgArray andTitleArray:titleArray andCompleteHandler:^(NSInteger selectIndex, NSString *selectTitle) {
        
        _lblContent.text = [NSString stringWithFormat:@"按钮tag=%ld,按钮标题%@",selectIndex,selectTitle];
    }];
![Image](https://github.com/KBvsMJ/WechatDropMenuDemo/blob/master/demogif/1.gif)
