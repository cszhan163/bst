//
//  BidAdjustAlertView.h
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidAdjustAlertView : UIView
@property(nonatomic,assign)CGFloat basePrice;
@property(nonatomic,assign)CGFloat stepPrice;
@property(nonatomic,strong)NSString *priceModeString;
@end
