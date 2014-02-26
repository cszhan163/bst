//
//  SearchViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "SearchViewController.h"
#import "NoteDetailViewController.h"
@interface SearchViewController ()<UITextFieldDelegate>{

    UITextField *searchField;
    UILabel *noResultLabel;
}
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
   // [super viewWillAppear:animated];
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.type = Note_Info;
    [self setNavgationBarTitle:@"新闻资讯"];
    UIView *heardView = [[UIView alloc]initWithFrame:CGRectMake(0.f, kMBAppBottomToolBarHeght,kDeviceScreenWidth, 44.f)];
    
    //[self.view addSubview:heardView];
    
    UIImageWithFileName(UIImage *image, @"search_input.png");
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(0.f,0.f, kDeviceScreenWidth-50.f, 44.f)];
    
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    searchField.delegate = self;
    searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    searchField.font = kAppTextSystemFont(16);//[UIFont systemFontOfSize:40];
    searchField.textColor = [UIColor blackColor];
    searchField.adjustsFontSizeToFitWidth = NO;
    searchField.text = @"";
    searchField.placeholder = @"输入搜索内容";
    searchField.delegate = self;
    searchField.background = image;
    [heardView addSubview:searchField];
#if 1
    UIButton *searchBtn = [UIComUtil createButtonWithNormalBGImageName:@"search_btn.png" withHightBGImageName:@"search_btn.png" withTitle:@"" withTag:0];
    searchBtn.frame = CGRectMake(kDeviceScreenWidth-40.f,0.f,searchBtn.frame.size.width, searchBtn.frame.size.height);
    [searchBtn addTarget:self action:@selector(searchStart:) forControlEvents:UIControlEventTouchUpInside];
    [heardView addSubview:searchBtn];
#endif
    [tweetieTableView setTableHeaderView:heardView];
    noResultLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:15] withTextColor:[UIColor blackColor] withText:@"没有搜索结果" withFrame:CGRectMake(0.f,heardView.frame.size.height+40.f,heardView.frame.size.width,20.f)];
    [self.view addSubview:noResultLabel];
    noResultLabel.hidden = YES;
    SafeRelease(noResultLabel);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}
- (void) shouldLoadOlderData:(NTESMBTweetieTableView *) tweetieTableView{
    
    //NSString *catStr = [NSString stringWithFormat:@"%d",self.goodGroupNum];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",currentPageNum];
    /*
     @"001",@"hydm",
     @"10",@"limit",
     @"1",@"offset",
     zc	专场代码
     wtzt
     rqStart	竞价日期1
     rqEnd	竞价日期2
     */
    NSDictionary *param  = nil;
    CarServiceNetDataMgr *carServiceNetDataMgr = [CarServiceNetDataMgr getSingleTone];
    
//    if(self.type == Note_New){
//        param = [NSDictionary dictionaryWithObjectsAndKeys:
//                 //catStr,@"cat",
//                 pageNumStr, @"offset",
//                 //@"1",@"zc",
//                 //@"",@"wtzt",
//                 //@"001",@"hydm",
//                 @"10",@"limit",
//                 //@"",@"rqStart",
//                 //@"",@"rqEnd",
//                 nil];
//        
//    }
//    else
    {
        /*
         zxsearchstr
         检索内容
         limit
         一页的数据条数
         offset
         第几页
         
         */
        
        param = [NSDictionary dictionaryWithObjectsAndKeys:
                 searchField.text,@"zxsearchstr",
                 pageNumStr, @"offset",
                 //@"1",@"zc",
                 //@"",@"wtzt",
                 //@"001",@"hydm",
                 @"10",@"limit",
                 //@"",@"rqStart",
                 //@"",@"rqEnd",
                 nil];
        [carServiceNetDataMgr  getHgbZXTitleSearch:param];
        
    }
    
    
}
- (void)searchStart:(id)sender{
    
    noResultLabel.hidden = YES;
    //tweetieTableView.hidden = NO;
    [searchField resignFirstResponder];
    self.pageNum = 1;
    searchField.text = @"苯酚";
    [self shouldLoadOlderData:nil];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.pageNum = 1;
    [self searchStart:nil];
    
    
    return YES;
}
- (void)updateUIData:(NSDictionary*)netData{
    //kNetEnd(self.view);
    [super updateUIData:netData];
    if([self.dataArray count] == 0){
        //tweetieTableView.hidden = YES;
        noResultLabel.hidden = NO;
    }
    else{
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NoteDetailViewController *vc = [[NoteDetailViewController alloc]initWithNibName:nil bundle:nil];
    
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
   
        NSString *idStr = [item objectForKey:@"zxid"];
        vc.type = self.type;
        if(self.type == Note_Bid)
            vc.userId = @"";
        vc.noteId = idStr;
    [vc  setNavgationBarTitle:@""];
    
#if 1
    [self.navigationController pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
}

@end
