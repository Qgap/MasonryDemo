//
//  ScrollerViewController.m
//  MasonryDemo
//
//  Created by Mac on 16/6/15.
//  Copyright © 2016年 Gap. All rights reserved.
//

#import "ScrollViewController.h"
#import <Masonry.h>

static CGFloat gapValue = 20;

@interface ScrollViewController ()

@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UILabel *bottomLabel;

@property (nonatomic, assign)BOOL flag;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateButton setTitle:@"Click to update view" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [updateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:updateButton];
    
    [updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(30);
    }];

    self.bottomLabel = [self creatLabelWithFont:[UIFont systemFontOfSize:13]
                                      textColor:[UIColor blackColor]];
    [self.view addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(gapValue);
        make.right.mas_equalTo(self.view.mas_right).offset(-gapValue);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-gapValue);
    }];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(updateButton.mas_bottom).offset(gapValue);
        make.bottom.mas_equalTo(self.bottomLabel.mas_top).offset(-gapValue);
        make.left.mas_equalTo(self.view.mas_left).offset(gapValue);
        make.right.mas_equalTo(self.view.mas_right).offset(-gapValue);
    }];
    
    self.flag = NO;
    
    [self updateButtonAction:nil];
    
}


/**
 *  http://adad184.com/2015/12/01/scrollview-under-autolayout/
 *
 *  scroll view contentsize autolayout with the content
 */

- (void)updateButtonAction:(UIButton *)sender {
    
    for (UIView *subView in self.scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (sender) {
        [self updateAnimate];
    }
    
    self.flag = !self.flag;
    
    UIView *containerView = [[UIView alloc] init];
    [self.scrollView addSubview:containerView];
    
    [containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
    }];
    
    NSInteger randomNum = arc4random() % 10 +1;
    NSInteger randomBottomNum = arc4random() % 3 +1;
    
    NSString *string = @"人走到世界上，是用来体验的，无论出现什么样的问题，都是上天对你的考验，\n是在帮助你成长，进步，让这一切在往好的方向发展。";
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    
    UILabel *middleLabel = nil;
    
    for (int i = 0; i< randomNum; i ++) {
        
        UILabel *label = [self creatLabelWithFont:[UIFont systemFontOfSize:13]
                                        textColor:[UIColor whiteColor]];
        label.text = string;
        [containerView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(containerView);
            
            if (middleLabel) {
                make.top.mas_equalTo(middleLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(containerView.mas_top);
            }
            
        }];
        
        middleLabel = label;
        
        if (i < randomBottomNum) {
            [mutableString appendString:string];
        }
    }
    
    self.bottomLabel.text = mutableString;
    
    [containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(middleLabel.mas_bottom);
    }];
    
}


// masonry animate , updateConstraint first and after call layoutIfNeeded.

- (void)updateAnimate {

    if (self.flag) {
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.bottomLabel.mas_top).offset(-gapValue);
        }];
    } else {
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).offset(gapValue);
            make.right.mas_equalTo(self.view.mas_right).offset(-gapValue);
            make.bottom.mas_equalTo(self.bottomLabel.mas_top).offset(-gapValue*2);
        }];
    }
    
    [UIView animateWithDuration:2 animations:^{
        [self.scrollView layoutIfNeeded];
    }];
}

- (UILabel *)creatLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = font;
    label.textColor = textColor;
    return label;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    
    return _scrollView;
}


@end
