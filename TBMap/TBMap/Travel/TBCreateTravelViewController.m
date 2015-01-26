//
//  TBCeateTravelViewController.m
//  TBMap
//
//  Created by libo on 12/9/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBCreateTravelViewController.h"

@interface TBCreateTravelViewController ()

@end

@implementation TBCreateTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSStringFromCGRect(self.tableview.frame));
   
}

-(void)configNavigationBar
{
    [super configNavigationBar];
   
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = self.leftView.bounds;
    
    [leftBtn setImage:[UIImage imageNamed:@"backIcon.png"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"backIconH.png"] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(popToParentVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftView addSubview:leftBtn];
    

}


@end
