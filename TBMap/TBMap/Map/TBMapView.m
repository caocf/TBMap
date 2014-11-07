//
//  TBMapView.m
//  TBMap
//
//  Created by libo on 11/7/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBMapView.h"

@implementation TBMapView

+(TBMapView *)loadMapOnView:(UIView *)superview withFrame:(CGRect)frame
{
    TBMapView *map = [[TBMapView alloc] initWithFrame:frame];
    if (superview) {
        [superview addSubview:map];
    }
    return map;
}

@end
