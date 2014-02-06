//
//  JQTabBar.m
//  TabbarDemo
//
//  Created by ygj on 13-3-11.
//  Copyright (c) 2013年 wxh. All rights reserved.
//

#import "JQTabBar.h"
#import "AppDelegate.h"
#import "SFHFKeychainUtils.h"
#import "global.h"



@implementation JQTabBar
@synthesize currentSelectedIndex;
@synthesize buttons = _buttons ;

-(id)initWithNormalImages:(NSArray *)normalImgs hilightedImgs:(NSArray *)highLightedImgs andViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self)
    {
        //隐藏原生tabbar
        for(UIView *view in self.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                view.hidden = YES;
                break;
            }
        }
        //设定tabbar的viewControllers
        if (viewControllers)
        {
            [self setViewControllers:viewControllers];
        }
        else
        {
            NSLog(@"there are no viewControllers!");
            return self;
        }
        
        int viewCount = viewControllers.count > 5 ? 5 : viewControllers.count;
        _buttons = [[NSMutableArray alloc]initWithCapacity:viewCount];
        double _width = 320.0 / viewCount;
        double _height = self.tabBar.frame.size.height;
        
        //创建新的tabbar
        UIView *itemBackView = [[UIView alloc] initWithFrame:self.tabBar.frame];
        itemBackView.backgroundColor = [UIColor clearColor];
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.tabBar.frame.size.height)];
        backImage.image = [UIImage imageNamed:@"down.png"];
        [itemBackView addSubview:backImage];
        [backImage release];
//        UILabel *backImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, self.tabBar.frame.size.height)];
//        backImage.backgroundColor = [UIColor blueColor];
//        [itemBackView addSubview:backImage];
//        [backImage release];
        for (int i = 0; i < viewCount; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*_width, 0, _width, _height);
            btn.tag = i;
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
            //设定正常图片
            if (i <= [normalImgs count])
            {
                [btn setBackgroundImage:[normalImgs objectAtIndex:i] forState:UIControlStateNormal];
            }
            else
            {
                NSLog(@"you miss normalImage at index 0 or %d!",i);
            }
            //设定高亮图片
            if (i <= [highLightedImgs count])
            {
                [btn setBackgroundImage:[highLightedImgs objectAtIndex:i] forState:UIControlStateSelected];
            }
            else
            {
                NSLog(@"you miss highLightedImg at index 0 or %d!",i);
            }
            //添加BadgeView
            UIBadgeView *bdgView = [[UIBadgeView alloc] initWithFrame:CGRectMake(_width - 30, 0, 30, 30)];
            [bdgView setBadgeColor:[UIColor redColor]];
            bdgView.tag = btn.tag + 50;
            bdgView.hidden = YES;
            [btn addSubview:bdgView];
            [bdgView release];
            
            [_buttons addObject:btn];
            [itemBackView addSubview:btn];
        }
        itemBackView.tag = 1987;
        [self.view addSubview:itemBackView];
        [itemBackView release];
        self.currentSelectedIndex = 0;
        self.selectedIndex = self.currentSelectedIndex;
    }
    return self;
}
//手动完成tab切换
- (void)changeCurrentSelectedIndex:(NSInteger)index
{
    for (UIButton *btn in self.buttons)
    {
        if (btn.tag == index)
        {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;
        }
    }
	self.currentSelectedIndex = index;
	self.selectedIndex = self.currentSelectedIndex;
}
//设置BadgeValue
- (void)setBadgeValue:(int)value atIndex:(NSInteger) index
{
    UIBadgeView *bdgView = (UIBadgeView *)[self.view viewWithTag:index + 50];
    if (value<=0)
    {
        bdgView.hidden = YES;
    }
    else
    {
        bdgView.hidden = NO;
        [bdgView setBadgeString:[NSString stringWithFormat:@"%d",value]];
    }
}

-(void)viewDidUnload
{
    _buttons = nil;
    
    [super viewDidUnload];
}

- (void) dealloc
{
    if (_buttons)
    {
        [_buttons release];
        _buttons = Nil;
    }
	
	[super dealloc];
}

@end
