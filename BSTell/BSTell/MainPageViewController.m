//
//  MainPageViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MainPageViewController.h"

#import "NoteListViewController.h"

#define kItemLeftPendingX    6.f

#define kItemPendingY   9.f

static  NSString* kTitleTextArray[] = {@"咨讯中心",@"网站公告",@"交易公告",@"登录",@"到货确认"};

@interface MainPageViewController ()

@end

@implementation MainPageViewController

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
	// Do any additional setup after loading the view.
    
    [self setHiddenLeftBtn:YES];
    //for logo
    UIImageWithFileName(UIImage* image, @"logo.png");
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:logoImageView];
    SafeRelease(logoImageView);
    
    logoImageView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
    logoImageView.center = CGPointMake(kDeviceScreenWidth/kScale, 50.f);
    
    
    CGFloat currY = 50.f,startX = 0.f,startY = 0.f;
    currY = currY+160.f;
    
    int i = 0,index = 0;
    
    UIButton *item = nil;
    UIButton *noteCenterBtn = [UIComUtil createButtonWithNormalBGImageName:@"button-1.png" withHightBGImageName:@"button-1.png" withTitle:kTitleTextArray[i] withTag:0];
    [self.view addSubview:noteCenterBtn];
    noteCenterBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    noteCenterBtn.frame = CGRectMake(kItemLeftPendingX, currY,kDeviceScreenWidth-2*kItemLeftPendingX, noteCenterBtn.frame.size.height);
    
    noteCenterBtn.contentEdgeInsets = UIEdgeInsetsMake(0.f,-80.f, 0.f, 0.f);
    SafeRelease(noteCenterBtn);
    [noteCenterBtn addTarget:self action:@selector(pressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    startY = currY+noteCenterBtn.frame.size.height+kItemPendingY;
    for(int i = 0;i<2;i++){
        startX = kItemLeftPendingX;
        //startY = startY+kTopCellPendingY;
        for(int j=0;j<2;j++){
            
            index = 2*i+j+2;
            NSString *btnImageName = [NSString stringWithFormat:@"button-%d.png",index];
            item = [UIComUtil createButtonWithNormalBGImageName:btnImageName withHightBGImageName:btnImageName withTitle:kTitleTextArray[index-1] withTag:index];
            item.frame = CGRectMake(startX, startY,item.frame.size.width, item.frame.size.height);
            item.titleLabel.textAlignment = NSTextAlignmentLeft;
            item.contentEdgeInsets = UIEdgeInsetsMake(0.f,80.f, 0.f, 0.f);
            
            [self.view addSubview:item];
            [item addTarget:self action:@selector(pressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            startX = startX+item.frame.size.width;
        }
        startY = startY+ item.frame.size.height+kItemPendingY;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark button action
- (void)pressButtonAction:(id)sender{
    switch ([sender tag]) {
        case 1:{
           
            
            
        }
            break;
        case 2:{
        
            NoteListViewController *noteListVc = [[NoteListViewController alloc]init];
            [noteListVc setNavgationBarTitle:[sender titleLabel].text];
            [self.navigationController pushViewController:noteListVc animated:YES];
            SafeRelease(noteListVc);
            
        }
            break;
        case 3:{
            NoteListViewController *noteListVc = [[NoteListViewController alloc]init];
            noteListVc.type = 1;
            [noteListVc setNavgationBarTitle:[sender titleLabel].text];
            [self.navigationController pushViewController:noteListVc animated:YES];
            SafeRelease(noteListVc);
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
        default:
            break;
    }
}
@end
