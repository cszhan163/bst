//
//  BidStartViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-5.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTellNetListBaseViewController.h"
@interface BidStartedViewController : BSTellNetListBaseViewController{

    NSDictionary *currBidItem;
    CGFloat finalPrice;
}
- (void)startReflushjTimer;
- (void)stopReflushTimer;
@end
