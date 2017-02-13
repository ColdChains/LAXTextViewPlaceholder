//
//  LAXTextView.h
//  LAXTextViewPlaceHolder
//
//  Created by 刘翱翔 on 2017/1/7.
//  Copyright © 2017年 liuaoxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LAXTextView : UITextView

@property(nonatomic, assign) BOOL hasText2;
@property(nonatomic,copy) NSString *placeholder;  //文字
@property(nonatomic,strong) UIColor *placeholderColor; //文字颜色

@end
