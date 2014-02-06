//
//  jqLoading.h
//  BBB
//
//  Created by  on 12-8-20.
//  Copyright (c) 2012年 JianQiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@interface jqLoading : UIView{
    ASIFormDataRequest *request;
@private
    UIActivityIndicatorView *indicator;
}
-(void)showInView:(UIView*)aview;
-(id)initWithRequest:(ASIFormDataRequest *)req;
-(id)initWithRequest:(ASIFormDataRequest *)req andMessage:(NSString *)messgae;
@end
