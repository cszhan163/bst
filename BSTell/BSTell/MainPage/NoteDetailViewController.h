//
//  NoteDetailViewController.h
//  BSTell
//
//  Created by cszhan on 14-2-1.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BSTellBaseViewController.h"

@interface NoteDetailViewController : BSTellBaseViewController{

    UILabel    *timeLabel;
    // UITextView *contentTextView;
    UILabel *headerView;
    UIWebView *contentTextView;
}

@property (nonatomic, strong) NSString *noteId;



@end
