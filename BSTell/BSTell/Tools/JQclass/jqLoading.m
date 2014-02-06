//
//  jqLoading.m
//  BBB
//
//  Created by  on 12-8-20.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//

#import "jqLoading.h"
#import <QuartzCore/QuartzCore.h>
@interface jqLoading ()
-(void)cancelRequest;
@end

@implementation jqLoading

-(id)initWithRequest:(ASIFormDataRequest *)req{
    return [self initWithRequest:req andMessage:nil];
}

-(id)initWithRequest:(ASIFormDataRequest *)req andMessage:(NSString *)message{
    self=[super initWithFrame:[[UIScreen mainScreen]bounds]];
    if (self) {
        UIView *selfview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 120)];
        selfview.backgroundColor = [UIColor clearColor];
        selfview.center =self.center;
        UIView *indicatorView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 90)];
//        CGAffineTransform transform = self.transform;
//        transform = CGAffineTransformRotate(transform,4.72);
//        self.transform = transform;
        UIInterfaceOrientation orient=[[UIApplication sharedApplication]statusBarOrientation];
        if (orient == UIDeviceOrientationLandscapeLeft) {
            selfview.transform=CGAffineTransformMakeRotation(M_PI_2);
        }
        else if (orient==UIDeviceOrientationLandscapeRight){
            selfview.transform=CGAffineTransformMakeRotation(-M_PI_2);
        }

        indicatorView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.7];
        indicatorView.layer.cornerRadius =15.0;
        indicatorView.autoresizesSubviews =NO;
        //        indicatorView.center =CGPointMake(512, 373);
       // indicatorView.center =self.center;
        indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.frame =CGRectMake(50, 12, 40, 40);
        [indicator startAnimating];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 140, 20)];
        label.font =[UIFont boldSystemFontOfSize:13.0];
        label.textAlignment =UITextAlignmentCenter;
        label.backgroundColor =[UIColor clearColor];
        if (message == nil) {
            label.text = @"数据加载中...";
        } else {
            label.text = message;
        }
        
        label.textColor =[UIColor whiteColor];
        [indicatorView addSubview:indicator];
        [indicatorView addSubview:label];
        [label release];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(125,-10, 30, 30)];
//        btn.center=CGPointMake(selfview.center.x+70, selfview.center.y-45);
        NSLog(@"");
        [btn addTarget:self action:@selector(cancelRequest) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        [selfview addSubview:indicatorView];
        [selfview addSubview:btn];
        [self addSubview:selfview];
        [selfview release];
        [btn release];
        [indicatorView release];
        request=req;
    }
    return self;
}
-(void)cancelRequest{
    if (request!=nil) {
        [request cancel];
    }
//    [indicator stopAnimating];
//    [self removeFromSuperview];
}
-(void)showInView:(UIView *)aview{
    [indicator startAnimating];
    [aview addSubview:self];
}
-(void)removeFromSuperview{
    [indicator stopAnimating];
    [super removeFromSuperview];
}

-(void)dealloc{
    
    [indicator release];
    [super dealloc];
}
@end
