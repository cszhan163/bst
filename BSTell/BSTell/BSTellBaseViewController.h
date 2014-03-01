//
//  BSTellBaseViewController.h
//  BSTell
//
//  Created by cszhan on 14-1-31.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UISimpleNetBaseViewController.h"
#import "BSTellTimerReflushDataProcotol.h"
@interface BSTellBaseViewController : UISimpleNetBaseViewController<UIBaseViewControllerDelegate,BSTellTimerReflushDataProcotol>{
   
}
@property   (nonatomic,strong)  NSTimer *timer;
@property   (nonatomic,assign) BOOL needLogin;
@property   (nonatomic,assign) NoteType type;
@property   (nonatomic,strong) NSString *userId;
@property   (nonatomic,strong) NSString *czy;
@end
