//
//  ViewController.m
//  LAXTextViewPlaceHolder
//
//  Created by 刘翱翔 on 2017/1/7.
//  Copyright © 2017年 liuaoxiang. All rights reserved.
//

#import "ViewController.h"
#import "LAXTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LAXTextView *textView = [[LAXTextView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    textView.backgroundColor = [UIColor orangeColor];
    textView.placeholder = @"你好 请输入";
//    textView.placeholderColor = [UIColor greenColor];
//    textView.font = [UIFont systemFontOfSize:22];
//    self.view.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
