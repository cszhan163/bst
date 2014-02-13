//
//  BSTellBaseViewController.h
//  BSTell
//
//  Created by cszhan on 14-1-31.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UISimpleNetBaseViewController.h"

@interface BSTellBaseViewController : UISimpleNetBaseViewController<UIBaseViewControllerDelegate>
@property(nonatomic,assign) NoteType type;
@property(nonatomic,strong) NSString *userId;
@end
