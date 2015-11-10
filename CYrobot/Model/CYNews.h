//
//  CYNews.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYNews : NSObject
/*
 "article": "工信部:今年将大幅提网速降手机流量费",
 "source": "网易新闻",
 "icon": "",
 "detailurl": "http://news.163.com/15/0416/03/AN9SORGH0001124J.html"
 */

/** 新闻标题*/
@property(nonatomic,copy)NSString * article;
/** 新闻来源*/
@property(nonatomic,copy)NSString * source;
/** 新闻图标*/
@property(nonatomic,copy)NSString * icon;
/** 新闻详细链接*/
@property(nonatomic,copy)NSString * detailurl;

@end
