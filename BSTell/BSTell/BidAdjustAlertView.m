//
//  BidAdjustAlertView.m
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import "BidAdjustAlertView.h"
#define kHeaderHeight   40.f
#define kBottomHeight   120.f

#define kPendingX       40.f

#define kButtonWidth    60.f
#define kButtonHeight   30.f

#define kLeftPendingX  10.f

@interface BidAdjustAlertView()<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UILabel *headerLabel;
    UILabel *priceIndictLabel;
    UILabel *indicTextLabel;
    UIPickerView *pickView;
    UIButton *rightBtn;
    UIButton *leftBtn;
    UIControl *bgView;
    CGFloat  bidPrice;
}
@property(nonatomic,strong) NSMutableArray  *stepArray;
@end
@implementation BidAdjustAlertView

- (id)initWithFrame:(CGRect)frame  withHeadTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.priceModeString = @"当前价格";
        bgView = [[UIControl alloc]initWithFrame:CGRectMake(0.f, 0.f,kDeviceScreenWidth,kDeviceScreenHeight)];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [[UIApplication sharedApplication].keyWindow addSubview:bgView];
        SafeRelease(bgView);
        
        
        CGFloat currY = 0.f;
        
        CGSize size = frame.size;
        
        CGFloat xPending = (kDeviceScreenWidth-size.width)/2.f;
        
        headerLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:16]
                                       withTextColor:[UIColor blackColor]
                                            withText:title
                                           withFrame:CGRectMake(0,0,size.width,20.f)
                       ];
        [self addSubview:headerLabel];
        SafeRelease(headerLabel);
        currY = currY+20.f;
        indicTextLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:13]
                                                   withTextColor:[UIColor blackColor]
                                                        withText:title
                                                       withFrame:CGRectMake(0.f,currY,size.width,20.f)
                                   ];
        indicTextLabel.adjustsFontSizeToFitWidth = YES;
        currY = currY+20.f +10.f;
        
        [self addSubview:indicTextLabel];
        SafeRelease(indicTextLabel);
        
        
        currY = kHeaderHeight;
        pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0.f,currY,size.width,size.height-kBottomHeight-kHeaderHeight)];
        pickView.backgroundColor = [UIColor whiteColor];
        pickView.showsSelectionIndicator = YES;
        pickView.dataSource = self;
        pickView.delegate = self;
        
        [self addSubview:pickView];
        SafeRelease(pickView);
        currY = currY +pickView.frame.size.height+10.f;
        
        priceIndictLabel = [UIComUtil createLabelWithFont:[UIFont systemFontOfSize:14] withTextColor:[UIColor blackColor] withText:@"" withFrame:CGRectMake(xPending,currY,size.width,20.f)];

        [self addSubview:priceIndictLabel];
        SafeRelease(priceIndictLabel);
        
        currY = currY+priceIndictLabel.frame.size.height+10.f;
        
        leftBtn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"确定" withTag:0];
        leftBtn.frame = CGRectMake(kPendingX, currY,kButtonWidth, kButtonHeight);
         [self addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn = [UIComUtil createButtonWithNormalBGImageName:nil withHightBGImageName:nil withTitle:@"取消" withTag:1];
        [rightBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.frame = CGRectMake(size.width-kPendingX-kButtonWidth,currY,kButtonWidth,kButtonHeight);
        [self addSubview:rightBtn];
        
        self.stepArray = [NSMutableArray array];
        
        for(int i = 1;i<100;i++){
        
            [self.stepArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        self.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:self];
        self.center = CGPointMake(bgView.frame.size.width/2.f, bgView.frame.size.height/2.f);
        bgView.hidden = YES;
        SafeRelease(self);
        
    }
    return self;
}
- (id)initWithAlertFirstViewFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat currY = 20.f;
        rightBtn = [UIComUtil createButtonWithNormalBGImageName:@"main_first_cancel.png" withHightBGImageName:@"main_first_cancel.png" withTitle:@"" withTag:1];
        [rightBtn addTarget:self action:@selector(didPressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.frame = CGRectMake(frame.size.width-kPendingX-10,currY,rightBtn.frame.size.width/8,rightBtn.frame.size.height/8);
        [self addSubview:rightBtn];
        
        currY = currY+rightBtn.frame.size.height;
        UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f,currY,kDeviceScreenWidth, frame.size.height-currY-40.f)];
        [self addSubview:contentView];
        SafeRelease(contentView);
        
        currY = 10.f;
        
//        UITextView *contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kLeftPendingX,currY,kDeviceScreenWidth-2*kLeftPendingX,contentView.frame.size.height)];
//        currY = currY+320.f;
        UILabel  *contentLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor whiteColor] withText:@"以上手机版客户端风险提示，本单位（本人）已阅读，并完全理解，本人是经慎重考虑过后自愿下载使用，由此引起的风险由本人自行负责"withFrame:CGRectMake(kLeftPendingX, currY,contentView.frame.size.width-2*kLeftPendingX,300.f)];
        contentLabel.text = @"              化工宝手机版客户端风险提示\n\
        尊敬的客户：\n请您在使用化工宝手机版客户端之前，仔细阅读以下有关化工宝手机版客户端风险提示：\n\
        1 手机客户端主要通过wifi无线网络、移动互联网等公共网络进行数据传输，基于移动互联网自身特点，存在网络故障、通讯问题以及安全问题等风险。\n\
        2 通过本手机客户端参加竞价、进行交易，客户应注意智能手机操作方式不同于PC端的操作方式，避免再使用时出现操作失误。\n\
        3 提醒各位客户，化工宝对于本手机客户端因客户手机的网络故障、通信延迟以及对客户操作错误而导致的损失恕不承担责任，客户可及时联系化工宝予以协助处理。\n";
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:contentLabel];
        SafeRelease(contentLabel);
        currY = currY+contentLabel.frame.size.height-10.f;
        UILabel  *warningLabel = [UIComUtil createLabelWithFont:[UIFont boldSystemFontOfSize:15] withTextColor:[UIColor redColor] withText:@"  以上手机版客户端风险提示，本单位（本人）已阅读，并完全理解，本人是经慎重考虑过后自愿下载使用，由此引起的风险由本人自行负责"withFrame:CGRectMake(kLeftPendingX, currY,contentView.frame.size.width-2*kLeftPendingX,80.f)];
        warningLabel.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:warningLabel];
        
        SafeRelease(warningLabel);
        
//        contentTextView.contentSize = CGSizeMake(contentView.frame.size.width,warningLabel.frame.size.height+contentTextView.frame.size.height);
        contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
        
    }

    return self;
}
- (void)updateUILayout{
    [pickView selectRow:0 inComponent:0 animated:NO];
    [self setNeedsLayout];
}
- (void)layoutSubviews{
    indicTextLabel.text = [NSString stringWithFormat:@"%@:%0.2lf元,梯度价格:%0.2lf元",self.priceModeString,self.basePrice,self.stepPrice];
    bidPrice = self.basePrice + self.stepPrice;
    priceIndictLabel.text = priceIndictLabel.text = [NSString stringWithFormat:@"出价价格为:%0.2lf元",bidPrice];
}
- (void)setTarget:(id)target withAction:(SEL)action{
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (void)didPressButtonAction:(id)sender{
    [self hidden];
    switch ([sender tag]) {
        case 0:
            if(self.delegate && [self.delegate respondsToSelector:@selector(didClickOkButton: withPrice:)])
                [self.delegate didClickOkButton:self withPrice:bidPrice];
            break;
        case 1:{
            //bgView.hidden = YES;
            if(self.delegate && [self.delegate respondsToSelector:@selector(didClickCancelButton:)])
                [self.delegate didClickCancelButton:self];
            break;
        }
        default:
            break;
    }
}
- (void)setHeadTitle:(NSString*)title{
    headerLabel.text = title;
    
}
- (void)show{
    bgView.hidden = NO;
    bgView.alpha = 1.f;
}
- (void)hidden{
    [UIView         animateWithDuration:0.5
                             animations:^(void){
                                 bgView.alpha = 0.f;
                                 
                             }
                             completion:^(BOOL isFinished){
                                 bgView.hidden = YES;
                             }];
}
- (void)disMiss{

    [UIView         animateWithDuration:0.5
                     animations:^(void){
                         bgView.alpha = 0.f;
                         
                     }
                     completion:^(BOOL isFinished){
                         [bgView removeFromSuperview];
                                    }];
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
    
    bidPrice = self.basePrice +self.stepPrice *(row+1);
    priceIndictLabel.text = [NSString stringWithFormat:@"出价价格为:%0.2lf元",bidPrice];
}
@end
