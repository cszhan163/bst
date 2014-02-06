//
//  jqPopSelectList.h
//  jqConnectTest
//
//  Created by haifeng on 13-1-22.
//  Copyright (c) 2013年 haifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WIDTH 200   //宽度
typedef enum {
    ListTypeWithBank,
    ListTypeWithHistory,
} ListType;

@protocol jqPopSelectListDelegate;

@interface jqPopSelectList : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableview;
    NSInteger lineNum;
    float lineHeight;
    NSArray *listArr;
    CGPoint point;
    ListType type;
    NSString *lastStr;
    float width;
@protected
    id<jqPopSelectListDelegate> popSelectListDelegate;
}
@property (nonatomic, retain) NSString *lastStr;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) float lineHeight;
@property (nonatomic, assign) ListType type;
@property (nonatomic, assign) float width;
@property (nonatomic, retain) NSArray *listArr;
@property(nonatomic,assign)id<jqPopSelectListDelegate> popSelectListDelegate;
//初始化方法
- (id)initWithDataSrc:(NSArray*)info numOfLine:(NSInteger)num;
@end

@protocol jqPopSelectListDelegate <NSObject>
//选中值后回调执行；
-(void)popSelect:(jqPopSelectList*)popSelect didSelectValue:(NSString*)val forIndex:(NSInteger)index;
//放弃选择后回调执行；
-(void)cancelSelectValue:(jqPopSelectList*)popSelect;
@end