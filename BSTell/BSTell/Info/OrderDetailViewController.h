//
//  OrderDetailViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellBaseViewController.h"

@interface OrderDetailViewController : BSTellBaseViewController
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSDictionary* orderItem;
@end
