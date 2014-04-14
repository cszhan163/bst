//
//  BidAdjustAlertView.h
//  BSTell
//
//  Created by cszhan on 14-2-26.
//  Copyright (c) 2014年 cszhan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BidAdjustAlertViewDelegate<NSObject>

@optional
- (void)didClickCancelButton:(id)sender;
- (void)didClickOkButton:(id)sender withPrice:(CGFloat)price;
@end


@interface BidAdjustAlertView : UIView

@property (nonatomic,assign)    CGFloat basePrice;
@property (nonatomic,assign)    CGFloat stepPrice;
@property (nonatomic,strong)    NSString *priceModeString;
@property (nonatomic,assign)    id<BidAdjustAlertViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame  withHeadTitle:(NSString*)title;

- (id)initWithAlertFirstViewFrame:(CGRect)frame;

- (void)setHeadTitle:(NSString*)title;
- (void)show;
- (void)disMiss;
@end
