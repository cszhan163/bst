//
//  LeftTitleListCell.m
//  BSTell
//
//  Created by cszhan on 14-2-9.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "LeftTitleListCell.h"
/*
 物资编号
 资源数
 起拍价
 当前价
 我的出价
 结束时间
 报盘方式
 拼盘梯度
 品名
 包装
 产地
 仓库
 重量
 计量单位
 质量标准
 备注
 附件
 竞价状态
 计价单位
 场次名称
 */
#define kTitleFontSize 12
@implementation LeftTitleListCell

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray
{
 
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
      
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        CGFloat currX = 20.f;
        CGFloat currY = 10.f;
        int columCount = [titleArray count];
        for(int i = 0;i<columCount;i++)
        {
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,60,14)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = titleArray[i];
           
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            
            itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX+60.f,currY,100,14)];
            itemLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            itemLabel.textColor = [UIColor blackColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            //itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
            
             currY = currY+13.f;
        }
        
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
- (BOOL)setCellItemValue:(NSString*)value withRow:(NSInteger)row {
    UILabel *textLabel =  self.mCellItemArray[row];
    textLabel.text = value;
    return YES;
}
@end
