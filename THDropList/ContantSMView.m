//
//  ContantSMView.m
//  KCBuinessKey
//
//  Created by eddy on 2017/6/23.
//  Copyright © 2017年 www.kuang-chi.org. All rights reserved.
//

#import "ContantSMView.h"
#import "KCPhotonData.h"
#import "GMInfoCell.h"

static NSString * const cellIdentifier = @"contactGMCell";

@interface ContantSMView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) LoadProgressView * alertView;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation ContantSMView

- (instancetype)initWithData:(NSArray *)array{
    //CGRect rect = CGRectMake(0, kScreenHeight/4, kScreenWidth, kScreenHeight/2);
    self = [super init];
    if (self) {
        self.dataArray = array;
        CGFloat height = (self.dataArray.count*90 + 60) > kScreenHeight - 100 ? kScreenHeight - 100: (self.dataArray.count*90 + 60);
        self.frame = CGRectMake(10, kScreenHeight/2 - height/2, kScreenWidth - 20, height);
        [self addSubview:self.tableView];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineLabel];
        _alertView = [[LoadProgressView alloc]init];
        _webView=[[UIWebView alloc]initWithFrame:CGRectZero];
        [self addSubview:_webView];
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self setupViewConstraint];

    }
    return self;
}

#pragma mark tableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GMInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary * item = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = item[@"admin_name"];
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.phoneNumLabel.text = item[@"phone"];
    cell.phoneNumLabel.textColor = [UIColor blackColor];
    cell.emailLabel.text = item[@"email"];
    cell.emailLabel.textColor = [UIColor blackColor];
    return cell;

}

#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = [self.dataArray objectAtIndex:indexPath.row];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",item[@"phone"]]];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:phoneUrl]];
}

#pragma mark - private(lazy)

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [UILabel new];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"closeButton"] forState:0];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateSelected];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:19.0];
        _titleLabel.text = @"联系管理员";
    }
    return _titleLabel;
}
#pragma mark private (设置布局)
- (void)setupViewConstraint{
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 20, 10, -20);
    //约束条件
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(padding.top);
        make.left.equalTo(self).with.offset(padding.left);
        make.height.mas_equalTo(44);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self).with.offset(padding.left);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(padding.right);
        make.top.equalTo(self).with.offset(padding.top);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
    }];
    
}

#pragma mark - private

- (void)cancelBtnClicked:(id)sender{
    [self removeFromSuperview];
}

@end
