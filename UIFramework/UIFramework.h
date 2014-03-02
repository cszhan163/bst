//
//  UIFramework.h
//  DressMemo
//
//  Created by  on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef DressMemo_UIFramework_h
#define DressMemo_UIFramework_h

#import "UIFrameworkMSG.h"


//the tabBabview will offset Y ,if we don't offset Y then we should  0,this app we offset 10 ,as the select status
#define kTabBarViewOffsetY                              0.f//-10.f
#define kTabItemNarmalImageFileNameFormart              @"tableitem%d"
#define kTabItemSelectImageFileNameFormart              @"tableitemsel%d"
#define kTabBarViewBGImageFileName                      @"tabbarbg.png"
//if we don't use tabBar view offset ,we can use as follow to implement 

//the image between the tab and content view
#define kTabBarAndViewControllerSepratorImageFileName   @"tabitemtopsplit.png"
//the select mask image
#define kTabBarItemMaskImageFileName                    @"tableitemselmask.png"

#define kMBAppRealViewYPending                          9.f

#define kTabItemTextShow            1

//if all the button is the same ,the offset should be all 0
#define kTabAllItemTextCenterXOffset    @"0,0,0,0,0"
#define kTabAllItemTextCenterYOffset    @"0,0,0,0,0"

#define kTabImageOffsetPoint            CGPointMake(20.f,8.f)

#define kTabAllItemText                 @"在线交易,资讯中心,首页,我的信息,关于我们"
//for tabItem text
#define kTabItemTextPendingY            7.f
#define kTabItemTextHeight              12
#define kTabItemTextFont            [UIFont systemFontOfSize:12]

#define kTabItemTextNomalColor      [UIColor whiteColor]
#define kTabItemTextSelColor        HexRGB(110, 228, 255)

#define kTabCountMax                              5
#define kTabItemImageSubfix                       @"png"




#endif
