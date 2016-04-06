//
//  RemarkViewController.m
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "RemarkViewController.h"
#import "UITextView+Placeholder.h"
#import "Remark.h"

@interface RemarkViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.remark ? @"修改备注" : @"新增备注";
    
    self.navigationItem.leftBarButtonItem = [UIManager barButtonItemWithTitle:@"取消" target:self action:@selector(dismissButtonPressed:)];
    self.navigationItem.rightBarButtonItem = [UIManager barButtonItemWithTitle:@"保存" target:self action:@selector(saveButtonPressed:)];
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.textColor = [UIColor colorWithHex:0x333333];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.textView];
    
    if (self.remark.content.length > 0) {
        self.textView.text = self.remark.content;
    }
    else {
        self.textView.placeholder = @"请输入备注信息";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (!self.didSetupConstraints) {
        [self.textView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.textView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.textView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.textView autoSetDimension:ALDimensionHeight toSize:120];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (IBAction)saveButtonPressed:(id)sender
{
    NSLog(@"saveButtonPressed");
    [self dismissButtonPressed:nil];
}

@end
