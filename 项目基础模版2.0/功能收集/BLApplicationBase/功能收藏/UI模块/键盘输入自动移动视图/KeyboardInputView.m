//
//  KeyboardInputView.m
//  DaJiShi
//
//  Created by camore on 16/10/12.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "KeyboardInputView.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface KeyboardInputView ()<UITextFieldDelegate>
{
    /***************数据控制***************/
    
    /***************视图***************/
    
    /** 事宜键盘输入框*/
    BLTextField     *   textfield_shiyi_jianpan;
    
}
@end

@implementation KeyboardInputView





#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(instancetype)keyBoardInputCustomWithDelegate:(id<KeyboardInputViewDelegate>)KeyboardInputViewDelegate content:(NSString*)content
{
    KeyboardInputView * view = [[KeyboardInputView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith, BiLiH(54)) content:content ];
    view.KeyboardInputViewDelegate = KeyboardInputViewDelegate;
    return view;

}

-(instancetype)initWithFrame:(CGRect)frame content:(NSString * )content
{
    self = [super initWithFrame:frame];

    if(self)
    {
        [self chuShiHua];
        [self setUpViews];
        textfield_shiyi_jianpan.text = content;
        
    }
    return self;
}
-(void)chuShiHua
{

}

-(void)setUpViews
{

    [self createAllView];

}
#pragma mark- ********************调用事件********************
//外界调用 或者调用外界的事件
/** 报告确定*/
-(void)reportConfirmContent
{
    [textfield_shiyi_jianpan resignFirstResponder];
    
    if([self.KeyboardInputViewDelegate respondsToSelector:@selector(KeyboardInputView:ConFirmContent:)])
    {
        [self.KeyboardInputViewDelegate KeyboardInputView:self ConFirmContent:textfield_shiyi_jianpan.text];
    }
}

/** 切换按钮*/
-(void)reportQieHuan
{
    [textfield_shiyi_jianpan resignFirstResponder];

    if([self.KeyboardInputViewDelegate respondsToSelector:@selector(KeyboardInputView:ChangeStateWithContent:)])
    {
        [self.KeyboardInputViewDelegate KeyboardInputView:self ChangeStateWithContent:textfield_shiyi_jianpan.text];
    }
}

/** 设置当前内容*/
-(void)setCurrentText:(NSString*)content
{
    textfield_shiyi_jianpan.text = content;
    [textfield_shiyi_jianpan becomeFirstResponder];
}
#pragma mark- ********************点击事件********************
/** 切换按钮点击*/
-(void)qieHuanClick
{
    [self reportQieHuan];
}
/** 清空按钮点击*/
-(void)clearButtonClick
{
    textfield_shiyi_jianpan.text = @"";
}
#pragma mark- ********************继承方法********************
#pragma mark- ********************代理方法********************
#pragma mark - 键盘发生改变执行
- (void)keyboardWillChange:(NSNotification *)note {
    
    NSDictionary *userInfo = note.userInfo;
    //移动的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //移动到的坐标
    CGRect keyFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    // 键盘高度
//    CGFloat jianPanGao = keyFrame.size.height;
    
    // 如果响应的是备注textfield进行处理
    if ([textfield_shiyi_jianpan isFirstResponder]) {
        
        
        
        [UIView animateWithDuration:duration animations:^{
            
            self.bottom = keyFrame.origin.y;
        }];
        
        
    }
    
}

#pragma mark- UITextFieldDelegate <NSObject>

//@optional
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0); // if implemented, called in place of textFieldDidEndEditing:
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == textfield_shiyi_jianpan)
    {
        [self reportConfirmContent];

        
    }
    return YES;
}
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************数据操作********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{
    [self createJianPanInput];
}

/** 创建键盘输入视图*/
-(void )createJianPanInput
{
   
    {
        BLView * view_back  = self;
        view_back.backgroundColor = color_second_view_white;
        
        
 
        
        
        int margin_left_right = BiLiH(7);
        NSInteger margin_top_bottom = BiLiH(7);
        /** 键盘按钮*/
        UIButton * button_keyboar = [MyControl createButtonWithFrame:CGRectMake(0, margin_top_bottom, BiLiH(44), BiLiH(44)) target:self method:@selector(qieHuanClick)];
        button_keyboar.tag = 6;
        button_keyboar.centerY = view_back.height/2;
        [button_keyboar setImage:[MyControl imageFileWithName:@"taskInput_luYin_start.png"] forState:UIControlStateNormal];
        button_keyboar.imageEdgeInsets = UIEdgeInsetsMake(BiLiH(7), BiLiH(7), BiLiH(7), BiLiH(7));
        [view_back addSubview:button_keyboar];
        
        
        //顶部输入框
        BLView * view_textfieldBack = [MyControl createTextFieldWithFrame:CGRectMake(button_keyboar.right, margin_top_bottom, view_back.width-margin_left_right-button_keyboar.right, BiLiH(41)) bianju:UIEdgeInsetsMake(0, BiLiH(9), 0, BiLiH(9)) placeHolder:@""];
        [view_textfieldBack setCornerRadius:4];
        view_textfieldBack.tag = 100;
        view_textfieldBack.backgroundColor = COLOR(232, 232, 234);
        
        
        textfield_shiyi_jianpan = [view_textfieldBack viewWithTag:1];
        textfield_shiyi_jianpan.textColor       = color_text_main_black;
        textfield_shiyi_jianpan.font            = [UIFont systemFontOfSize:text_size_fuzhu];
        textfield_shiyi_jianpan.userInteractionEnabled = YES;
        textfield_shiyi_jianpan.tag = 1;
        textfield_shiyi_jianpan.returnKeyType = UIReturnKeyDone;
        textfield_shiyi_jianpan.placeholder = @"输入的文字";
        textfield_shiyi_jianpan.delegate = self;
        [view_back addSubview:view_textfieldBack];
        
        
        BLButton * clearButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, view_textfieldBack.height,view_textfieldBack.height) image:[UIImage imageNamed:@"task_item_delete.png"] selectedImage:nil target:self method:@selector(clearButtonClick)];
        CGFloat sep = (view_textfieldBack.height-BiLiH(21))/2;
        clearButton.tag = 7;
        clearButton.imageEdgeInsets = UIEdgeInsetsMake(sep, sep, sep, sep);
        [textfield_shiyi_jianpan setCleaerButton:clearButton];
        
        
        // top sep
        [MyControl addSepViewWithView:view_back location:0  downOrTop:YES];
        
     
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    
    

}

#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
#pragma mark- ********************跳转其他页面********************

@end
