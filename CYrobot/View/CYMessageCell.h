//
//  CYMessageCell.h
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYMessageFrame;
@class MLEmojiLabel;
@class CYChatBtn;

@interface CYMessageCell : UITableViewCell

/**messageFrame,包含了message,以及子控件的frame信息*/
@property(nonatomic,strong)CYMessageFrame * messageFrame;

/**内容子控件*/
//@property(nonatomic,weak)MLEmojiLabel * textView;
/**内容子控件*/
@property(nonatomic,weak)CYChatBtn * textView;

/** 提供类方法，快速创建一个cell*/
+(instancetype)messageCellWithTableView:(UITableView *)tableView;

@end
