//
//  TBMapTool.m
//  TBMap
//
//  Created by libo on 11/7/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "TBMapTool.h"

@implementation TBMapTool

+ (NSArray *)createAnnotations:(NSArray *)items
{
    NSMutableArray *ans = [[NSMutableArray alloc] initWithCapacity:0];
    for (TBLocationModel *item in items) {
        
        TBMapAnnotation *an = [[TBMapAnnotation alloc] initWithPlace:item];
        [ans addObject:an];
    }
    return ans;
}

@end
