//
//  XXLaiFuKushimaTC.m
//  MVVMmode
//
//  Created by 夏江福 on 2018/3/9.
//  Copyright © 2018年 cn.xia. All rights reserved.
//

#import "XXLaiFuKushimaTC.h"
#import "XXLaiFuKushimaTableViewModel.h"

@interface XXLaiFuKushimaTC ()

@property (nonatomic, strong) XXLaiFuKushimaTableViewModel   *tableViewModel;

@end

@implementation XXLaiFuKushimaTC

- (instancetype)init{
    self = [super init];
    if (self) {
        self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableViewModel = [[XXLaiFuKushimaTableViewModel alloc] init];
    [_tableViewModel getFukushimaFunnyPicture];
    __weak __typeof(self) wekeSelf = self;
    _tableViewModel.funnyPictureBlock = ^(NSArray *funnyPictureBodyListModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wekeSelf.tableView reloadData];
        });
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewModel.funnyPictureBodyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *XXLaiFuKushimaCell = @"XXLaiFuKushimaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XXLaiFuKushimaCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XXLaiFuKushimaCell];
    }
    cell.textLabel.text = [_tableViewModel getFunnyPictureBodyListWithIndex:(int)indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XXFunnyPictureBodyList *funnyPictureBodyList = [_tableViewModel getFunnyPictureBodyListWithIndex:(int)indexPath.row];
    if (self.backDelegate && [self.backDelegate respondsToSelector:@selector(withValueTransmission:)]) {
        [self.backDelegate withValueTransmission:funnyPictureBodyList];
    }
}


@end
