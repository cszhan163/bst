//
//  BSTellNetListBaseViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-7.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UIImageNetBaseViewController.h"

@interface BSTellNetListBaseViewController : UIImageNetBaseViewController
@property(nonatomic,assign)UINavigationController *parentNav;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong) NSString *userId;
- (void)setTopNavBarHidden:(BOOL)status;
@end
