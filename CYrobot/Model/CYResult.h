//
//  CYResult.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYResult : NSObject

/**  返回结果的类型*/
@property (nonatomic,copy) NSString * code;

/**  返回结果的提示*/
@property (nonatomic,copy) NSString * text;

/**  返回详情的url*/
@property(nonatomic,copy) NSString * url;

/**数组，新闻、火车、菜单*/
@property (nonatomic,strong) NSArray * list;

-(NSString *)resultToStr;

//+(instancetype)resultWithDict:(NSDictionary *)dict;

@end
