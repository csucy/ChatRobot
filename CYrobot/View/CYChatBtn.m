//
//  CYChatBtn.m
//  CYrobot
//
//  Created by cy on 15/11/9.
//  Copyright © 2015年 cy. All rights reserved.
//

#import "CYChatBtn.h"

#import "MLEmojiLabel.h"

@implementation CYChatBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        MLEmojiLabel * label = [[MLEmojiLabel alloc] init];
        self.textLabel = label;
        [label sizeToFit];
       // label.backgroundColor = [UIColor yellowColor];
       // self.backgroundColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}

@end
