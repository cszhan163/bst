//
//  MsgClassBaseViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-17.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellNetListBaseViewController.h"
//@class BSTellBaseViewController;
@interface MsgClassBaseViewController : BSTellNetListBaseViewController
@property(nonatomic,assign)NSInteger classLevel;
@property(nonatomic,strong)UIColor *topBarColor;

- (void)setTopBarViewBackGroundColor:(UIColor*)color;
@end
