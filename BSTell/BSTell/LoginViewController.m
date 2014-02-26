//
//  LoginViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-25.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setHiddenLeftBtn:NO];
    //for logo
    UIImageWithFileName(UIImage* image, @"logo.png");
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:logoImageView];
    SafeRelease(logoImageView);
    
    logoImageView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
    logoImageView.center = CGPointMake(kDeviceScreenWidth/kScale, 20.f);
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
