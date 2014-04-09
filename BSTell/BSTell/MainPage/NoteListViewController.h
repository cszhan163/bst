//
//  NoteListViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellNetListBaseViewController.h"

typedef enum{
    Note_TXT,
    Note_IMG,
}Note_Content;


@interface NoteListViewController : BSTellNetListBaseViewController

@property   (nonatomic,strong) NSString *classId;
@property (nonatomic, assign) Note_Content subType;
@property (nonatomic, assign) NSInteger index;
- (void)setHiddenTableHeaderView:(BOOL)status;
@end
