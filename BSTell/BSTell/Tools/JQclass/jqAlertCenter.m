//
//  JQNetworkAlert.m
//  BBB
//
//  Created by ygj on 12-6-29.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//


#import "jqAlertCenter.h"



@implementation jqAlertCenter

+(void)showAlertWithTag:(NSUInteger)aTag forType:(NSInteger)type andDelegate:(id)dlg{


    NSString *path=[[NSBundle mainBundle]pathForResource:@"alert" ofType:@"plist"];
    NSArray *array=[[NSArray alloc]initWithContentsOfFile:path];
    if (type>=array.count) {
        [array release];
        return;
    }
    NSDictionary *dict=[array objectAtIndex:type];
 
    NSString *title=[dict objectForKey:@"title"];
    NSString *msg=[dict objectForKey:@"msg"];
    NSString *cancel=[dict objectForKey:@"cancel"];
    NSString *other=[dict objectForKey:@"other"];
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:dlg cancelButtonTitle:cancel otherButtonTitles:other, nil];
    alert.tag=aTag;
    [alert show];
    [alert release];
    [array release];
}


@end
