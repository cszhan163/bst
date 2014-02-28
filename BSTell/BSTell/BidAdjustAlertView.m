//
//  BidAdjustAlertView.m
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidAdjustAlertView.h"
#define kHeaderHeight   20.f
#define kBottomHeight   60.f
@interface BidAdjustAlertView(){
    
    UILabel *headerLabel;
}
@end
@implementation BidAdjustAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat currY = 0.f;
        CGSize size = frame.size;
//        headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:@"" withText:@"" withFrame:CGRectMake({0,0,{size.width,20.f})];
//            currY = currY+10.f;
//            UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake({0,0,{size.width,size.height-kBottomHeight-currY})];
//                [self addSubview:pickView];
        
    }
    return self;
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
