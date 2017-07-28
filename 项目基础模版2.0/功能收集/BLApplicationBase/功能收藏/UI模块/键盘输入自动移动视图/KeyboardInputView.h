//
//  KeyboardInputView.h
//  DaJiShi
//
//  Created by camore on 16/10/12.
//  Copyright © 2016年 BLapple. All rights reserved.
//

#import "BLViews.h"

@class KeyboardInputView;

@protocol KeyboardInputViewDelegate <NSObject>

/** 切换键盘输入按钮*/
-(void)KeyboardInputView:(KeyboardInputView*)View ChangeStateWithContent:(NSString*)content;

/** 确认 内容*/
-(void)KeyboardInputView:(KeyboardInputView*)View ConFirmContent:(NSString*)content;

@end

@interface KeyboardInputView : BLView

@property ( nonatomic , weak ) id <KeyboardInputViewDelegate> KeyboardInputViewDelegate;



/** 默认代理， 展示内容*/
+(instancetype)keyBoardInputCustomWithDelegate:(id<KeyboardInputViewDelegate>)KeyboardInputViewDelegate content:(NSString*)content;

/** 设置当前内容*/
-(void)setCurrentText:(NSString*)content;
@end
