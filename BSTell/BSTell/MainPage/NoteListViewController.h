//
//  NoteListViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellNetListBaseViewController.h"

@interface NoteListViewController : BSTellNetListBaseViewController
@property(nonatomic,assign) NoteType type;
- (void)setHiddenTableHeaderView:(BOOL)status;
@end
