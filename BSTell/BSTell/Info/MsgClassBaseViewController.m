//
//  MsgClassBaseViewController.m
//  BSTell
//
//  Created by cszhan on 14-2-17.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MsgClassBaseViewController.h"
#import "InfoClassTableViewCell.h"
#import "NoteListViewController.h"

@implementation MsgClassBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if(self.classLevel == 0)
        [self setHiddenLeftBtn:YES];
    if(self.topBarColor == nil)
        mainView.topBarView.backgroundColor = [UIColor clearColor];
    else
        mainView.topBarView.backgroundColor = self.topBarColor;
    tweetieTableView.normalEdgeInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
}
- (void)setTopBarViewBackGroundColor:(UIColor*)color{
    
    self.topBarColor = color;
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
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 38.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NoteListViewController *vc = [[NoteListViewController alloc]initWithNibName:nil bundle:nil];
    
    
    [vc  setNavgationBarTitle:self.dataArray[indexPath.row]];
    [vc  setHiddenTableHeaderView:NO];
    //[vc  setH]
    /*
     vc.delegate = self;
     NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
     //NSDictionary *data = [item objectForKey:@"DayDetailInfo"];
     vc.mData = item;
     */
#if 1
    [self.parentNav pushViewController:vc animated:YES];
#else
    
    [ZCSNotficationMgr postMSG:kPushNewViewController obj:vc];
#endif
    //[self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SafeRelease(vc);
    
}
-(void)didNetDataOK:(NSNotification*)ntf
{
    
    
    
    id obj = [ntf object];
    id respRequest = [obj objectForKey:@"request"];
    id data = [obj objectForKey:@"data"];
   
}
@end
