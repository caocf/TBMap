//
//  TBLocationModel.m
//  TBMap
//
//  Created by libo on 11/6/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBLocationModel.h"

@implementation TBLocationModel

-(NSString *)title
{
    if (_title) {
        return _title;
    }
    return @"未知";
}

-(NSString *)subtitle
{
    if (_subtitle) {
        return _subtitle;
    }
    return @"未知地点";
}

@end
