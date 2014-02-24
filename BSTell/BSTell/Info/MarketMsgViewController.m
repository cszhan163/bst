//
//  MarketMsgViecontroller.m
//  BSTell
//
//  Created by cszhan on 14-2-16.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MarketMsgViewcontroller.h"

#import "MsgClassLevel2ViewController.h"

#define  kMarketClassTitleArray \
@[\
@"煤焦油",\
@"工业萘",\
@"煤沥青",\
@"蒽油",\
@"洗油",\
@"酚油",\
@"炭黑",\
@"硫酸铵",\
]

#define kHotClassTitleArray  \
@[\
@"减水剂",\
@"苯酐",\
@"精萘",\
@"二萘酚"\
]

#define kMeidaClassTitleArray \
@[\
@"粗苯",\
@"甲苯二甲苯",\
@"石油苯",\
@"加氢三苯"\
]

#define kLastClassTitleArray \
@[\
    @"苯乙烯",\
    @"苯酚",\
    @"苯胺",\
    @"环己酮",\
    @"己内酰胺",\
    @"己二酸",\
    @"顺酐",\
    @"氯化苯",\
    ]







#define kSecondLevelTitleArray @[kHotClassTitleArray,kMarketClassTitleArray,kMeidaClassTitleArray,kLastClassTitleArray]


@implementation MarketMsgViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(level == Class_One)
        [self.parentVc setHiddenLeftBtn:YES];
    else{
        [self.parentVc setHiddenLeftBtn:NO];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(level == Class_One){
        
        self.levelOneDataArray = self.dataArray;
        self.dataArray = kSecondLevelTitleArray[indexPath.row];
        [tweetieTableView reloadData];
        level = Class_Two;
        [self.parentVc  setHiddenLeftBtn:NO];
    }
    else{
        
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    }
    return;
    MsgClassLevel2ViewController *vc = [[MsgClassLevel2ViewController alloc]initWithNibName:nil bundle:nil];
    [vc  setNavgationBarTitle:self.dataArray[indexPath.row]];
    
    [vc  setTopBarViewBackGroundColor:HexRGB(1, 159, 233)];
    [vc  setHiddenLeftBtn:NO];
     
    vc.parentNav = self.parentNav;
    vc.classLevel = 1;
    
    //[vc  setH]
    
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     //vc.mData = item;
#if 1
    [self.parentNav pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
    
}
-(void)didSelectorTopNavItem:(id)navObj
{
	NE_LOG(@"select item:%d",[navObj tag]);
    
	switch ([navObj tag])
	{
		case 0:
            if(level == Class_One){
            
            }//[self.navigationController popViewControllerAnimated:YES];// animated:<#(BOOL)animated#>
            else{
                level = Class_One;
                [self.parentVc setHiddenLeftBtn:YES];
                self.dataArray = self.levelOneDataArray;
                [tweetieTableView reloadData];
            }
			break;
		
	}
    if(delegate&&[delegate respondsToSelector:@selector(didSelectorTopNavigationBarItem:)])
    {
        
        [delegate didSelectorTopNavigationBarItem:navObj];
    }
}
@end
