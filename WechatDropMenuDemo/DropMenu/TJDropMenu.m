//
//  TJDropMenu.m
//  WechatDropMenuDemo
//
//  Created by MJ on 15/6/13.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "TJDropMenu.h"
#define kTopPadding 74.f  //底部view的上边间距
#define kRightPadding 5.f  //底部view右边间距
#define kContainerViewSize   CGSizeMake(120.f, 160.f)  //底部的宽高
#define kLineViewPadding 5.f  //白色线条view的左右边间距
@interface TJDropMenu ()
{
    UIView *containerView;  //底部view
    NSArray *selectTitleArray; //保存按钮的标题
}
@end
@implementation TJDropMenu
+ (TJDropMenu *)shareInstance
{
    static TJDropMenu *myInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        myInstance = [[TJDropMenu alloc]init];
        
        
    });
    return myInstance;
}
- (instancetype)init
{
    if (self = [super init]) {
        selectTitleArray = [NSArray array];
        [self setUp];
        
    }
    return self;
}
- (void)setUp
{
    
    self.backgroundColor                                    = [UIColor clearColor];
    self.frame                                              = [UIScreen mainScreen].bounds;
    //添加手势
    UITapGestureRecognizer *tapBackGround=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView:)];
    [self addGestureRecognizer:tapBackGround];
    NSDictionary *dic_Constraint = @{
                                      @"width":@(kContainerViewSize.width),
                                      @"height":@(kContainerViewSize.height),
                                      @"top":@(kTopPadding),
                                      @"rightMargin":@(kRightPadding)
                                     };
    /**添加一个contentview*/
    containerView                                           = [[UIView alloc]init];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.layer.masksToBounds                       = YES;
    containerView.layer.cornerRadius                        = 2.0;
    [self addSubview:containerView];
    /**contentview水平方向上添加约束*/
    NSArray *containerView_H                                = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[containerView(width)]-rightMargin-|"
                                                                options:0 metrics:dic_Constraint views:NSDictionaryOfVariableBindings(containerView)];
    /**contentview垂直方向上添加约束*/
    NSArray *containerView_V                                = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[containerView(height)]" options:0 metrics:dic_Constraint views:NSDictionaryOfVariableBindings(containerView)];

    [self addConstraints:containerView_H];
    [self addConstraints:containerView_V];
    
    
    
    

}
- (void)showDropMenuBackGround:(UIImage *)backGroundImage andImgArray:(NSArray *)imgArray andTitleArray:(NSArray *)titleArray andCompleteHandler:(DidSelectIndexHandler)handler;
{
    NSAssert(backGroundImage!=nil, @"backGroundImage is not null");
    NSAssert(imgArray.count!=0, @"imgArray is not null");
    NSAssert(titleArray.count!=0, @"titleArray is not null");
    myHandler                                                = handler;
    selectTitleArray                                         = titleArray;
    containerView.layer.contents                             = (__bridge id)backGroundImage.CGImage;
  /*******************************************第一行***************************************/
    UIButton *firstBtn                                       = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn setTitle:titleArray[0] forState:UIControlStateNormal];
    firstBtn.titleLabel.font                                 = [UIFont systemFontOfSize:14.f];
    firstBtn.titleLabel.textAlignment                        = NSTextAlignmentCenter;
    /**设置title标题位置*/
    firstBtn.titleEdgeInsets                                 = UIEdgeInsetsMake(0, 0, 0, -5);
     /**设置button上图片位置*/
    UIImage *firstImg                                        = [UIImage imageNamed:imgArray[0]];
    firstBtn.imageEdgeInsets                                 = UIEdgeInsetsMake(0, 0, 0, firstImg.size.width);
    [firstBtn setImage:firstImg forState:UIControlStateNormal];
    firstBtn.translatesAutoresizingMaskIntoConstraints       = NO;
    firstBtn.tag                                             = 1;
    [containerView addSubview:firstBtn];
    NSDictionary *btn_Constraint                             = @{
                                     @"btnHeight":@(kContainerViewSize.height/4.f),
                                     @"linePadding":@(kLineViewPadding)
                                     };

    NSArray *firstBtn_H                                      = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[firstBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(firstBtn)];

    NSArray *firstBtn_V                                      = [ NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:|-0-[firstBtn(btnHeight)]" options:0
                                                                   metrics:btn_Constraint views:NSDictionaryOfVariableBindings(firstBtn)];
    [containerView addConstraints:firstBtn_H];
    [containerView addConstraints:firstBtn_V];
    /**button底部线条*/
    UIView *firstLineView                                    = [[UIView alloc]init];
    firstLineView.translatesAutoresizingMaskIntoConstraints  = NO;
    firstLineView.backgroundColor                            = [UIColor whiteColor];
    [firstBtn addSubview:firstLineView];
    NSArray *firstLine_H                                     = [ NSLayoutConstraint
                            constraintsWithVisualFormat:@"H:|-linePadding-[firstLineView]-linePadding-|"
                            options:0
                            metrics:btn_Constraint
                            views:NSDictionaryOfVariableBindings(firstLineView)];

    NSArray *firstLine_V                                     = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstLineView(1)]-0-|" options:0 metrics:btn_Constraint views:NSDictionaryOfVariableBindings(firstLineView)];
    [firstBtn addConstraints:firstLine_H];
    [firstBtn addConstraints:firstLine_V];


    /*******************************************第二行***************************************/


    UIButton *secondBtn                                      = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setTitle:titleArray[1] forState:UIControlStateNormal];
    secondBtn.titleLabel.font                                = [UIFont systemFontOfSize:14.f];
    secondBtn.titleLabel.textAlignment                       = NSTextAlignmentCenter;
    secondBtn.translatesAutoresizingMaskIntoConstraints      = NO;
    /**设置title标题位置*/
    secondBtn.titleEdgeInsets                                = UIEdgeInsetsMake(0, 0, 0, -5);
    /**设置button上图片位置*/
    UIImage *secondImg                                       = [UIImage imageNamed:imgArray[1]];
    secondBtn.imageEdgeInsets                                = UIEdgeInsetsMake(0, 0, 0, secondImg.size.width);
    [secondBtn setImage:secondImg forState:UIControlStateNormal];
    secondBtn.tag                                            = 2;
    [containerView addSubview:secondBtn];
    NSArray *secondBtn_H                                     = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[secondBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(secondBtn)];

    NSArray *secondBtn_V                                     = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[firstBtn(btnHeight)]-0-[secondBtn(btnHeight)]" options:0 metrics:btn_Constraint views:NSDictionaryOfVariableBindings(secondBtn,firstBtn)];
    [containerView addConstraints:secondBtn_H];
    [containerView addConstraints:secondBtn_V];

    /**button底部线条*/
    UIView *secondLineView                                   = [[UIView alloc]init];
    secondLineView.translatesAutoresizingMaskIntoConstraints = NO;
    secondLineView.backgroundColor                           = [UIColor whiteColor];
    [secondBtn addSubview:secondLineView];
    NSArray *secondLine_H                                    = [ NSLayoutConstraint
                            constraintsWithVisualFormat:@"H:|-linePadding-[secondLineView]-linePadding-|"
                            options:0
                            metrics:btn_Constraint
                            views:NSDictionaryOfVariableBindings(secondLineView)];

    NSArray *secondLine_V                                    = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[secondLineView(1)]-0-|" options:0 metrics:btn_Constraint views:NSDictionaryOfVariableBindings(secondLineView)];
    [secondBtn addConstraints:secondLine_H];
    [secondBtn addConstraints:secondLine_V];

     /*******************************************第三行***************************************/

    UIButton *thirdBtn                                       = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:titleArray[2] forState:UIControlStateNormal];
    thirdBtn.titleLabel.font                                 = [UIFont systemFontOfSize:14.f];
    thirdBtn.titleLabel.textAlignment                        = NSTextAlignmentCenter;
    thirdBtn.translatesAutoresizingMaskIntoConstraints       = NO;
    /**设置title标题位置*/
    thirdBtn.titleEdgeInsets                                 = UIEdgeInsetsMake(0, 0, 0, -5);
    /**设置button上图片位置*/
    UIImage *thirdImg                                        = [UIImage imageNamed:imgArray[2]];
    thirdBtn.imageEdgeInsets                                 = UIEdgeInsetsMake(0, 0, 0, thirdImg.size.width);
    [thirdBtn setImage:thirdImg forState:UIControlStateNormal];
    thirdBtn.tag                                             = 3;
    [containerView addSubview:thirdBtn];
    NSArray *thirdBtn_H                                      = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[thirdBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(thirdBtn)];
    NSArray *thirdBtn_V                                      = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[firstBtn(btnHeight)]-0-[secondBtn(btnHeight)]-0-[thirdBtn(btnHeight)]" options:0 metrics:btn_Constraint views:NSDictionaryOfVariableBindings(secondBtn,firstBtn,thirdBtn)];
    [containerView addConstraints:thirdBtn_H];
    [containerView addConstraints:thirdBtn_V];

    /**button底部线条*/
    UIView *thirdLineView                                    = [[UIView alloc]init];
    thirdLineView.translatesAutoresizingMaskIntoConstraints  = NO;
    thirdLineView.backgroundColor                            = [UIColor whiteColor];
    [thirdBtn addSubview:thirdLineView];
    NSArray *thirdLineView_H                                 = [ NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:|-linePadding-[thirdLineView]-linePadding-|"
                             options:0
                             metrics:btn_Constraint
                             views:NSDictionaryOfVariableBindings(thirdLineView)];
    NSArray *thirdLineView_V                                 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[thirdLineView(1)]-0-|" options:0 metrics:btn_Constraint views:NSDictionaryOfVariableBindings(thirdLineView)];
    [thirdBtn addConstraints:thirdLineView_H];
    [thirdBtn addConstraints:thirdLineView_V];

    /*******************************************第四行***************************************/

    UIButton *fourBtn                                        = [UIButton buttonWithType:UIButtonTypeCustom];
    [fourBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [fourBtn setTitle:titleArray[3] forState:UIControlStateNormal];
    fourBtn.titleLabel.font                                  = [UIFont systemFontOfSize:14.f];
    fourBtn.titleLabel.textAlignment                         = NSTextAlignmentCenter;
    fourBtn.translatesAutoresizingMaskIntoConstraints        = NO;
    /**设置title标题位置*/
    fourBtn.titleEdgeInsets                                  = UIEdgeInsetsMake(0, 0, 0, -5);
    /**设置button上图片位置*/
    UIImage *fourImg                                         = [UIImage imageNamed:imgArray[3]];
    fourBtn.imageEdgeInsets                                  = UIEdgeInsetsMake(0, 0, 0, fourImg.size.width);
    [fourBtn setImage:fourImg forState:UIControlStateNormal];
    fourBtn.tag                                              = 4;
    [containerView addSubview:fourBtn];
    NSArray *fourBtn_H                                       = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[fourBtn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fourBtn)];
    NSArray *fourBtn_V                                       = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[fourBtn(btnHeight)]-0-|" options:0 metrics:btn_Constraint views:NSDictionaryOfVariableBindings(fourBtn)];
    [containerView addConstraints:fourBtn_H];
    [containerView addConstraints:fourBtn_V];
    [self show];
}
- (void)btnAction:(UIButton *)sender
{
    if (myHandler) {
        myHandler(sender.tag,sender.titleLabel.text);
    }
    [self dismiss];
}
/**
 * 点击区域不在显示的containerview上，则移除view
 *
 *  @param tapGesture
 */
-(void)dismissView:(UITapGestureRecognizer *)tapGesture
{
    CGPoint point = [tapGesture locationInView:self];
    if(!CGRectContainsPoint(containerView.frame, point))
    {
        [self dismiss];
    }
}
/**
 *  移除view
 */
-(void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        containerView.alpha = 0;
        containerView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/**
 *  显示view
 */
- (void)show
{
    UIWindow *keyWindow=[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    containerView.alpha=0;
    containerView.transform=CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.3f animations:^{
        containerView.alpha = 0.75;
        containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
}

@end
