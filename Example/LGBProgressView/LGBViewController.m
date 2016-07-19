//
//  LGBViewController.m
//  LGBProgressView
//
//  Created by lgb789 on 07/18/2016.
//  Copyright (c) 2016 lgb789. All rights reserved.
//

#import "LGBViewController.h"
#import "LGBProgressView.h"

@interface LGBViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LGBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell-->%ld", indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBProgressView *progressView = [LGBProgressView new];
    if (indexPath.row == 0) {
        LGBProgressView *progress = [LGBProgressView new];
        progress.indicatorView = [LGBIndicatorView new];
        progress.style = LGBProgressViewStyleDark;
        [progress showInView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            progress.text.text = @"dsfsd";
            [progress reload:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [progress dismiss];
            });
        });
        
        return;
        
    }else if (indexPath.row == 1){
        LGBProgressView *progress = [LGBProgressView new];
        progress.indicatorView = [LGBIndicatorView new];
        progress.text.text = @"正在登录...";
        progress.style = LGBProgressViewStyleDark;
        progress.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        [progress showInView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            progress.text.text = @"用户名和密码错误";
            [progress reload:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [progress dismiss];
            });
        });
        
        return;
        
        
    }else if (indexPath.row == 2){
        
        progressView.indicatorView = [LGBIndicatorView new];
        progressView.text.text = @"请输入用户名和密码";
        progressView.style = LGBProgressViewStyleDark;
        
    }else if (indexPath.row == 3){
        
        progressView.indicatorView = [LGBIndicatorView new];
        progressView.text.text = @"正在加载...正在加载...正在加载...正在加载...正在加载...正在加载...";
        progressView.style = LGBProgressViewStyleDark;
        
    }else if (indexPath.row == 4){
        progressView.text.text = @"正在加载...";
        progressView.style = LGBProgressViewStyleDark;
        progressView.position = LGBProgressViewPositionBottomCenter;
        
    }else if (indexPath.row == 5){
        progressView.indicatorView = [LGBIndicatorView new];
        progressView.text.text = @"正在加载...";
        progressView.detailText.text = @"detail text";
        
    }else if (indexPath.row == 6){
        //        progressView.indicatorView = [LGBIndicatorView new];
        progressView.text.text = @"正在加载...";
        progressView.detailText.text = @"detail text";
        
    }else if (indexPath.row == 7){
        progressView.indicatorView = [LGBIndicatorView new];
        //        progressView.text.text = @"正在加载...";
        progressView.detailText.text = @"detail text";
    }else if (indexPath.row == 8){
        //        progressView.indicatorView = [LGBIndicatorView new];
        //        progressView.text.text = @"正在加载...";
        progressView.detailText.text = @"detail text";
        
    }else if (indexPath.row == 9) {
        progressView.indicatorView = [LGBPieIndicatorView new];
        [progressView setProgress:0.3 animated:YES];
        progressView.style = LGBProgressViewStyleDark;
        
    }else if (indexPath.row == 10){
        
        progressView.indicatorView = [LGBPieIndicatorView new];
        [progressView setProgress:0.4 animated:YES];
        progressView.style = LGBProgressViewStyleLight;
        progressView.text.text = @"加载";
        
        
    }else if (indexPath.row == 11){
        
        progressView.indicatorView = [LGBPieIndicatorView new];
        progressView.text.text = @"Downloading...";
        progressView.detailText.text = @"0% Complete";
        progressView.style = LGBProgressViewStyleLight;
        
        [progressView showInView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self incrementHUD:progressView progress:0];
        });
        
        return;
        
    }else if (indexPath.row == 12) {
        progressView.indicatorView = [LGBRingIndicatorView new];
        [progressView setProgress:0.3 animated:YES];
        progressView.style = LGBProgressViewStyleDark;
        
    }else if (indexPath.row == 13){
        
        progressView.indicatorView = [LGBRingIndicatorView new];
        [progressView setProgress:0.4 animated:YES];
        progressView.text.text = @"加载";
        
        
    }else if (indexPath.row == 14){
        
        progressView.indicatorView = [LGBRingIndicatorView new];
        progressView.text.text = @"Downloading...";
        progressView.detailText.text = @"0% Complete";
        progressView.style = LGBProgressViewStyleLight;
        
        [progressView showInView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self incrementHUD:progressView progress:0];
        });
        
        return;
        
    }else if (indexPath.row == 15){
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_success"]];
        progressView.indicatorView = [[LGBIndicatorContentView alloc] initWithContentView:imgView];
        progressView.text.text = @"success!";
        
    }
    
    [progressView showInView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView dismiss];
    });
}

-(void)incrementHUD:(LGBProgressView *)hud
           progress:(int)progress
{
    progress += 1;
    
    [hud setProgress:progress / 100.0 animated:NO];
    hud.detailText.text = [NSString stringWithFormat:@"%i%% Complete", progress];
    [hud reload:NO];
    
    if (progress >= 100) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_success"]];
            LGBIndicatorContentView *indicatorview = [[LGBIndicatorContentView alloc] initWithContentView:imgView];
            indicatorview.frame = CGRectMake(0, 0, 28, 28);
            hud.indicatorView = indicatorview;
            hud.text.text = @"success!";
            //            hud.detailText.text = nil;
            
            [hud reload:NO];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud dismiss];
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self incrementHUD:hud progress:progress];
        });
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
