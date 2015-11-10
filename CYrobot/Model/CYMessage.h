//
//  CYMessage.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  CYResult;

typedef enum{
    CYMessageTypeSelf,
    CYMessageTypeRobot,
} CYMessageType;

@interface CYMessage : NSObject
/**消息类型，自己发的或者服务器发的*/
@property(nonatomic,assign) CYMessageType type;
/**消息内容*/
@property(nonatomic,copy) NSString * text;

@property (nonatomic,strong) CYResult * result;

@end
