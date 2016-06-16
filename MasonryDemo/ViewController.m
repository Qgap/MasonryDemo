//
//  ViewController.m
//  MasonryDemo
//
//  Created by Mac on 16/6/15.
//  Copyright © 2016年 Gap. All rights reserved.
//

#import "ViewController.h"

static NSString *const titleKey = @"title";
static NSString *const classNameKey = @"className";
static NSString *const cellId = @"CellId";

@interface ViewController ()

@property (nonatomic, strong)NSArray <__kindof NSDictionary *> *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@{titleKey:@"CenterSuperView",classNameKey:@"CenterViewController"},
                       @{titleKey:@"ScrollView-layout",classNameKey:@"ScrollViewController"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row][titleKey];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.dataArray[indexPath.row][classNameKey];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
