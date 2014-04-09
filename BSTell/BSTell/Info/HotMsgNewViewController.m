//
//  HotMsgNewViewController.m
//  BSTell
//
//  Created by cszhan on 14-4-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "HotMsgNewViewController.h"

#import "NoteListViewController.h"

#define kLastClassTitleArray \
@[\
@"日报",\
@"周报",\
@"月报",\
]
@interface HotMsgNewViewController ()

@end

@implementation HotMsgNewViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(level == Class_One && indexPath.row == 2){
        
        self.levelOneDataArray = self.dataArray;
        self.dataArray = kLastClassTitleArray;
        [tweetieTableView reloadData];
        level = Class_Two;
        [self.parentVc  setHiddenLeftBtn:NO];
    }
    else{
        if(level == Class_Two){
            
            NoteListViewController *vc = [[NoteListViewController alloc]initWithNibName:nil bundle:nil];
            
            vc.index = indexPath.row;
            vc.subType = Note_IMG;
            [vc  setNavgationBarTitle:self.dataArray[indexPath.row]];
            [vc  setHiddenTableHeaderView:NO];
            vc.type = self.type;
            [self.parentNav pushViewController:vc animated:YES];
            SafeRelease(vc);
          
        }
        else
        {
            
            [super tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
        
    }
}
@end
