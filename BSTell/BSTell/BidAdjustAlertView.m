//
//  BidAdjustAlertView.m
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidAdjustAlertView.h"
#define kHeaderHeight   20.f
#define kBottomHeight   50.f

#define kPendingX       30.f

#define kButtonWidth    60.f

@interface BidAdjustAlertView(){
    
    UILabel *headerLabel;
    UILabel *priceIndictLabel;
    UIButton *leftBtn;
   
}
@property(nonatomic,strong) NSMutableArray  *stepArray;
@end
@implementation BidAdjustAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat currY = 0.f;
        CGSize size = frame.size;
        headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:@"" withText:@"" withFrame:CGRectMake(0,0,size.width,20.f)];
            currY = currY+10.f;
        [self addSubview:headerLabel];
        SafeRelease(headerLabel);
        
        UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,0,size.width,size.height-kBottomHeight-currY)];
        pickView.showsSelectionIndicator = YES;
        pickView.dataSource = self;
        pickView.delegate = self;
        [self addSubview:pickView];
        SafeRelease(pickView);
        currY = currY +pickView.frame.size.height;
        
        priceIndictLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:12] withTextColor:@"" withText:@"" withFrame:CGRectMake(0,0,size.width,20.f)];

        [self addSubview:priceIndictLabel];
        SafeRelease(priceIndictLabel);
        
        UIButton *leftBtn = [UIComUtil createButtonWithNormalBGImage:nil withHightBGImage:nil withTitle:@"确定" withTag:0];
        leftBtn.frame = CGRectMake(kPendingX, currY+10.f,60.f, 40.f);
         [self addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *rightBtn = [UIComUtil createButtonWithNormalBGImage:nil withHightBGImage:nil withTitle:@"取消" withTag:1];
        [rightBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.frame = CGRectMake(size.width-kPendingX-kButtonWidth,currY, 60.f, 40.f);
        [self addSubview:rightBtn];
        
        self.stepArray = [NSMutableArray array];
        
        for(int i = 0;i<100;i++){
        
            [self.stepArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
                              
        
    }
    return self;
}
- (void)setTarget:(id)target withAction:(SEL)action{

    

}
- (void)didPressButtonAction:(id)sender{
    

}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [self.stepArray count];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.stepArray objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    CGFloat price = self.basePrice +row *[[self.stepArray objectAtIndex:row]floatValue];
    priceIndictLabel.text = [NSString stringWithFormat:@"%@:%lf 元",self.priceModeString,price];
}
@end
