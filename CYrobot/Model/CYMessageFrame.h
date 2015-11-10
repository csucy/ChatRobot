//
//  CYMessageFrame.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#define CYFontSize 15

#import <Foundation/Foundation.h>
@class CYMessage;

@interface CYMessageFrame : NSObject

/**
 *  行高
 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;
/**
 *  模型对象
 */
@property (nonatomic, strong) CYMessage *message;
/**
 * 消息时间frame
 */
@property (nonatomic, assign, readonly) CGRect timeFrame;
/**
 * 消息发送者的头像frame
 */
@property (nonatomic, assign, readonly) CGRect iconFrame;
/**
 * 消息文本frame
 */
@property (nonatomic, assign, readonly) CGRect textFrame;

@end
