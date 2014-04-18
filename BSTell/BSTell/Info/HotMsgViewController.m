//
//  HotMsgViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-16.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "HotMsgViewController.h"
#import "InfoClassTableViewCell.h"
#import "NoteListViewController.h"
#define  kClassMapIdDict    @{\
@"交易快报":@"4767",@"市场聚焦":@"4768",@"分析指南":@"4769",@"今日关注":@"4770",\
@"煤焦油":@"4772",@"工业萘":@"4773",@"煤沥青":@"4774",@"蒽油":@"4775",@"洗油":@"4776",@"酚油":@"4777",@"炭黑":@"4778",@"硫酸铵":@"4779",\
@"减水剂":@"4781",@"苯酐":@"4782",@"精萘":@"4783",@"二萘酚":@"4784",@"染料中间体":@"4785",\
@"石油苯":@"4787",@"甲苯二甲苯":@"4788",@"粗苯":@"4789",@"加氢三苯":@"4790",\
@"苯乙烯":@"4792",@"苯酚":@"4793",@"苯胺":@"4794",@"环己酮":@"4795",@"己内酰胺":@"4796",@"己二酸":@"4797",@"顺酐":@"4798",@"氯化苯":@"4799",\
@"行业资讯":@"4800",@"财经资讯":@"4801",@"新浪财经":@"4802",@"华尔街见闻":@"4809",@"排行榜":@"4803"\
}
@implementation HotMsgViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.type = Note_Info;
        self.isDisable = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setHiddenLeftBtn:YES];
    mainView.topBarView.backgroundColor = [UIColor clearColor];
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    
    tweetieTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tweetieTableView.separatorColor = [UIColor whiteColor];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(level == Class_One)
         [self.parentVc setHiddenLeftBtn:YES];
}
- (void)returnToLeveOne{
    
    level = Class_One;
    [self.parentVc setHiddenLeftBtn:YES];
    if(self.levelOneDataArray)
        self.dataArray = self.levelOneDataArray;
    [tweetieTableView reloadData];
    
}

#pragma mark -
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return  5;
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    
    InfoClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
#if 0
        NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"BidItemCell"
                                                        owner:self options:nil];
        for (id oneObject in nibArr)
            if ([oneObject isKindOfClass:[BidItemCell class]])
                cell = (BidItemCell*)oneObject;
#else
        cell = [[InfoClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
#endif
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.clipsToBounds = YES;
        
    }
    NSString *imageFileName = [NSString stringWithFormat:@"button_gray%02d.png",indexPath.row+1];
    UIImageWithFileName(UIImage *image,imageFileName);
    assert(image);
    cell.classImageView.image = image;
    cell.titleLabel.text = self.dataArray[indexPath.row];
    
    cell.contentView.backgroundColor = HexRGB(202,202,202);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 38.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NoteListViewController *vc = [[NoteListViewController alloc]initWithNibName:nil bundle:nil];
    
    vc.index = indexPath.row;
    [vc  setNavgationBarTitle:self.dataArray[indexPath.row]];
    [vc  setHiddenTableHeaderView:NO];
    vc.type = self.type;
    
    if(self.type == Note_Info){
        NSString *idStr = [kClassMapIdDict objectForKey:self.dataArray[indexPath.row]];
        vc.classId = idStr;
        
    }
    
    //[vc  setH]
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
    if(indexPath.row == 2 && self.type == Note_Info && self.isDisable){
    
        //kUIAlertView(@"提示", @"正在建设,敬请期待!");
        return;
    }
    
#if 1
    [self.parentNav pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
    
}

@end
