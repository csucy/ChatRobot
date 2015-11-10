//
//  CYMessage.m
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import "CYMessage.h"
#import "CYResult.h"

@interface CYMessage ()


@end

@implementation CYMessage
//重写type的setter，在设置消息类型的时候就把text值设置好，所以要先设置 text和result，最后才能设置type
-(void)setType:(CYMessageType)type{
    _type = type;
    if (type == CYMessageTypeSelf) {
        self.text = self.text;
    }
    else{
        self.text = [_result resultToStr];
    }
}

@end
