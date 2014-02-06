//
//  SFHFKeychainUtils.h
//  bsteelPay
//
//  Created by haifeng on 13-6-5.
//  Copyright (c) 2013年 wangxuhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFHFKeychainUtils : NSObject {
    
}

+ (NSString *) getPasswordForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;
+ (BOOL) storeUsername: (NSString *) username andPassword: (NSString *) password forServiceName: (NSString *) serviceName updateExisting: (BOOL) updateExisting error: (NSError **) error;
+ (BOOL) deleteItemForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

@end
