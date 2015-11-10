//
//  CYTrain.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTrain : NSObject

/**火车号*/
@property(nonatomic,copy) NSString * trainnum;
/**始发站*/
@property(nonatomic,copy) NSString * start;
/**终点站*/
@property(nonatomic,copy) NSString * terminal;

/**始发时间*/
@property(nonatomic,copy) NSString * starttime;

/**到终点站时间*/
@property(nonatomic,copy) NSString * endtime;
/**图标，一般是火车的标示*/
@property(nonatomic,copy) NSString * icon;
/**详细信息地址*/
@property(nonatomic,copy) NSString * detailurl;

@end
