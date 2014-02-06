//
//  JQTabBar.h
//  TabbarDemo
//
//  Created by ygj on 13-3-11.
//  Copyright (c) 2013年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIBadgeView.h"

@interface JQTabBar : UITabBarController
{
	NSMutableArray *_buttons;//工具栏按钮数组
	int currentSelectedIndex;//当前高亮工具栏按钮
}

@property (nonatomic , assign) int currentSelectedIndex;
@property (nonatomic , retain) NSMutableArray *buttons;

//初始化，normalImgs 为非高亮状态图片数组 ，highLightedImgs为高亮状态图片数组 ，viewControllers为视图控制器数组
-(id)initWithNormalImages:(NSArray *)normalImgs hilightedImgs:(NSArray *)highLightedImgs andViewControllers:(NSArray *)viewControllers;

//手动完成tab切换，切换到索引为index的item
- (void)changeCurrentSelectedIndex:(NSInteger)index;

//设置索引为index的item 的 BadgeValue 为value
- (void)setBadgeValue:(int)value atIndex:(NSInteger) index;

@end
