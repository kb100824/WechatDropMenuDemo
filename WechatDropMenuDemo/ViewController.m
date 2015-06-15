//
//  ViewController.m
//  WechatDropMenuDemo
//
//  Created by MJ on 15/6/13.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "ViewController.h"
#import "TJDropMenu.h"
@interface ViewController ()
{
    UIBarButtonItem *rightBaritem;
}
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rightBaritem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(showDropview)];
    self.navigationItem.rightBarButtonItem = rightBaritem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDropview
{
    NSArray *imgArray = @[@"1",@"2",@"3",@"4"];
    NSArray *titleArray = @[@"发起群聊",@"添加朋友",@"扫一扫",@"收钱"];
    UIImage *img = [UIImage imageNamed:@"5"];
    
    [[TJDropMenu shareInstance] showDropMenuBackGround:img andImgArray:imgArray andTitleArray:titleArray andCompleteHandler:^(NSInteger selectIndex, NSString *selectTitle) {
        
        _lblContent.text = [NSString stringWithFormat:@"按钮tag=%ld,按钮标题%@",selectIndex,selectTitle];
    }];

}
@end
