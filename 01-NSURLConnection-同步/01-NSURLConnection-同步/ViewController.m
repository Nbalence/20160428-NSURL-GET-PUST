//
//  ViewController.m
//  01-NSURLConnection-同步
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)requestConnection:(UIButton *)sender {
    //1.创建URL
    NSURL *url=[NSURL URLWithString:@"http://www.csdn.net/"];
    //2.创建请求对象
    NSURLRequest  *request=[NSURLRequest requestWithURL:url];
    //3.发起同步请求
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        //请求失败
        NSLog(@"=========%@",error);
        return;
    }
    if (response.statusCode==200) {
        NSLog(@"====ok");
        NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"=======%@",str);
        //写入操作
     BOOL isResult=[str writeToFile:@"/Users/qingyun/Desktop/csdn.html" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        if (isResult) {
            NSLog(@"保存成功");
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
