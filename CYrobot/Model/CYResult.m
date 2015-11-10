//
//  CYResult.m
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//
/**
 {
 "code":100000,
 "text":"你好，我是聪明可爱的机器人"
 }
 */
#define KtextCode @"100000"
/**
 {
 "code": 200000,
 "text": "亲，已帮你找到图片",
 "url": "http://m.image.so.com/i?q=%E5%B0%8F%E7%8B%97"
 }
 */
#define KurlCode @"200000"
/**
 {
 "code": 302000,
 "text": "亲，已帮您找到相关新闻",
 "list": [{
 "article": "工信部:今年将大幅提网速降手机流量费",
 "source": "网易新闻",
 "icon": "",
 "detailurl": "http://news.163.com/15/0416/03/AN9SORGH0001124J.html"
 },
 {
 "article": "北京最强沙尘暴午后袭沪 当地叫停广场舞",
 "source": "网易新闻",
 "icon": "",
 "detailurl": "http://news.163.com/15/0416/14/ANB2VKVC00011229.html"
 },
 {
 "article": "公安部:小客车驾照年内试点自学直考",
 "source": "网易新闻",
 "icon": "",
 "detailurl": "http://news.163.com/15/0416/01/AN9MM7CK00014AED.html"
 }]
 }
 */
#define KnewsCode @"302000"
/**
 {
 "code": 305000,
 "text": "亲，已帮您找到列车信息",
 "list": [{
 "trainnum": "Z21(直达特快)",
 "start": "北京西",
 "terminal": "拉萨",
 "starttime": "20:10",
 "endtime": "13:08(+2)",
 "icon": "http://unidust.cn/images/api-train.jpg",
 "detailurl": "http://touch.qunar.com/h5/train/"
 }]
 }
 */
#define KtrainCode @"305000"
//航班返回的也是url
#define KairCode @"306000"
/**
 {
 "code": 308000,
 "text": "亲，已帮您找到菜谱信息",
 "list": [{
 "name": "鱼香肉丝",
 "icon": "http://i4.xiachufang.com/image/280/cb1cb7c49ee011e38844b8ca3aeed2d7.jpg",
 "info": "猪肉、鱼香肉丝调料 | 香菇、木耳、红萝卜、黄酒、玉米淀粉、盐",
 "detailurl": "http://m.xiachufang.com/recipe/264781/"
 }]
 }
 */
#define KmenuCode @"308000"

//40001	参数key长度错误（应该是32位）
//40002	请求内容info为空
//40003	key错误或帐号未激活
//40004	当天请求次数已使用完
//40005	暂不支持所请求的功能
//40006	图灵机器人服务器正在升级
//40007	数据格式异常

#define KNilMessage @"40002"
#define KInvalidMessage @"40007"

#define KNetworkError @"00407"

#import "CYResult.h"
#import "MJExtension.h"
#import "CYNews.h"
#import "CYTrain.h"
#import "CYMenu.h"

@interface CYResult ()<MJKeyValue>

@end

@implementation CYResult

NSString * className = nil;

//重写code 的setter，在设置code时就决定给list数组传递什么模型
-(void)setCode:(NSString *)code{
    _code = [NSString stringWithFormat:@"%@",code];
   // NSString * className = nil;
    if([_code isEqualToString:KnewsCode]){
        className = @"CYNews";
    }
    else if([_code isEqualToString:KtrainCode]){
        className = @"CYTrain";
    }
    else if([_code isEqualToString:KmenuCode]){
        className = @"CYMenu";
    }
}
//告诉MJExtension框架，list中需要转化为那种模型
- (NSDictionary *)objectClassInArray{
    if ([className isEqualToString:@"CYNews"]) {
        return @{@"list" : [CYNews class]};
    }
    else if([className isEqualToString:@"CYTrain"]) {
        return @{@"list" : [CYTrain class]};
    }
    else if([className isEqualToString:@"CYMenu"]) {
        return @{@"list" : [CYMenu class]};
    }
    return nil;
}

//+(instancetype)resultWithDict:(NSDictionary *)dict{
//    CYResult * result = [[CYResult alloc] init];
//    result.code = dict[@"code"];
//    result.text = dict[@"text"];
//    result.url = dict[@"url"];
//    result.list = dict[@"list"];
//    return result;
//}

//把整个result转化为字符串
-(NSString *)resultToStr{
    NSString * string = [[NSString alloc] init];
    //CYResult * result = [[CYResult alloc] init];
    //文本类
    if([_code isEqualToString:KtextCode]){
        string = [NSString stringWithFormat:@"%@",_text];
    }
    //网络断开错误
    else if ([_code isEqualToString:KNetworkError]){
        string = [NSString stringWithFormat:@"%@",_text];
    }
    //链接
    else if([_code isEqualToString:KurlCode]){
        string = [NSString stringWithFormat:@"%@\n详细信息查看:%@",_text,_url];
    }
    //航班 与链接类一样
    else if([_code isEqualToString:KairCode]){
        string = [NSString stringWithFormat:@"%@\n详细信息查看:%@",_text,_url];
    }
    //新闻
    else if([_code isEqualToString:KnewsCode]){

        //遍历新闻list
        
        for (CYNews * news in _list) {
            //string = [NSString stringWithFormat:@"新闻标题:%@\n来自:%@\n详细信息:%@\n\n",news.article,news.source,news.detailurl];
            string = [string stringByAppendingString:[NSString stringWithFormat:@"新闻标题:%@\n来自:%@\n详细信息:%@\n\n",news.article,news.source,news.detailurl]];
        }
       // string = [newslist newsToString];
    }
    //火车
    else if([_code isEqualToString:KtrainCode]){
        //遍历火车list

        for (CYTrain * train in _list) {
            //string = [NSString stringWithFormat:@"车次:%@\n始发站:%@\n终点站:%@\n始发时间:%@\n到站时间:%@\n详细信息:%@\n",train.trainnum,train.start,train.terminal,train.starttime,train.endtime,train.detailurl];
            string = [string stringByAppendingString:[NSString stringWithFormat:@"车次:%@\n始发站:%@\n终点站:%@\n始发时间:%@\n到站时间:%@\n车次信息:%@\n\n",train.trainnum,train.start,train.terminal,train.starttime,train.endtime,train.detailurl]];
        }
        //string = [trainlist trainToString];
    }
    //菜谱
   // <a href="要链接的网址">带链接的文字</a>
    else if([_code isEqualToString:KmenuCode]){
        //遍历菜谱list
        for (CYMenu * menu in _list) {
            //string = [NSString stringWithFormat:@"%@\n配料:%@\n详细做法:%@\n\n",menu.name,menu.info,menu.detailurl];
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@\n配料:%@\n详细做法:%@\n\n",menu.name,menu.info,menu.detailurl]];
        }
        
//        for (int i = 0; i < _list.count; i++) {
//            CYMenu * menu = (CYMenu *)_list[i];
//            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@\n",menu.name]];
//            string = [string stringByAppendingString:[NSString stringWithFormat:@"配料:%@\n",menu.info]];
//            if (i == _list.count) {
//                string = [string stringByAppendingString:[NSString stringWithFormat:@"详细做法:%@",menu.detailurl]];
//            }
//            else {
//                string = [string stringByAppendingString:[NSString stringWithFormat:@"详细做法:%@\n\n",menu.detailurl]];
//            }
//        }
    }
    else if ([_code isEqualToString:KNilMessage]){
        string = @"信息为空，说点什么吧";
    }
    else if ([_code isEqualToString:KInvalidMessage]){
        string = @"数据错误，说点什么吧";
    }
    else
        string = @"这个功能没做呢/::<";
        
    return string;
}

@end
