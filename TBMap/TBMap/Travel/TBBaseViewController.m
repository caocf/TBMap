//
//  TBBaseViewController.m
//  TBMap
//
//  Created by libo on 12/9/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBBaseViewController.h"

@interface TBBaseViewController ()

@end

@implementation TBBaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [self configNavigationBar];
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)configNavigationBar
{
    //返回
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右按钮
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightView ];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.leftView.backgroundColor = [UIColor greenColor];
    self.rightView .backgroundColor = [UIColor greenColor];

}

-(void)popToParentVC:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
