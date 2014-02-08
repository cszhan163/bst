//
//  CarCheckTableView.h
//  BodCarManger
//
//  Created by cszhan on 13-10-21.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "BidDetailTableViewCell.h"
#import "ExcellLikeCellBase.h"
@interface BidDetailTableViewCell : ExcellLikeCellBase
- (void)setHeaderLabelText:(NSString*)text;
- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withColumWidthArray:(NSArray*)widthArray;
- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title;
- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray;
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row withCol:(NSInteger)col;
@end
