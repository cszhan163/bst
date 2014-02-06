//
//  CarCheckTableView.m
//  BodCarManger
//
//  Created by cszhan on 13-10-21.
//  Copyright (c) 2013年 cszhan. All rights reserved.
//

#import "BidDetailTableViewCell.h"

@interface BidDetailTableViewCell(){

    CGFloat currCellHeight;
    CGFloat cellHeitht;
    UILabel *headerLabel;
}
@end
@implementation BidDetailTableViewCell

- (id)initWithFrame:(CGRect)frame withRowCount:(NSInteger) rowNum withColumCount:(NSInteger)colNum withCellHeight:(CGFloat)height withHeaderTitle:(NSString*)title;
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    if (self) {
        // Initialization code
        self.frame = frame;
        self.clipsToBounds = YES;
        if(kDeviceCheckIphone5){
            //currY = 5.f;
        }
        [self setRowLineHidden:YES];
        [self setClounmLineHidden:YES];
        
        cellHeitht = height;
        
        //for header title
        CGRect headRect = CGRectMake(0.f,0.f,kDeviceScreenWidth, 40);
        headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16] withTextColor:[UIColor blackColor] withText:title withFrame:headRect];
        [self addSubview:headerLabel];
        //headerLabel.backgroundColor = [UIColor blueColor];
        SafeRelease(headerLabel);
        
        currCellHeight = 40.f;
        
        
        //NSArray *widthArray = ;
        /*
        for(int i = 0;i<colNum;i++){
            UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
            itemLabel.font = [UIFont systemFontOfSize:12];
            itemLabel.textColor = [UIColor whiteColor];
            itemLabel.backgroundColor = [UIColor clearColor];
            itemLabel.textAlignment = NSTextAlignmentCenter;
            itemLabel.text = @"";
            currX = currX+[widthArray[i]floatValue]+1;
            [self addSubview:itemLabel];
            SafeRelease(itemLabel);
            [self.mCellItemArray addObject:itemLabel];
        }
        [self setClounmWidthArrays:widthArray];
        */
        
    }
    return self;
}
- (void)setHeaderLabelText:(NSString*)text{

    headerLabel.text = text;

}
- (void)addColumWithKeyTitleArray:(NSArray*)titleArray withColumWidthArray:(NSArray*)widthArray{
    NSMutableArray *rowArray = [NSMutableArray array];
    CGFloat currX = 0.f;
    CGFloat currY = currCellHeight;
    int columCount = [titleArray count];
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
        itemLabel.font = [UIFont systemFontOfSize:12];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = titleArray[i];
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        //[rowArray addObject:itemLabel];
    }
    currY = currY+cellHeitht*2;
    for(int i = 0;i<columCount;i++)
    {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(currX,currY,[widthArray[i]floatValue],18)];
        itemLabel.font = [UIFont systemFontOfSize:12];
        itemLabel.textColor = [UIColor blackColor];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.text = @"";
        currX = currX+[widthArray[i]floatValue]+1;
        [self addSubview:itemLabel];
        SafeRelease(itemLabel);
        //[rowArray addObject:itemLabel];
    }
    [self.mCellItemArray addObject:rowArray];

    currCellHeight = currY;
    
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
