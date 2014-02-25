//
//  BidItemDetailViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellBaseViewController.h"
typedef enum bidType{
    Bid_Stated,
    Bid_Prepare,
}BidType;
@interface BidItemDetailViewController : BSTellBaseViewController
@property(nonatomic,assign)BOOL isDelegate;
@property(nonatomic,strong)NSDictionary *bidItem;
@property(nonatomic,assign)BidType bidType;
@property (nonatomic,strong) NSString *goodId;
@end
