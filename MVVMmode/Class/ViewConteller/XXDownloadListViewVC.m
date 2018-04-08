//
//  XXDownloadListViewVC.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/23.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXDownloadListViewVC.h"
#import "XXDownloadTaskObject.h"
#import "XXVideoDownloadModel.h"

@interface XXDownloadListViewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *taskArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XXDownloadListViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTitleView];
}

- (void)loadTitleView{
    self.navigationItem.title = @"查看中心";
    //加载所有的任务
    self.taskArray = [VideoDownloadCenter getUndownloadedTasksArray];
    VideoDownloadCenter.updateViewLayoutBlock = ^(int indexPathRow) {
        //移除某一个cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPathRow inSection:0];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    };
    if (self.taskArray.count > 0) {
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCellids"];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellids = [NSString stringWithFormat:@"tableViewCellids%ld",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellids];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellids];
        
        UILabel *textLable = [[UILabel alloc] init];
        textLable.tag = 110;
        [cell addSubview:textLable];
        
        UIButton *zhanTingButton = [[UIButton alloc] init];
        zhanTingButton.tag = 111;
        [cell addSubview:zhanTingButton];
        
        UIButton *xiaZhaiButton = [[UIButton alloc] init];
        xiaZhaiButton.tag = 112;
        [cell addSubview:xiaZhaiButton];
        
        UIProgressView *pro1=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        pro1.tag = 113;
        [cell addSubview:pro1];
        
        UILabel *xiazaiDxLable = [[UILabel alloc] init];
        xiazaiDxLable.tag = 114;
        [cell addSubview:xiazaiDxLable];
        
        UILabel *zongDxLable = [[UILabel alloc] init];
        zongDxLable.tag = 115;
        [cell addSubview:zongDxLable];
        
        UILabel *suduLable = [[UILabel alloc] init];
        suduLable.tag = 116;
        [cell addSubview:suduLable];
        
        [textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(pro1.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(40);
        }];
        [pro1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(textLable.mas_bottom).offset(5);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(xiaZhaiButton.mas_left).offset(-10);
            make.height.mas_equalTo(3);
        }];
        [xiaZhaiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(50);
            make.right.mas_equalTo(zhanTingButton.mas_left).offset(-10);
            make.centerY.mas_equalTo(0);
        }];
        [zhanTingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(50);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
        }];
        
        [xiazaiDxLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pro1.mas_bottom).offset(5);
            make.left.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(pro1.mas_width).multipliedBy(0.5);
        }];
        [zongDxLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pro1.mas_bottom).offset(5);
            make.left.mas_equalTo(xiazaiDxLable.mas_right).offset(0);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(pro1.mas_width).multipliedBy(0.5);
        }];
        [suduLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(xiaZhaiButton.mas_left).offset(-10);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(pro1.mas_width).multipliedBy(0.5);
        }];
        XXVideoDownloadModel *videoDownloadModel = self.taskArray[indexPath.row];
        
        float progress          = 1.0 * videoDownloadModel.current/videoDownloadModel.total;
        textLable.text          = videoDownloadModel.titleFileName;
        xiazaiDxLable.text      = [XXDataConversionUtil formatByteCount:videoDownloadModel.current];
        zongDxLable.text        = [XXDataConversionUtil formatByteCount:videoDownloadModel.total];
        pro1.progress           = progress;
        videoDownloadModel.downloadProgressBlock = ^(NSString *schedule, NSString *downloadSize, NSString *totalSize, NSString *sudu) {
            pro1.progress = [schedule floatValue];
            xiazaiDxLable.text = downloadSize;
            zongDxLable.text = totalSize;
            suduLable.text = sudu;
        };
        pro1.trackTintColor     = [UIColor blackColor];
        pro1.progressTintColor  = [UIColor redColor];
        
        
        zhanTingButton.frame = CGRectMake(SCREEN_WIDTH - 70, 15, 50, 30);
        [zhanTingButton setTitle:@"暂停" forState:UIControlStateNormal];
        zhanTingButton.backgroundColor = XXCOLOR(0, 125, 255);
        zhanTingButton.tag = 100 + (int)indexPath.row;
        [zhanTingButton addTarget:self action:@selector(zhanTingButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        xiaZhaiButton.frame = CGRectMake(CGRectGetMinX(zhanTingButton.frame) - 70, 15, 50, 30);
        [xiaZhaiButton setTitle:@"下载" forState:UIControlStateNormal];
        xiaZhaiButton.backgroundColor = XXCOLOR(0, 125, 255);
        xiaZhaiButton.tag = 200 + (int)indexPath.row;
        [xiaZhaiButton addTarget:self action:@selector(xiaZhaiButtonOnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    UILabel *textLable          = [cell viewWithTag:110];
//    
//    UIButton *zhanTingButton    = [cell viewWithTag:111];
//    
//    UIButton *xiaZhaiButton     = [cell viewWithTag:112];
//    
//    UIProgressView *pro1        = [cell viewWithTag:113];
//    
//    UILabel *xiazaiDxLable      = [cell viewWithTag:114];
//    
//    UILabel *zongDxLable        = [cell viewWithTag:115];
//    
//    UILabel *suduLable          = [cell viewWithTag:116];
    
    
    return cell;
}


- (void)zhanTingButtonOnclick:(UIButton *)sender{
    NSInteger tagNumber = sender.tag - 100;
    [VideoDownloadCenter taskObjectChangeWithSubscript:tagNumber downLoadStatus:XXDownLoadStatusSuspended];
}

- (void)xiaZhaiButtonOnclick:(UIButton *)sender{
    NSInteger tagNumber = sender.tag - 200;
    [VideoDownloadCenter taskObjectChangeWithSubscript:tagNumber downLoadStatus:XXDownLoadStatusDownloading];
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = XXCOLOR(111, 222, 222);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
