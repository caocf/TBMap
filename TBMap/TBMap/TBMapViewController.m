//
//  TBMapViewController.m
//  TBMap
//
//  Created by libo on 11/7/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBMapViewController.h"

@interface TBMapViewController ()

@end

@implementation TBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapManager = [[TBMapViewManager alloc] init];
    [mapManager addMapInViewController:self frame:CGRectMake(0, 20, 320, 450)];
    
    [self performSelector:@selector(showAnnotation) withObject:nil afterDelay:2];
    
}

-(void)showAnnotation
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    TBLocationModel *model = [[TBLocationModel alloc] init];
    model.coor = CLLocationCoordinate2DMake(40.035672, 116.350061);
    model.title = @"我在这里";
    model.subtitle = @"你好，我在这里";
    [array addObject:model];
    
    [mapManager refreshAnnotations:array];
}


@end
