//
//  RACViewController.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/7.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveCocoa.h>

@interface RACViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation RACViewController
- (IBAction)click:(id)sender {
    
    NSLog(@"按钮被点击了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"RAC简单例子";
#pragma mark 示例 1 组合信号模拟登陆注册
    // 这里的reduceBlock里面的参数是和第一个数组里面个数是对应的
    RACSignal *combineSignal = [RACSignal combineLatest:@[self.textFieldAccount.rac_textSignal,self.textFieldPassword.rac_textSignal] reduce:^id(NSString *account,NSString *passward){
        NSLog(@"account-->%@,password--->%@",account,passward);
        return @(account.length && passward.length);
    }];
    // 方法1 常规自己注册订阅
//    @weakify(self);
//    [combineSignal subscribeNext:^(id x) {
//        @strongify(self)
//        self.button.enabled = [x boolValue];
//    }];
    
    // 方法2 RAC自带的宏进行订阅
    RAC(self.button,enabled) = combineSignal;
    
    
#pragma mark - 示例 2 异步快速遍历数组或字典
    
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    for (id obj in arr) {
        NSLog(@"%@,%@",obj,[NSThread currentThread]);
    }
    
    
    [arr.rac_sequence.signal subscribeNext:^(id x) {
       NSLog(@"%@,%@",x,[NSThread currentThread]);
    } error:^(NSError *error) {
        NSLog(@"%@",error);
    } completed:^{
        NSLog(@"遍历完成了,%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict = @{@"key1":@"111",@"key2":@"222",@"key3":@"333",@"key4":@[@"M",@"K",@"J"]};
           
            [dict.rac_sequence.signal subscribeNext:^(id x) {
                
                    
//                 RACTupleUnpack宏：专门用来解析元组
//                 RACTupleUnpack 等式右边：需要解析的元组
//                 宏的参数，填解析的什么样数据 元组里面有几个值，宏的参数就必须填几个
                RACTupleUnpack(id key,id value) = x;
                NSLog(@"%@,%@",key,value);
              
            } completed:^{
                NSLog(@"字典解析完成");
            }];
        });
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
