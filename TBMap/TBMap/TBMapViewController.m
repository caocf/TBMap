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
    
    map = [TBMapView loadMapOnView:self.view withFrame:CGRectMake(0, 30, 320, 450)];
    
    
}




@end
