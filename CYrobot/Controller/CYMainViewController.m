//
//  ViewController.m
//  CYrobot
//
//  Created by cy on 15/11/6.
//  Copyright © 2015年 cy. All rights reserved.
//

#import "CYMainViewController.h"
#import "CYMessageCell.h"
#import "CYChatBtn.h"

#import "CYMessage.h"
#import "cymessageFrame.h"

#import "CYResult.h"

#import "AFNetworking.h"

#import "MJExtension.h"

#import "MLEmojiLabel.h"

#import "WebViewController.h"

//输入框的高度
#define KInputViewHight 46
//上面显示时间的状态栏高度
#define KStatusBarHight 20

#define KMargin 5



@interface CYMainViewController ()<UITableViewDataSource,UITableViewDelegate,MLEmojiLabelDelegate,UITextFieldDelegate>

/**footView 输入框的那个父控件*/
@property(nonatomic,weak) IBOutlet UIView * footView;

/**输入框*/
@property(nonatomic,weak) IBOutlet UITextField * inputView;

/**tableView 属性*/

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *sendButten;

/**messageFrames数组*/
@property (nonatomic, strong) NSMutableArray *messageFrames;

/**message数组*/
@property (nonatomic, strong) NSMutableArray *message;

- (IBAction)sendBtnClick:(UIButton *)sender;

@end

@implementation CYMainViewController

//messageFrames懒加载
-(NSMutableArray *)messageFrames{
    if (_messageFrames == nil) {
        //把message模型转化为messageFrame模型
        NSMutableArray * array = [NSMutableArray array];
        for (CYMessage *message in _message) {
            CYMessageFrame * messageF = [[CYMessageFrame alloc] init];
            messageF.message = message;
            [array addObject:messageF];
        }
        _messageFrames = array;
    }
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.navigationController.navigationBarHidden = YES;
    //self.sendButten.enabled = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = CYColor(240, 240, 240, 1);
    
    //利用KVO监视输入框内是否有文字，决定发送btn是否可点击
  //  [self.inputView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    //[self.inputView addTarget:self action:@selector(edittingChange:) forControlEvents:UIControlEventEditingChanged];
    
    //添加通知，监视键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWiddChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
   // NSDictionary * dictError = @{@"code":@"100000",@"text":@"你好，我是图灵机器人。你可以跟我聊天、让我讲笑话、看新闻、搜索图片、查天气、快递、列车、航班、查看菜谱、问星座吉凶运势/::P"};
    
   // [self packRobotMessageWithResponseDict:dictError];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    UITextField * textField = object;
//
//        self.sendButten.enabled = ![[textField valueForKeyPath:keyPath] isEqualToString: @""];
//    
//}
//-(void)edittingChange:(UITextField *) textField{
//    self.sendButten.enabled != [textField.text isEqualToString: @""];
//}

-(void)viewDidAppear:(BOOL)animated{
    
   // NSDictionary * dictError = @{@"code":@"100000",@"text":@"你好，我是图灵机器人。你可以跟我聊天、让我讲笑话、看新闻、搜索图片、查天气、快递、列车、航班、查看菜谱、问星座吉凶运势/::P"};
    
    // [self packRobotMessageWithResponseDict:dictError];
}

//记得在对象销毁的时候要退订通知，不然会出现发送通知给野指针的错误
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //[self.inputView removeObserver:self forKeyPath:@"text"];
}


//-258 上 0 下
//键盘弹出或者弹回
-(void)keyboardWiddChangeFrame:(NSNotification *)notification{
    //userInfo 的内容
    //    {
    //        UIKeyboardAnimationCurveUserInfoKey = 7;
    //        UIKeyboardAnimationDurationUserInfoKey = "0.25";
    //        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
    //        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 538}";
    //        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 796}";
    //        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
    //        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
    //    }
    //键盘位移结束后的frame
    CGRect keyboardFrameEnd = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    //动画时间，保持view与键盘动画时间一致
    CGFloat  duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    //位移量，如果是负数就上移，正数往下移动
    CGFloat y = keyboardFrameEnd.origin.y - self.view.frame.size.height;
  //  CYLog(@"位移%f",y);
   // self.tableView.height -= y;
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, y);
    }];
}

- (IBAction)sendBtnClick:(UIButton *)sender{
    CYLog(@"send-btn");
    
    NSString * string = self.inputView.text;
    self.inputView.text = nil;
    
    //1把自己发的消息封装起来
    [self packSelfMessageWithStr:string];
    
    //1创建manger
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    
    //2传递参数
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"key"] = AppKey;
    //parameter[@"info"] = @"新闻";
    parameter[@"info"] = string;
    
    //3发送请求
    [mgr GET:API parameters:parameter success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        
        CYLog(@"请求成功===%@",responseObject);
        
        
        //2接受返回的消息，并把消息封装成CYMessageFrame
        [self packRobotMessageWithResponseDict:responseObject];
        
       // self.sendButten.enabled = NO;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CYLog(@"请求失败");

        NSDictionary * dictError = @{@"code":@"00407",@"text":@"网络不好，请求失败了"};

        [self packRobotMessageWithResponseDict:dictError];
    }];
}
//把自己发的消息封装起来
-(void)packSelfMessageWithStr:(NSString *)string{
    if ([string isEqualToString:@""]) {
        string = @"啥都没讲";
    }
    CYMessageFrame * msgSelfF = [[CYMessageFrame alloc] init];
    //先给text and result 赋值， 才能给 type赋值
    CYMessage * msg = [[CYMessage alloc] init];
    msg.text = string;
    //别忘记设置消息类型
    msg.type = CYMessageTypeSelf;
    
    msgSelfF.message= msg;
    
    [self.messageFrames addObject:msgSelfF];
    //刷新表格
    [self.tableView reloadData];
    //发完消息后滚动到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
//接受返回的消息，并把消息封装成CYMessageFrame
-(void)packRobotMessageWithResponseDict:(NSDictionary * )responseDict{
    //1把接受的字典转化成模型
    NSMutableDictionary * dit = [NSMutableDictionary dictionaryWithDictionary:responseDict];
    //    if(![[dit allKeys] containsObject:@"url"]){
    //        [dit setObject:@"" forKey:@"url"];
    //    }
    //    if (![[dit allKeys] containsObject:@"list"]) {
    //        [dit setObject:@"" forKey:@"list"];
    //    }
    CYResult * resultModel = [[CYResult alloc] init];
    resultModel.code = dit[@"code"];
    resultModel = [CYResult objectWithKeyValues:dit];
    
    //2接受返回的消息，并把消息封装成CYMessageFrame
    CYMessageFrame * msgRobotF = [[CYMessageFrame alloc] init];
    
    CYMessage * msgRobot = [[CYMessage alloc] init];
    
    msgRobot.result = resultModel;
    //设置消息类型
    msgRobot.type = CYMessageTypeRobot;
    
    msgRobotF.message = msgRobot;
    
    [_messageFrames addObject:msgRobotF];
    //刷新表格
    [self.tableView reloadData];
    //发完消息后滚动到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - Table view data source
//cell Section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 2;
    return _messageFrames.count;
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1 创建 cell
    CYMessageCell * cell = [CYMessageCell messageCellWithTableView:tableView];
    cell.textView.textLabel.emojiDelegate = self;
    //2 给子控件赋值
    cell.messageFrame = self.messageFrames[indexPath.row];
    
    return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return 20;
    return [_messageFrames[indexPath.row] rowHeight];
}
//点击某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CYMessageCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    MLEmojiLabel * label = cell.textView;
    //label.emojiDelegate = self;
    //[self.view endEditing:YES];
   // CYLog(@"didSelectRowAtIndexPath");
   // [self.inputView resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // [self.view endEditing:YES];
}

//拖动的时候退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   // CYLog(@"scrollViewWillBeginDragging");
    [self.view endEditing:YES];
}
#pragma emojiDelegate 方法
- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            CYLog(@"点击了链接%@",link);
            [self clickURL:link];
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
           // NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
           // NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
           // NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            //NSLog(@"点击了话题%@",link);
            break;
        default:
           // NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}
-(void)clickURL:(NSString *)url{
  //  CYLog(@"clickURL");
    [self.inputView resignFirstResponder];
    WebViewController * web = [[WebViewController alloc]init];
    web.url = url;
    web.title = @"web";

    [self.navigationController pushViewController:web animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //self.sendButten.enabled = textField.text == nil;
}

@end
