//
//  XXVideoDownloadVC.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/23.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXVideoDownloadVC.h"

@interface XXVideoDownloadVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation XXVideoDownloadVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTitleView];
}

- (void)loadTitleView{
    self.navigationItem.title = @"下载中心";
    self.array = @[
                   @[@"第一个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-sd/a82edfe3fc5c4620ba88d53cc4524f63/2016-%E5%9F%BA%E9%87%91%E4%BB%8E%E4%B8%9A-%E5%9F%BA%E9%87%91%E5%9F%BA%E7%A1%80-007-001-1-%20%E8%B5%84%E6%9C%AC%E7%BB%93%E6%9E%84%E7%9A%84%E5%AE%9A%E4%B9%89.mp4"],
                   @[@"第二个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-sd/c95ec0ef5135480f844e3f3fed34e68b/2016-%E4%BC%9A%E8%AE%A1%E4%BB%8E%E4%B8%9A%E8%B5%84%E6%A0%BC%E8%80%83%E8%AF%95-%E8%B4%A2%E7%BB%8F%E6%B3%95%E8%A7%84%E4%B8%8E%E4%BC%9A%E8%AE%A1%E8%81%8C%E4%B8%9A%E9%81%93%E5%BE%B7-%E5%85%AC%E5%BC%80%E8%AF%BE2-%E7%AC%AC%E4%B8%80%E7%AB%A0%E6%B3%95%E5%BE%8B%E6%A6%82%E5%BF%B5%E8%80%83%E7%82%B9%E8%AF%A6%E8%A7%A3.mp4"],
                   @[@"第三个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-sd/9f3ba56d2ee64132845632c82c4649f9/20170314-%E5%B8%AE%E8%80%83%E7%BD%91%E5%AE%A3%E4%BC%A0%E7%89%87.mp4"],
                   @[@"第四个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-sd/259e8c8f33ef4d888607e90c6379a0a4/2016-%E4%BC%9A%E8%AE%A1%E4%BB%8E%E4%B8%9A%E8%B5%84%E6%A0%BC%E8%80%83%E8%AF%95-%E4%BC%9A%E8%AE%A1%E5%9F%BA%E7%A1%80-%E5%85%AC%E5%BC%80%E8%AF%BE-%E7%AC%AC%E4%BA%8C%E7%AB%A0%E9%87%8D%E7%82%B9%E8%AF%A6%E8%A7%A3.mp4"],
                   @[@"第五个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-sd/d79e60c22fdc4be18dd8d676fe418a9a/2017-%E4%BC%9A%E8%AE%A1%E4%BB%8E%E4%B8%9A%E8%B5%84%E6%A0%BC%E8%80%83%E8%AF%95-%E4%BC%9A%E8%AE%A1%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE1-002.mp4"],
                   @[@"第六个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/7770f272be524e7fa6979f0a7bdceb58/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%95%E5%90%AC-%E7%AC%AC%E4%B8%80%E7%AB%A0%E7%AC%AC%E4%BA%8C%E8%8A%82-%E4%BC%9A%E8%AE%A1%E5%9F%BA%E6%9C%AC%E5%81%87%E8%AE%BE%E3%80%81%E4%BC%9A%E8%AE%A1%E5%9F%BA%E7%A1%80%E5%92%8C%E4%BC%9A%E8%AE%A1%E4%BF%A1%E6%81%AF%E8%B4%A8%E9%87%8F%E8%A6%81%E6%B1%82%20.mp4"],
                   @[@"第七个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/72355e6b7e124cc58c33e57a2f747a74/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-2%E6%9C%8826%E6%97%A5-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-%E4%BC%9A%E8%AE%A1%E6%A6%82%E8%BF%B0%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第八个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/108d04a4d83a4f70be02b87c5434c727/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-001-%E7%AC%AC%E4%B8%80%E7%AB%A0%20%E4%BC%9A%E8%AE%A1%E6%A6%82%E8%BF%B0%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第九个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/956ccad4ecfb4683865bc61353d706e7/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-001-%E7%AC%AC%E4%B8%80%E7%AB%A0%E4%BC%9A%E8%AE%A1%E6%A6%82%E8%BF%B0%EF%BC%883%EF%BC%89.mp4"],
                   @[@"第十个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/d7c4f79f6cb44650aed7d1ef49b10f10/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-002-%E7%AC%AC%E4%BA%8C%E7%AB%A0%20%E8%B5%84%E4%BA%A7%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第十一个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/7a971b7cf3f84292b2336e96a07c50bd/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-002-%E7%AC%AC%E4%BA%8C%E7%AB%A0%20%E8%B5%84%E4%BA%A7%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第十二个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/540c5680443a469b9d505f183d0ff912/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-001-%E7%AC%AC%E4%BA%8C%E7%AB%A0%20%E8%B5%84%E4%BA%A7%EF%BC%883%EF%BC%89.mp4"],
                   @[@"第十三个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/ce604725581544d690ab59fa8f522c56/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-002-%E7%AC%AC%E4%BA%8C%E7%AB%A0%20%E8%B5%84%E4%BA%A7%EF%BC%884%EF%BC%89.mp4"],
                   @[@"第十四个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/9736995ba0954de58783f3844ea4f748/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-002-%E7%AC%AC%E4%BA%8C%E7%AB%A0%E8%B5%84%E4%BA%A7%EF%BC%885%EF%BC%89.mp4"],
                   @[@"第十五个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/43f73afac3534e39bccd87b1c7faa605/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-003-%E7%AC%AC%E4%B8%89%E7%AB%A0%20%E8%B4%9F%E5%80%BA%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第十六个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/9090f73399354b849172bc359dc9f0f7/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-003-%E7%AC%AC%E4%B8%89%E7%AB%A0%E8%B4%9F%E5%80%BA%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第十七个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/15f14992b5b340bfb8c9853087867889/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E5%AE%9E%E5%8A%A1%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-004-%E7%AC%AC%E5%9B%9B%E7%AB%A0%E6%89%80%E6%9C%89%E8%80%85%E6%9D%83%E7%9B%8A.mp4"],
                   @[@"第十八个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/7783bdea21904a76878609de0b8c16dc/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-005-%E7%AC%AC%E4%BA%94%E7%AB%A0%E6%94%B6%E5%85%A5%E3%80%81%E8%B4%B9%E7%94%A8%E5%92%8C%E5%88%A9%E6%B6%A6%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第十九个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/e50aa1d3d742462280733b4a643a5645/2018-%20%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-005-%E7%AC%AC%E4%BA%94%E7%AB%A0%E6%94%B6%E5%85%A5%E3%80%81%E8%B4%B9%E7%94%A8%E5%92%8C%E5%88%A9%E6%B6%A6%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第二十个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/64937b5528124fc4892dde7bcf1df822/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-005-%E7%AC%AC%E4%BA%94%E7%AB%A0%20%E6%94%B6%E5%85%A5%E3%80%81%E8%B4%B9%E7%94%A8%E5%92%8C%E5%88%A9%E6%B6%A6%EF%BC%883%EF%BC%89.mp4"],
                   @[@"第二十一个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/741347d2391d4e2d80c08293902cbdc3/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E5%AE%9E%E5%8A%A1%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-005%E3%80%81006-%E7%AC%AC%E4%BA%94%E7%AB%A0%20%E6%94%B6%E5%85%A5%E3%80%81%E8%B4%B9%E7%94%A8%E5%92%8C%E5%88%A9%E6%B6%A6%EF%BC%884%EF%BC%89%E3%80%81%E7%AC%AC%E5%85%AD%E7%AB%A0%20%E8%B4%A2%E5%8A%A1%E6%8A%A5%E8%A1%A8%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第二十二个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/f68042c14fcf4ada832038712f1aa2b2/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E5%AE%9E%E5%8A%A1-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-006-%E7%AC%AC%E5%85%AD%E7%AB%A0%E8%B4%A2%E5%8A%A1%E6%8A%A5%E8%A1%A8%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第二十三个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/ec205ab9db2b4f61b638f9b2b530cba3/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%95%E5%90%AC-%E7%AC%AC%E4%B8%80%E7%AB%A0%E7%AC%AC%E4%B8%80%E8%8A%82-%E6%B3%95%E5%BE%8B%E5%85%B3%E7%B3%BB%20.mp4"],
                   @[@"第二十四个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/4f2c6b8bacff452a9713f3367eafb71b/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%95%E5%90%AC-%E7%AC%AC%E4%B8%80%E7%AB%A0%E7%AC%AC%E4%B8%80%E8%8A%82-%E6%B3%95%E5%BE%8B%E4%BA%8B%E5%AE%9E.mp4"],
                   @[@"第二十五个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/b473b3ca5938427abd77e48af6a92024/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-001-%E7%AC%AC%E4%B8%80%E7%AB%A0%20%E6%80%BB%E8%AE%BA%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第二十六个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/7c18edb671af4f93852e2a8c61248fe7/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-001-%E7%AC%AC%E4%B8%80%E7%AB%A0%20%E6%80%BB%E8%AE%BA%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第二十七个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/a6dd090b801c4500a969614d6bec9e33/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-001-%E7%AC%AC%E4%B8%80%E7%AB%A0%E6%80%BB%E8%AE%BA%EF%BC%883%EF%BC%89%E3%80%81%E7%AC%AC%E4%BA%8C%E7%AB%A0%E4%BC%9A%E8%AE%A1%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第二十八个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/2501961c0bf34b36afad5cd515157d1d/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-002-%E7%AC%AC%E4%BA%8C%E7%AB%A0%20%E4%BC%9A%E8%AE%A1%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第二十九个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/e8d1594d8a1e4475920a2e12fb78671b/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-003-%E7%AC%AC%E4%B8%89%E7%AB%A0%E6%94%AF%E4%BB%98%E7%BB%93%E7%AE%97%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第三十个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/c1912208e61d4f3ab2bf1839135464c0/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-003-%E7%AC%AC%E4%B8%89%E7%AB%A0%E6%94%AF%E4%BB%98%E7%BB%93%E7%AE%97%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第三十一个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/a35671b32452401d89dd14eda5f748de/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-003-%E7%AC%AC%E4%B8%89%E7%AB%A0%E6%94%AF%E4%BB%98%E7%BB%93%E7%AE%97%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%883%EF%BC%89.mp4"],
                   @[@"第三十二个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/f257fd1e319f48d7aa5602d9eca4a1aa/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-%E7%AC%AC%E4%B8%89%E7%AB%A0%E6%94%AF%E4%BB%98%E7%BB%93%E7%AE%97%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%884%EF%BC%89.mp4"],
                   @[@"第三十三个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/6b0b2297acb8480c9728bb3cc571e1d1/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-004-%E7%AC%AC%E5%9B%9B%E7%AB%A0%20%E5%A2%9E%E5%80%BC%E7%A8%8E%E3%80%81%E6%B6%88%E8%B4%B9%E7%A8%8E%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%881%EF%BC%89.mp4"],
                   @[@"第三十四个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/e41818137c3149508c60b304068d39b6/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E7%BB%8F%E6%B5%8E%E6%B3%95-%E7%9B%B4%E6%92%AD%E8%AF%BE-004-%E7%AC%AC%E5%9B%9B%E7%AB%A0%20%E5%A2%9E%E5%80%BC%E7%A8%8E%E3%80%81%E6%B6%88%E8%B4%B9%E7%A8%8E%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%882%EF%BC%89.mp4"],
                   @[@"第三十五个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/acab0b6f35df4f259e7289270846b24c/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-004-%E7%AC%AC%E5%9B%9B%E7%AB%A0%E5%A2%9E%E5%80%BC%E7%A8%8E%E3%80%81%E6%B6%88%E8%B4%B9%E7%A8%8E%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%883%EF%BC%89.mp4"],
                   @[@"第三十六个视频",
                     @"http://alyvideo.cnbkw.com/Act-ss-mp4-ld/32a76ae6cbcb4602b1bb8fbdc41e7ae1/2018-%E5%88%9D%E7%BA%A7%E4%BC%9A%E8%AE%A1%E8%81%8C%E7%A7%B0%E8%80%83%E8%AF%95-%E7%BB%8F%E6%B5%8E%E6%B3%95%E5%9F%BA%E7%A1%80-%E7%9B%B4%E6%92%AD%E8%AF%BE-%E6%95%99%E6%9D%90%E7%A0%94%E8%AF%BB-004-%E7%AC%AC%E5%9B%9B%E7%AB%A0%E5%A2%9E%E5%80%BC%E7%A8%8E%E3%80%81%E6%B6%88%E8%B4%B9%E7%A8%8E%E6%B3%95%E5%BE%8B%E5%88%B6%E5%BA%A6%EF%BC%884%EF%BC%89.mp4"]
                   ];
    
    
    
   
//    2018-04-04 16:47:46.111573+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:46.378114+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:47.766465+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:47.895305+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:48.078104+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:48.228673+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:48.478083+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:48.979349+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:50.245785+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:50.480387+0800 BangKao[14485:3258869]
//    2018-04-04 16:47:50.895436+0800 BangKao[14485:3258869]
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSArray *array = self.array[indexPath.section];
    cell.textLabel.text = array[0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = self.array[indexPath.section];
    NSString *urlString = array[1];
    [VideoDownloadCenter downloadVideoWithUrl:[NSURL URLWithString:urlString] downloadVideoStatusBlock:^(NSString *status) {
        NSLog(@"%@",status);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:status
                                                           delegate:nil
                                                  cancelButtonTitle:@"确认"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
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
