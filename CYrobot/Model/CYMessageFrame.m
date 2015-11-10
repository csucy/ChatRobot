//
//  CYMessageFrame.m
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import "CYMessageFrame.h"
#import "CYMessage.h"

#define KCellMargin 10

@implementation CYMessageFrame

//重写set 方法 在这里计算各个子控件的frame
-(void)setMessage:(CYMessage *)message{
    _message = message;
    //1头像
    CGFloat iconX;
    CGFloat iconY = 0;
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    if (message.type == CYMessageTypeSelf) {
        iconX = KScreenWidth - KCellMargin - iconW;
    }
    else{
        iconX = KCellMargin;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //2内容
    CGSize textSize = [self sizeWithText:message.text maxSize:CGSizeMake(KScreenWidth * 0.6, MAXFLOAT) fontSize:CYFontSize];
    CGSize tempSize = CGSizeMake(textSize.width + 40, textSize.height + 40);
    CGFloat textY = 0;
    CGFloat textX;
    if (message.type == CYMessageTypeSelf) {
        textX = iconX - KCellMargin - tempSize.width;
    }else{
        textX = CGRectGetMaxX(_iconFrame) + KCellMargin;
    }
    _textFrame = (CGRect){{textX,textY},tempSize};
    //3计算行高
    CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    
    _rowHeight = MAX(iconMaxY, textMaxY) + KCellMargin;
}

// 计算文本的大小
- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
