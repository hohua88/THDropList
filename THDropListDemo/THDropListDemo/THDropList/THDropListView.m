//
//  THDropList.m
//  KCBuinessKey
//
//  Created by eddy on 2017/6/23.
//  Copyright © 2017年 www.kuang-chi.org. All rights reserved.
//

#import "THDropListView.h"
#import "Masonry.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width

static float const CellHeight=90.0f;
static NSString * const cellIdentifier = @"cellIdentifier";

@interface THDropListView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation THDropListView

- (instancetype)initWithData:(NSArray *)array{
    self = [super init];
    if (self) {
        self.dataArray = array;
        CGFloat height = (self.dataArray.count*CellHeight + 60) > kScreenHeight - 100 ? kScreenHeight - 100: (self.dataArray.count*CellHeight + 60);
        self.frame = CGRectMake(10, kScreenHeight/2 - height/2, kScreenWidth - 20, height);
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.tableView];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineLabel];
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
    return CellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;

}

#pragma mark - private(lazy)

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [UILabel new];
        _lineLabel.backgroundColor = [UIColor whiteColor];
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
        [_cancelBtn setTitle:@"X" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"X" forState:UIControlStateSelected];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
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
    }];
    
}

#pragma mark - private

- (void)cancelBtnClicked:(id)sender{
    [self removeFromSuperview];
}

@end
