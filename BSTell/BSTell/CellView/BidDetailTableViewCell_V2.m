//
//  BidDetailTableViewCell_V2.m
//  BSTell
//
//  Created by cszhan on 14-2-19.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidDetailTableViewCell_V2.h"
@interface BidDetailTableViewCell_V2(){
    UIButton *bidBtn;
}
@end
@implementation BidDetailTableViewCell_V2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitleArray:(NSArray*)titleArray withTitleAttributeArray:(NSArray*)titleAtrArray withValueAttributeArray:(NSArray*)valueAtrArray withHeightArray:(NSArray*)heightArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier withTitleArray:titleArray withTitleAttributeArray:titleAtrArray withValueAttributeArray:valueAtrArray withHeightArray:heightArray];
    if (self) {
        // Initialization code
        
        UIImageWithFileName(UIImage *image , @"arrow_detail.png");
        
        UIImageView *detailView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:detailView];
        SafeRelease(detailView);
        detailView.frame = CGRectMake(0.f, 0.f, image.size.width/kScale, image.size.height/kScale);
        detailView.center = CGPointMake(290-20.f,52);
        
        bidBtn = [UIComUtil createButtonWithNormalBGImageName:@"bid_cell_btn.png" withHightBGImageName:@"bid_cell_btn.png" withTitle:@"+1" withTag:0];
        [self addSubview:bidBtn];
        bidBtn.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        
        bidBtn.frame = CGRectMake(190.f, 25.f, bidBtn.frame.size.width, bidBtn.frame.size.height);
    }
    return self;
}
- (void)setActionTarget:(id)actionTarget withSelecotr:(SEL)selector{
    [bidBtn addTarget:actionTarget action:selector forControlEvents:UIControlEventTouchUpInside];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
