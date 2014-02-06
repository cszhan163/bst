//
//  JQNetworkAlert.h
//  BBB
//
//  Created by ygj on 12-6-29.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jqAlertCenter : NSObject

+(void)showAlertWithTag:(NSUInteger)aTag forType:(NSInteger)type andDelegate:(id)dlg;

@end
 