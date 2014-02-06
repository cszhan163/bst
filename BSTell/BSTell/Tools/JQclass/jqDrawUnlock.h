//
//  PathUnlock.h
//  Sketchpad
//
//  Created by  on 13-5-17.
//  Copyright (c) 2013年 JianQiao. All rights reserved.
//


#define Node_Image_Nornal @"off.png"     //节点未被选中时的图片名
#define Node_Image_Highlighted @"on.png"   //节点被选中时的图片名

#import <UIKit/UIKit.h>

/**
 *	@brief	利用连接个节点的动作来替代输入密码
 */
@interface jqDrawUnlock : UIView


/**
 *	@brief	连接若干点后执行事情
 *
 *	@param 	target 	方法执行者
 *	@param 	action 	要执行的方法，该方法的参数为已连接的节点的编号，即输入的密码
 */
-(void)setTarget:(id)target action:(SEL)action;

/**
 *	@brief	设置节点的大小
 *
 *	@param 	size 	点的大小
 */
-(void)setNodeSize:(CGSize)size;

/**
 *	@brief	设置页面的行数和列数
            行数和列数必须为正整数
 *
 *	@param 	r 	页面的行数
 *	@param 	c 	页面的列数
 */
-(void)setRow:(NSUInteger)r column:(NSUInteger)c;

/**
 *	@brief	重置页面
            当完成一次连接节点的动作后需要重置页面才能进行进行下一次连接动作
 */
-(void)reset;


@end
