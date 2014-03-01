//
//  HotMsgViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-16.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "MsgClassBaseViewController.h"
typedef  enum classLevel{
    Class_One,
    Class_Two,
}ClassLevel;


@interface HotMsgViewController : MsgClassBaseViewController{

     ClassLevel  level;
}
@property (nonatomic,assign)BOOL isDisable;
- (void)returnToLeveOne;
@property   (nonatomic,strong)  NSArray *levelTwoDataArray;
@property   (nonatomic,strong)  NSArray *levelOneDataArray;
@end

