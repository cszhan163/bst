//
//  MainPageViewController.m
//  BSTell
//
//  Created by cszhan on 14-1-30.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MainPageViewController.h"

#import "NoteListViewController.h"

#import "OrderListViewController.h"

#import "BidMainViewController.h"

#import "MsgMainViewController.h"

#import "CardShopLoginViewController.h"

#import "BidAdjustAlertView.h"

#define kItemLeftPendingX    6.f

#define kItemPendingY   2.f

static  NSString* kTitleTextArray[] = {@"资讯中心",@"网站公告",@"交易公告",@"登录",@"到货确认"};

@interface MainPageViewController (){
    UIButton *loginBtn;
    BOOL isLogin;
}
@end

@implementation MainPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        /*
        [ZCSNotficationMgr addObserver:self call:@selector(didUserLogin:) msgName:kUserDidLoginOk];
        [ZCSNotficationMgr addObserver:self call:@selector(needLoginUser:) msgName:kNeedUserLoginMSG];
        [ZCSNotficationMgr addObserver:self call:@selector(didUserLogout:) msgName:kUserDidLogOut];
        */
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([AppSetting getLoginUserId]&&![[AppSetting getLoginUserId]isEqualToString:@""] && !isLogin){
        //[ZCSNotficationMgr postMSG: obj:<#(id)#>]
        
        [self didUserLogin:nil];
    }
    
}
- (void)test{

    BidAdjustAlertView *bidAdjustView = [[BidAdjustAlertView alloc]initWithFrame:CGRectMake(0.f, 0.f,300.f,280.f) withHeadTitle:@""];
    bidAdjustView.stepPrice = 100.f;
    bidAdjustView.basePrice = 200.f;
    //bidAdjustView.priceModeString =
    [bidAdjustView setHeadTitle:@"出价确认"];
    [bidAdjustView show];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    mainView.topBarView.backgroundColor = [UIColor clearColor];
    
	// Do any additional setup after loading the view.
    
    [self setHiddenLeftBtn:YES];
    [self setHiddenRightBtn:YES];
    //for logo
    UIImageWithFileName(UIImage* image, @"logo.png");
    
    UIControl  *logoImageView = [[UIControl alloc]initWithFrame:CGRectZero];
    [self.view addSubview:logoImageView];
    [logoImageView addTarget:self action:@selector(gotoMainSite:) forControlEvents:UIControlEventTouchUpInside];
    SafeRelease(logoImageView);
    logoImageView.layer.contents = (id)image.CGImage;
    logoImageView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
    logoImageView.center = CGPointMake(kDeviceScreenWidth/kScale, 20.f);
    
    
    UIImageWithFileName(image, @"image.jpg");
    CGFloat currY = logoImageView.frame.size.height+5.f,startX = 0.f,startY = 0.f;
    
    
    logoImageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:logoImageView];
    SafeRelease(logoImageView);
    CGFloat offsetY = currY;
    if(kDeviceCheckIphone5){
        offsetY = offsetY ;
    }
    CGFloat reduceOffsetY = -100.f;
    if(kDeviceCheckIphone5){
        reduceOffsetY  = -20.f;
    }
    logoImageView.frame = CGRectMake(5.f, offsetY, image.size.width/kScale, image.size.height/kScale+reduceOffsetY);
    //logoImageView.center = CGPointMake(kDeviceScreenWidth/kScale, 40.f);
    
    currY = currY+190.f;
    
    if(kDeviceCheckIphone5){
        currY = currY+80.f;
    }
    
    int i = 0,index = 0;
    
    UIButton *item = nil;
    UIButton *noteCenterBtn = [UIComUtil createButtonWithNormalBGImageName:@"button-1.png" withHightBGImageName:@"button-1.png" withTitle:kTitleTextArray[i] withTag:1];
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
            if(index == 4)
                loginBtn = item;
            [self.view addSubview:item];
            [item addTarget:self action:@selector(pressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            startX = startX+item.frame.size.width;
        }
        startY = startY+ item.frame.size.height+kItemPendingY;
    }
    
    
}
- (void)gotoMainSite:(id)sender{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.b-chem.com/baochem/"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark button action
- (void)pressButtonAction:(id)sender{
    int index = [sender tag];
    switch (index) {
        case 1:{
           
//            [self test];
//            return;
            
#if 0
            BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
            [self.navigationController pushViewController:bidMainVc animated:YES];
            SafeRelease(bidMainVc);
#else
//            MsgMainViewController *bidMainVc = [[MsgMainViewController alloc]init];
//            [self.navigationController pushViewController:bidMainVc animated:YES];
//            SafeRelease(bidMainVc);
            [ZCSNotficationMgr postMSG:kNavTabItemMSG obj:[NSNumber numberWithInteger:1]];
#endif
            
            
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
            if(!isLogin){
                CardShopLoginViewController *noteListVc = [[CardShopLoginViewController alloc]init];
                //noteListVc.type = 1;
                //[noteListVc setNavgationBarTitle:[sender titleLabel].text];
                noteListVc.view.frame = CGRectMake(0.f,20.f, kDeviceScreenWidth, kDeviceScreenHeight);
#if 1
                [self.navigationController pushViewController:noteListVc  animated:YES];
#else
                [ZCSNotficationMgr postMSG:kPresentModelViewController  obj:noteListVc];
                
#endif
                SafeRelease(noteListVc);
            }
            else{
                
                
                kUIAlertConfirmView(@"提示", @"是否要退出登录", @"取消",@"确定");
            }
            
           
        }
            break;
        case 5:{
            //if(indexPath.row<3)
            {
                kUIAlertView(@"提示", @"正在建设,敬请期待!");
                return;
            }
            OrderListViewController *noteListVc = [[OrderListViewController alloc]init];
            //noteListVc.type = 1;
            [noteListVc setNavgationBarTitle:[sender titleLabel].text];
            [self.navigationController pushViewController:noteListVc animated:YES];
            SafeRelease(noteListVc);

        }
        default:
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        /*
        BidMainViewController *bidMainVc = [[BidMainViewController alloc]init];
        [self.navigationController pushViewController:bidMainVc animated:YES];
        SafeRelease(bidMainVc);
         */
        [ZCSNotficationMgr postMSG:kUserDidLogOut obj:nil];
        
    }
    
}
- (void)didUserLogout:(NSNotification*)ntf{
    isLogin = NO;
    //[self.navigationController popToRootViewControllerAnimated:YES];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateSelected];
    [AppSetting setLogoutUser];
    
}
- (void)didUserLogin:(NSNotification*)ntf{

    isLogin = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
    [loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginBtn setTitle:@"退出登录" forState:UIControlStateSelected];
}
- (void)needLoginUser:(NSNotification*)ntf{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTag:4];
    [self pressButtonAction:btn];
}
@end
