//
//  BidDetailTableViewCell_V2.h
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "LeftTitleListCell.h"

@interface BidDetailTableViewCell_V2 : LeftTitleListCell
- (void)setActionTarget:(id)actionTarget withSelecotr:(SEL)selector;
- (void)setBidButtonTitle:(NSString*)string;
@end
