//
//  untitled.h
//  MP3Player
//
//  Created by ; on 12-1-10.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppMainUIViewManage : NSObject {
	UIWindow *window;
	BOOL isShouldHiddenTabBarWhenPush;
}

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,assign)BOOL isShouldHiddenTabBarWhenPush;
-(void)addMainViewUI;
+(id)getSingleTone;
//-(void)setCurrentTabBar:(NETabNavBar*)tabBar;
+(UINavigationController*)sharedAppNavigationController;
@end
