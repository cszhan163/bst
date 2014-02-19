//
//  LeftTitleListCell.h
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "ExcellLikeCellBase.h"

@interface LeftTitleListCell : ExcellLikeCellBase

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray;
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row;
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row withCol:(NSInteger)col;
@end
