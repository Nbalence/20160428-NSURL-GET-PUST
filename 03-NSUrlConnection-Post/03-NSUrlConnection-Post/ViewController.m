//
//  ViewController.m
//  03-NSUrlConnection-Post
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#define Kurl @"http://afnetworking.sinaapp.com/persons.json"

@interface ViewController ()
@end

@implementation ViewController

#pragma mark postAction
-(IBAction)postAction:(id)sender {
   //1.创建URL
    NSURL *url=[NSURL URLWithString:Kurl];
    
  //2.创建Request
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方法
    request.HTTPMethod=@"POST";
    //2.2设置请求参数
    request.HTTPBody=[@"person_type=student"dataUsingEncoding:NSUTF8StringEncoding];
    
  //3.创建连接对象
    NSHTTPURLResponse *response;
    NSError *error;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"=======%@",error);
        return;
    }
    
    if (response.statusCode==200) {
        NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"========%@",str);

    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
