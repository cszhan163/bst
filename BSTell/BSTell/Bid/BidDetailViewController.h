//
//  BidDetailViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellBaseViewController.h"

@interface BidDetailViewController : BSTellBaseViewController
@property(nonatomic,strong)NSString *wtid;
- (void)setJoinButtonHiddenStatus:(BOOL)status;
@end
