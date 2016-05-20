//
//  ViewController.m
//  02-NSURLConnection-异步
//
//  Created by qingyun on 16/4/28.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
//下载路径
#define KURL @"https://1.na.dl.wireshark.org/win64/Wireshark-win64-2.0.3.exe"


@interface ViewController ()<NSURLConnectionDataDelegate>
@property(strong,nonatomic)NSMutableData *mData;
@property(strong,nonatomic)NSString *sugFile;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)AsyncConnection:(id)sender {
    //1.创建URL
    NSURL *url=[NSURL URLWithString:KURL];
    
    //2.创建请求
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    
    //3.创建异步链接对象
  NSURLConnection *connection=  [NSURLConnection connectionWithRequest:request delegate:self];
    
    //4.启动
    [connection start];
    
    /*
    //3.创建同步链接
    NSHTTPURLResponse *response;
    NSError *error;
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSLog(@"=====%@",error);
        return;
    }
    
    if (response.statusCode==200) {
       //保存本地
        NSString *sugFileName=response.suggestedFilename;
        
        if ([data writeToFile:[NSString stringWithFormat:@"/Users/qingyun/Desktop/%@",sugFileName] atomically:YES]) {
            NSLog(@"=====保存成功");
        }
    }
    */
    
}

#pragma mark NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
  //只会调用一次  服务器响应的时候调用
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode==200) {
        NSLog(@"===count====ex====%lld",httpResponse.expectedContentLength);
        _sugFile=[NSString stringWithFormat:@"/Users/qingyun/Desktop/%@",httpResponse.suggestedFilename];
        
        //初始化容器
        _mData=[NSMutableData data];
    }
    
    
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
 //反复调用
    //接收数据
    NSLog(@"========receview===%ld",data.length);
    [_mData appendData:data];

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
 //完成下载
   //写在本地
    if ([_mData writeToFile:_sugFile atomically:YES]) {
        NSLog(@"========ok");
    }

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
 //连接失败的时候调用
    NSLog(@"=======链接失败====%@",error);
    //取消连接
    [connection cancel];
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
