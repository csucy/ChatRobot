//
//  CYMessageCell.m
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import "CYMessageCell.h"
//#import "RTLabel.h"
#import "MLEmojiLabel.h"

#import "CYMessageFrame.h"
#import "CYMessage.h"

#import "CYChatBtn.h"

@interface CYMessageCell ()

/**头像子控件*/
@property(nonatomic,weak)UIImageView * iconView;


@end


@implementation CYMessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//1 创建自定义可重用cell的对象
+(instancetype)messageCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    CYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CYMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = CYColor(240, 240, 240, 1);
    }
    return cell;
}
//2 创建子控件
//重写该方法 只是为了创建子控件，设置frame及子控件显示的内容在MessageFrame的set方法中
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        //1头像
        UIImageView * iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;

            //重绘头像，设置头像圆形
        iconView.layer.cornerRadius = 25;
        iconView.layer.masksToBounds = YES;
        
        //2内容
        CYChatBtn * textView = [[CYChatBtn alloc] init];
       // textView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:textView];
    
        //self.textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        
        self.textView = textView;

        
    }
    return self;
}

//3 重写MessageFrame的set方法，在传入MessageFrame的时候，就给子控件赋值并且计算好子控件的frame
-(void)setMessageFrame:(CYMessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;

    CYMessage * message = messageFrame.message;
    //1 给子控件赋值
        //根据消息是谁发的，显示哪个头像
    NSString * iconName = ((message.type == CYMessageTypeSelf) ? @"me" : @"robot");
    self.iconView.image = [UIImage imageNamed:iconName];
    
    
    //设置背景图片
    NSString * bgImageName = ((message.type == CYMessageTypeSelf) ? @"chat_send_nor" : @"chat_recive_nor");
    UIImage * bgImage = [UIImage imageNamed:bgImageName];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:(bgImage.size.width / 2) topCapHeight:(bgImage.size.height / 2)];

    [self.textView setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    MLEmojiLabel * tempLabel = self.textView.textLabel;
    
    tempLabel.emojiText = message.text;
    

    //2 设置之空间的frame
    self.iconView.frame = messageFrame.iconFrame;
    
    self.textView.frame = messageFrame.textFrame;
    tempLabel.frame = CGRectMake(18, 18, self.textView.width - 36, self.textView.height - 36);
    //tempLabel.frame = self.textView.bounds;
    
    //self.textView.frame = messageFrame.textFrame;
    if (message.type == CYMessageTypeSelf) {
        
        self.textView.textLabel.textAlignment =  NSTextAlignmentRight;
    }
    
    //self.chatBtn.frame = messageFrame.textFrame;
}

@end
