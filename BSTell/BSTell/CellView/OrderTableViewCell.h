//
//  OrderTableViewCell.h
//  BSTell
//
//  Created by cszhan on 14-2-18.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "UICarTableViewCell.h"

@interface OrderTableViewCell : UICarTableViewCell
@property(nonatomic,strong)IBOutlet UILabel *orderIdLabel;
@property(nonatomic,strong)IBOutlet UILabel *goodsIdLabel;
@property(nonatomic,strong)IBOutlet UILabel *classNameLabel;
@end
