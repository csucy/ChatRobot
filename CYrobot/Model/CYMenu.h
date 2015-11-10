//
//  CYMenu.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYMenu : NSObject

/**名称*/
@property(nonatomic,copy)NSString * name;
/**展示图标*/
@property(nonatomic,copy)NSString * icon;
/**配料信息*/
@property(nonatomic,copy)NSString * info;
/**详细信息url*/
@property(nonatomic,copy)NSString * detailurl;


@end
