//
//  CenterViewController.m
//  MasonryDemo
//
//  Created by Mac on 16/6/15.
//  Copyright © 2016年 Gap. All rights reserved.
//

#import "CenterViewController.h"
#import <Masonry.h>

static float gap = 15;
static float height = 25;

@interface CenterViewController ()

@property (nonatomic, strong)UIView *containView;

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateButton setTitle:@"Click to update view" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [updateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:updateButton];
    
    [updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(30);
    }];
    
    self.containView = [[UIView alloc] init];
    self.containView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.containView];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(updateButton.mas_bottom).offset(gap);
    }];
    
    [self updateButtonAction];
    
}


- (void)updateButtonAction {
    
    for (UIView *subView in self.containView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSInteger randomNum = arc4random() % 20 +1;
    
    
    CGFloat heightGap = 0.f;
    CGFloat widthGap = 0.f;
    
    for (int i = 0 ; i < randomNum; i ++ ) {
        
        if (i >= 10) {
            heightGap = 30* (i/10);
            widthGap = 30 * (i - 10 *(i/10));
        } else {
            widthGap = 30*i;
        }
        
        UIImageView *avatarImage = [[UIImageView alloc] init];
        avatarImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.containView addSubview:avatarImage];
        avatarImage.image = [UIImage imageNamed:@"inviting_avatar"];
    
        [avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.containView.mas_top).offset(heightGap);
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.mas_equalTo(self.containView.mas_left).offset(widthGap);
        }];
        
        //--- super view update left constrain
        
        if (i == 0) {
            [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(avatarImage.mas_left);
            }];
        }
        
        //--- super view update right constrain
        
        if (randomNum <= 10 && i == randomNum -1) {
            [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(avatarImage.mas_right);
            }];
            
        } else {
            if (i == 9) {
                [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(avatarImage.mas_right);
                }];
            }
        }
        
  //--- update super view height
        
        if (i == randomNum - 1) {
            [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(heightGap + height);
            }];
        }
        
    }
}

@end
